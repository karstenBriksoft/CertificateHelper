//
//  CertificateHelperAppDelegate.m
//  CertificateHelper
//
//  Created by Karsten Kusche on 30.12.11.
//  Copyright 2011 Briksoftware.com. All rights reserved.
//

#import "CertificateHelperAppDelegate.h"
#import "CertificateProblem.h"

@implementation CertificateHelperAppDelegate

@synthesize window, currentProblem;

- (NSString*)htmlStringForBody:(NSString*)body
{
	return [NSString stringWithFormat: 
			@"<?xml version='1.0' encoding='UTF-8'?>\n"
			"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.1//EN' 'http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd'>\n"
			"<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en'>\n"
			"<head>\n"
			"<title>Current Problem</title>\n"
			"<link type='text/css' rel='stylesheet' href='style.css' />\n"
			"</head>\n"
			"<body>%@ </body> </html>", body];
}

- (void)updateUI
{
	[table reloadData];
	NSURL* baseURL = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:@"html"];
	
	NSString* htmlString = [self htmlStringForBody: [self.currentProblem htmlDescription]];
	[[webView mainFrame] loadHTMLString:htmlString baseURL:baseURL];
}

- (void)checkForProblems
{
	CertificateProblem* problem = [CertificateProblem currentProblem];
	self.currentProblem = problem;
	[self updateUI];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self checkForProblems];
	[webView setPolicyDelegate:self];
}

- (IBAction)checkForProblems:(id)sender
{
	[self checkForProblems];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	if (self.currentProblem == nil) return 0;
	NSArray* infoObjects = [self.currentProblem infoObjects];
	return [infoObjects count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSArray* infoObjects = [self.currentProblem infoObjects];
	return [infoObjects objectAtIndex: row];
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation
		request:(NSURLRequest *)request
		  frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
	NSURL* url = [request URL];
	if ([url isFileURL]) 
	{
		[listener use];
		return;
	}
	// non file urls are opened in Safari
	[[NSWorkspace sharedWorkspace ] openURL:url];
	[listener ignore];
}
@end
