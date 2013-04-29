//
//  PJAppDelegate.m
//  Plain Jane
//
//  Created by James Dumay on 19/02/13.
//  Copyright (c) 2013 James Dumay. All rights reserved.
//

#import "PJAppDelegate.h"

@implementation PJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _startAtLoginController = [[StartAtLoginController alloc] initWithIdentifier:@"com.whimsy.PlainJaneHelperApp"];
    [_startAtLoginMenuItem setState:(_startAtLoginController.enabled ? NSOnState : NSOffState)];
    
    _enabled = YES;
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setIcon:[NSImage imageNamed:@"status-item-menu"] withAlternateIcon:[NSImage imageNamed:@"status-item-menu-alt"]];
    [_statusItem setHighlightMode:YES];
    [_statusItem setMenu:_statusMenu];
   
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *event) {
        
        //Do not turn on if its not enabled or finder is active
        
        NSUInteger flags = [event modifierFlags];
        int altDown = flags & NSCommandKeyMask;
        
        //Command + V
        if (([event keyCode] == 9) && altDown) {
            
            if (_enabled && ![self isFinderActive])
            {
                NSPasteboard *pboard = [NSPasteboard generalPasteboard];
                
                NSString* value = [pboard stringForType:NSStringPboardType];
                
                if (value) {
                    [pboard clearContents];
                    [pboard setString:value forType:NSStringPboardType];
                }
            }
        }
    }];
    
    if (![_startAtLoginController enabled])
    {
        [_mainWindow makeKeyAndOrderFront:self];
        [NSApp activateIgnoringOtherApps:YES];
    }
}

- (BOOL)isFinderActive
{
    NSArray *finderApps = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.finder"];
    
    if (finderApps.count >= 1)
    {
        NSRunningApplication *finder = [finderApps lastObject];
        return finder.isActive;
    }
    return NO;
}

- (IBAction)hideMainWindow:(id)sender
{
    [_mainWindow close];
}

- (IBAction)closeApp:(id)sender
{
    [[NSApplication sharedApplication] terminate:self];
}

-(void)showAbout:(id)sender
{
    [[NSApplication sharedApplication] orderFrontStandardAboutPanel:self];
}

- (IBAction)showHelp:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://whimsyapps.uservoice.com/knowledgebase/topics/31642-plain-jane"]];
}

- (IBAction)startAtLoginChecked:(id)sender
{
    [self startAtLogin:_startAtLoginMenuItem];
}

-(void)startAtLogin:(id)sender
{
    NSMenuItem *item = sender;
    [_startAtLoginController setStartAtLogin:[self swizzleState:item]];
}

- (IBAction)enablePlainPastes:(id)sender
{
    NSMenuItem *item = sender;
    _enabled = [self swizzleState:item];
}

-(BOOL)swizzleState:(NSMenuItem*)item
{
    if (item.state == NSOnState)
    {
        [item setState:NSOffState];
    }
    else if (item.state == NSOffState)
    {
        [item setState:NSOnState];
    }
    return (item.state == NSOnState);
}

@end