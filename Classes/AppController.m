//
//  AppController.m
//  FMEngine
//
//  Created by Nicolas Haunold on 4/29/09.
//  Copyright 2009 Tapolicious Software. All rights reserved.
//

#import "AppController.h"

@implementation AppController

- (void)awakeFromNib {
	fmEngine = [[FMEngine alloc] init];
	fmEngine.apiKey = @"yourapikey";
	fmEngine.apiSecret = @"yourapisecret";
	NSString *authToken = [fmEngine generateAuthTokenFromUsername:@"yourusername" password:@"yourpassword"];
	NSDictionary *urlDict = @[@"username": @"yourusername", @"authToken": authToken];
	[fmEngine performMethod:@"auth.getMobileSession" withTarget:self withParameters:urlDict andAction:@selector(loginCallback:data:) useSignature:YES httpMethod:POST_TYPE];	
}

- (void)loginCallback:(NSString *)identifier data:(id)data {
	// data is either NSData or NSError
	NSLog(@"Got Data (%@): %@", identifier, data);
}

@end
