//
//  CertificateProblem.m
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import "CertificateProblem.h"


@implementation CertificateProblem


- (NSString*)htmlDescription
{
	return @"erm... nothing wrong, everything should work";
}

- (NSArray*)infoObjects
{
	return [NSArray array];
}

+ (NSMutableDictionary*)subclassRegistry
{
	static NSMutableDictionary* subclassRegistry = nil;
	if (subclassRegistry == nil)
	{
		subclassRegistry = [NSMutableDictionary dictionary];
		[subclassRegistry retain];
	}
	return subclassRegistry;
}

+ (void)registerSubclass
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[[self subclassRegistry] setObject: self forKey:[self className]];
	[pool drain];
}

+ (id)currentProblem
{
	NSMutableArray* problems = [NSMutableArray array];
	for (Class problemClass in [[self subclassRegistry] allValues])
	{
		id problem = [problemClass problemIfExists];
		if (problem)
		{
			[problems addObject: problem];
		}
	}
	[problems sortedArrayUsingSelector:@selector(severity)];
	return [problems lastObject];
}

+ (id)problem
{
	CertificateProblem* problem = [[self alloc] init];
	[problem autorelease];
	return problem;
}

+ (id)problemIfExists
{
	// if the problem exists, return an instance. Otherwise return nil; 
	return nil;
}

- (ProblemSeverity)severity
{
	// used to sort the problems, the problem with the highest count is taken
	return veryLow;
}

@end
