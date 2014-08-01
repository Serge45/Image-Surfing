//
//  ISAppDelegate.h
//  Image Surfing
//
//  Created by Serge Lu on 2014/7/5.
//  Copyright (c) 2014年 Serge Lu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ISAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (retain) NSImage *currentImage;
@property (retain) NSMutableArray *imageList;
@property (retain) NSMutableArray *imageNames;
@property (nonatomic, assign) int curImageIdx;
@property (retain) NSString *titlePrefix;
@property (assign) BOOL showRealSize;

- (IBAction)openFileClickedFor:(id)sender;
- (IBAction)toNextImage:(id)sender;
- (IBAction)toPreviousImage:(id)sender;
- (IBAction)toFirstImage:(id)sender;
- (IBAction)toLastImage:(id)sender;
@end
