//
//  CertificateProblem.h
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	veryLow = 0,
	low,
	medium,
	high,
	veryHigh
} ProblemSeverity;

@interface CertificateProblem : NSObject {

}

+ (id)currentProblem;

- (NSString*)htmlDescription;
- (NSArray*)infoObjects;

+ (id)problem;
+ (id)problemIfExists;
+ (void)registerSubclass;
- (ProblemSeverity)severity;

@end
