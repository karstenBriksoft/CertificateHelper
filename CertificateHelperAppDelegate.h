//
//  CertificateHelperAppDelegate.h
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class CertificateProblem;

@interface CertificateHelperAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource> {
    NSWindow *window;
	IBOutlet NSTableView* table;
	IBOutlet WebView* webView;
	CertificateProblem* currentProblem;
}

@property (assign) IBOutlet NSWindow* window;
@property (retain) CertificateProblem* currentProblem;

- (IBAction)checkForProblems:(id)sender;

@end
