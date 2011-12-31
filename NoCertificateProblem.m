//
//  NoCertificateProblem.m
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import "NoCertificateProblem.h"


@implementation NoCertificateProblem

+(void)load
{
	[self registerSubclass];
}

- (NSString*)htmlDescription
{
	return @"<h1 class='green'>No Problems</h1>";
}

+ (id)problemIfExists
{
	// no problem is always valid, but if there's a more sever problem, the other problem is taken
	return [self problem];
}

- (ProblemSeverity)severity
{
	return veryLow;
}

@end
