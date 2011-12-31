//
//  MissingPrivateKeyProblem.m
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import "MissingPrivateKeyProblem.h"
#import "CertificateAccess.h"

@implementation MissingPrivateKeyProblem

@synthesize certificatesWithoutIdentity;

- (NSString*)htmlDescription
{
	return @"<h1 class='red'>The following Certificates do not have a Private Key</h1>\n"
	"<p class='description'>In order to use a certificate for signing, you need the private keys of the certificates</p>\n"
	"<p class='help'>Please export the private key that are associated with the certificates on a mac, where they are available and then import the key to this mac</p>";
}
- (NSArray*)infoObjects
{
	return self.certificatesWithoutIdentity;
}

+ (void)load
{
	[self registerSubclass];
}
+ (id)problemIfExists
{
	CertificateAccess* access = [CertificateAccess certificateAccess];
	NSArray* allCertificates = [access thirdPartyCertificatesInList:[access availableCertificateNames]];
	NSArray* properCertificates = [access thirdPartyCertificatesInList:[access workingCertificateNames]];
	NSMutableArray* array = [NSMutableArray array];
	for (NSString* certificateName in allCertificates)
	{
		if ([properCertificates containsObject:certificateName] == NO)
		{
			[array addObject: certificateName];
		}
	};
	MissingPrivateKeyProblem* problem = nil;
	if ([array count])
	{
		problem = [self problem];
		NSLog(@"array: %@",array);
		problem.certificatesWithoutIdentity = array;
	}
	return problem;
}

- (ProblemSeverity)severity
{
	// used to sort the problems, the problem with the highest count is taken
	return high;
}

@end
