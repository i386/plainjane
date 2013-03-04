//
//  PJAppDelegate.h
//  Plain Jane
//
//  Created by James Dumay on 19/02/13.
//  Copyright (c) 2013 James Dumay. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NSStatusItem+Iconology.h"

@interface PJAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *_statusItem;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSMenu *statusMenu;
@property (assign) BOOL enabled;

- (IBAction)enablePlainPastes:(id)sender;
- (IBAction)quitApp:(id)sender;

@end
