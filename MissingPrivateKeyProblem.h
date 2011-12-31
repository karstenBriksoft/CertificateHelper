//
//  MissingPrivateKeyProblem.h
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CertificateProblem.h"

@interface MissingPrivateKeyProblem : CertificateProblem {
	NSArray* certificatesWithoutIdentity;
}

@property (retain) NSArray* certificatesWithoutIdentity;

@end
