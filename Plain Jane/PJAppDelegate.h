//
//  PJAppDelegate.h
//  Plain Jane
//
//  Created by James Dumay on 19/02/13.
//  Copyright (c) 2013 James Dumay. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NSStatusItem+Iconology.h"
#import "StartAtLoginController.h"

@interface PJAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *_statusItem;
    StartAtLoginController *_startAtLoginController;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSMenu *statusMenu;
@property (strong) IBOutlet NSMenuItem *startAtLoginMenuItem;
@property (assign) BOOL enabled;

- (IBAction)enablePlainPastes:(id)sender;
- (IBAction)startAtLogin:(id)sender;
- (IBAction)quitApp:(id)sender;
- (IBAction)showAbout:(id)sender;

@end
