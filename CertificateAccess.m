//
//  CertificateAccess.m
//  CertificateHelper
//
//  Created by Karsten Kusche on 31.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import "CertificateAccess.h"

OSStatus SecIdentitySearchCreateWithPolicy(SecPolicyRef policy, CFStringRef idString, CSSM_KEYUSE keyUsage, CFTypeRef keychainOrArray, Boolean returnOnlyValidIdentities, SecIdentitySearchRef* searchRef);

OSStatus SecPolicyCopy(CSSM_CERT_TYPE certificateType, const CSSM_OID *policyOID, SecPolicyRef* policy);

@implementation CertificateAccess

+ (id)certificateAccess
{
	CertificateAccess* access = [[self alloc] init];
	[access autorelease];
	return access;
}

- (NSArray*)certificatesForPolicyID:(const CSSM_OID *)policyOID usage: (CSSM_KEYUSE)usage
{
	NSMutableArray* result = [NSMutableArray array];
	SecPolicyRef policy;
	SecIdentitySearchRef searchRef;
	SecPolicyCopy(CSSM_CERT_X_509v3, policyOID, &policy);
	SecIdentitySearchCreateWithPolicy(policy, NULL, usage, NULL, false, &searchRef);
	
	SecIdentityRef identity;
	OSStatus rc;
	while ((rc = SecIdentitySearchCopyNext(searchRef, &identity)) == noErr)
	{
		SecCertificateRef cert;
		SecIdentityCopyCertificate(identity, &cert);
		CFStringRef name;
		SecCertificateCopyCommonName(cert, &name);
		[result addObject:(NSString*)name];
		CFRelease(name);
	}
	return result;
}

- (NSArray*)workingCertificateNames
{
	NSMutableArray* results = [NSMutableArray array];
	[results addObjectsFromArray: [self certificatesForPolicyID: &CSSMOID_APPLE_TP_CODE_SIGNING 
														  usage: CSSM_KEYUSE_ANY]];
	[results addObjectsFromArray: [self certificatesForPolicyID: &CSSMOID_APPLE_X509_BASIC 
														  usage: CSSM_KEYUSE_ANY]];
	return results;
}

- (NSString*)nameOfItem:(SecKeychainItemRef) item
{
	UInt32 attributeTags[1];
	*attributeTags = kSecLabelItemAttr;
	
	UInt32 formatConstants[1];
	*formatConstants = CSSM_DB_ATTRIBUTE_FORMAT_STRING; //From "cssmtype.h" under "CSSM_DB_ATTRIBUTE_FORMAT".
	
	SecKeychainAttributeInfo attributeInfo;
	
	attributeInfo.count = 1;
	attributeInfo.tag = attributeTags;
	attributeInfo.format = formatConstants;
	
	SecKeychainAttributeList *attributeList = nil;
	OSStatus attributeStatus = SecKeychainItemCopyAttributesAndData(item, &attributeInfo, NULL, &attributeList, 0, NULL);
	if (attributeStatus != noErr || !item)
	{
		return nil;
	}
	
	SecKeychainAttribute accountNameAttribute = attributeList->attr[0];
	
	return [[[NSString alloc] initWithData:[NSData dataWithBytes:accountNameAttribute.data length:accountNameAttribute.length] encoding:NSUTF8StringEncoding] autorelease];
}

- (NSArray*)availableCertificateNames
{
	NSMutableArray* result = [NSMutableArray array];
	SecKeychainSearchRef keychainSearch;
	SecKeychainSearchCreateFromAttributes(NULL, kSecCertificateItemClass, NULL, &keychainSearch);
	
	SecKeychainItemRef itemRef;
	
	OSStatus rc;
	while (( rc = SecKeychainSearchCopyNext (keychainSearch, &itemRef)) == noErr)
	{
		NSString* name = [self nameOfItem: itemRef];
		[result addObject: name];
		CFRelease(itemRef);
	}
	
	CFRelease(keychainSearch);
	return result;
}

- (NSArray*)thirdPartyCertificatesInList:(NSArray*)certificateNames
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[s] '3rd'"];
	return [certificateNames filteredArrayUsingPredicate:predicate];
}
@end
