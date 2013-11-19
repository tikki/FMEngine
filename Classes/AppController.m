//
//  AppController.m
//  FMEngine
//
//  Created by Nicolas Haunold on 4/29/09.
//  Copyright 2009 Tapolicious Software. All rights reserved.
//

#import "AppController.h"
#import "FMEngine.h"

@implementation AppController {
	FMEngine *fmEngine;
	FMEngineSession *fmSession;
}

- (void)awakeFromNib {
	fmEngine = [FMEngine engineWithApiKey:@"yourapikey" apiSecret:@"yourapisecret"];
	fmSession = [fmEngine sessionWithTarget:self action:@selector(sessionEstablished:) username:@"yourusername" password:@"yourpassword"];
}

- (void)sessionEstablished:(FMEngineSession *)session {
	NSMutableArray *list = [NSMutableArray array];
	for (int i = 0; i < 15; ++i) {
		FMEngineTrackParams *params = [FMEngineTrackParams paramsWithArtist:@"Test Artist" track:@"Test Track"];
		params.timestamp = [NSNumber numberWithUnsignedInt:[[NSDate date] timeIntervalSince1970] - i * 120];
		[list addObject:params];
	}
	[session scrobbleManyWithTarget:self action:@selector(logCallback:data:) tracks:list];
}

- (void)logCallback:(NSString *)identifier data:(id)data {
	// data is either NSData or NSError
	NSLog(@"Got Data (%@): %@", identifier, data);
}

@end
