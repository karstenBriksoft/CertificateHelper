//
//  CertificateAccess.h
//  CertificateHelper
//
//  Created by Karsten Kusche on 31.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CertificateAccess : NSObject {

}

+ (id)certificateAccess;
- (NSArray*)certificatesForPolicyID:(const CSSM_OID *)policyOID usage: (CSSM_KEYUSE)usage;
- (NSArray*)workingCertificateNames;
- (NSString*)nameOfItem:(SecKeychainItemRef) item;
- (NSArray*)availableCertificateNames;
- (NSArray*)thirdPartyCertificatesInList:(NSArray*)certificateNames;
@end
