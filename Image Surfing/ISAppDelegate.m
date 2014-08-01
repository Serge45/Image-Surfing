//
//  ISAppDelegate.m
//  Image Surfing
//
//  Created by Serge Lu on 2014/7/5.
//  Copyright (c) 2014年 Serge Lu. All rights reserved.
//

#import "ISAppDelegate.h"

@implementation ISAppDelegate

@synthesize currentImage;
@synthesize imageView;
@synthesize scrollView;
@synthesize imageList;
@synthesize imageNames;
@synthesize window;
@synthesize titlePrefix;
@synthesize showRealSize;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    window.delegate = self;//resize signal processed by self
    scrollView.documentView = imageView;
    titlePrefix = @("Image Surfing");
    _curImageIdx = -1;
    showRealSize = NO;
    [self updateImageViewSize];
}

- (IBAction)openFileClickedFor:(id)sender {
    NSArray *allowedTypes = [[NSArray alloc] initWithObjects: @("jpg"),
                                                              @("png"),
                                                              @("bmp"),
                                                              @("tiff"), nil];
    
    
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    openPanel.allowsMultipleSelection = YES;
    openPanel.canChooseDirectories = NO;
    openPanel.canChooseFiles = YES;
    openPanel.allowedFileTypes = allowedTypes;
    NSInteger result = [openPanel runModal];
    
    if (result == NSFileHandlingPanelOKButton) {
        if (!imageList) {
            imageList = [[NSMutableArray alloc] init];
        }
        
        if (!imageNames) {
            imageNames = [[NSMutableArray alloc] init];
        }
        
        [imageList removeAllObjects];
        [imageNames removeAllObjects];
        
        for (NSURL *s in openPanel.URLs) {
            NSString *path = s.path;
            [imageList addObject: [[NSImage alloc] initWithContentsOfFile: path]];
            [imageNames addObject: path];
        }
        
        self.curImageIdx = 0;
    }
}

- (IBAction)toNextImage:(id)sender {
    self.curImageIdx = _curImageIdx + 1;
}

- (IBAction)toPreviousImage:(id)sender {
    self.curImageIdx = _curImageIdx - 1;
}

- (void)setCurImageIdx:(int)idx {
    if (idx >= 0 && idx < imageList.count) {
        _curImageIdx = idx;
        imageView.image = imageList[idx];
        window.title = [[NSString alloc] initWithFormat: @("%@(%@)"), titlePrefix, imageNames[idx]];
    }
}

- (IBAction)toFirstImage:(id)sender {
    self.curImageIdx = 0;
}

- (IBAction)toLastImage:(id)sender {
    self.curImageIdx = (int)imageList.count - 1;
}

- (void)updateImageViewSize {
    if (showRealSize) {
        
    } else {
        NSRect imageFrame = scrollView.frame;
        imageFrame.size.width -= scrollView.verticalScroller.frame.size.width;
        imageFrame.size.height -= scrollView.horizontalScroller.frame.size.height;
        [imageView setFrame: imageFrame];
    }
}

- (void)windowDidResize:(NSNotification *)notification {
    [self updateImageViewSize];
}

@end
