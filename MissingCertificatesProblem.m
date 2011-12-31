//
//  MissingCertificatesProblem.m
//  CertificateHelper
//
//  Created by Karsten Kusche on 31.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import "MissingCertificatesProblem.h"
#import "CertificateAccess.h"

@implementation MissingCertificatesProblem

- (NSString*)htmlDescription
{
	return @"<h1 class='red'>There're no proper Certificates on your system</h1>\n"
	"<p class='description'>You don't have certificates on your system that are named like '3rd Party...'</p>\n"
	"<p class='help'>Please go to <a href='https://developer.apple.com/membercenter/'>https://developer.apple.com/membercenter/</a> and download the certificates</p>";
}

+ (void)load
{
	[self registerSubclass];
}

+ (id)problemIfExists
{
	CertificateAccess* access = [CertificateAccess certificateAccess];
	NSArray* allCertificates = [access developerCertificatesInList:[access availableCertificateNames]];

	
	MissingCertificatesProblem* problem = nil;
	if ([allCertificates count] == 0)
	{
		problem = [self problem];
	}
	return problem;
}

- (ProblemSeverity)severity
{
	// used to sort the problems, the problem with the highest count is taken
	return veryHigh;
}

@end
