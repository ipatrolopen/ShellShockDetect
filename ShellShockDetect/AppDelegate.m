//
//  AppDelegate.m
//  ShellShockDetect
//
//  Created by Roman Plasil on 26/9/14.
//  Copyright (c) 2014 ipatrol. All rights reserved.
//

#include <stdlib.h>
#import "AppDelegate.h"

@interface AppDelegate ()
@property (strong) IBOutlet NSImageView *imgSafe;
@property (strong) IBOutlet NSTextField *tStatus;
@property (strong) IBOutlet NSImageView *imgVulnerable;

@property () IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    
    // Insert code here to initialize your application
    NSString *tmp = [[[NSProcessInfo processInfo] environment] objectForKey:@"TMPDIR"];
    NSString *detect_file = [tmp stringByAppendingPathComponent:@"ipatrol_detect.txt"];
    [[NSFileManager defaultManager] removeItemAtPath: detect_file error:nil];
    
    setenv("IPATROL_DETECT", "() { :;} ; echo vulnerable > $TMPDIR/ipatrol_detect.txt", 1);
    system("ls");
    //system("sh -c echo \"$IPATROL_DETECT\"");
    
    BOOL vuln = [[NSFileManager defaultManager] fileExistsAtPath:detect_file];
    NSLog(@"%i", vuln);
    
    if (vuln) {
        [self displayVulnerable];
    } else {
        [self displaySafe];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)bMoreInfo:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"http://www.macsafe.info"]];

    
}

- (void)displaySafe {
    [self.tStatus setStringValue:@"Your computer is safe."];
    [self.imgSafe setHidden: FALSE];
  
}

- (void)displayVulnerable {
    [self.tStatus setStringValue:@"Your computer is vulnerable to the ShellShock bug. Click More information for updates."];
    [self.imgVulnerable setHidden:FALSE];
}

- (IBAction)bQuitClick:(NSButton *)sender {
    [NSApp terminate:self];
}
@end
