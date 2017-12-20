//
//  KegaTools.m
//  KegaTools
//
//  Created by Tim Honders on 30/11/2017.
//  Copyright © 2017 Tim Honders. All rights reserved.
//

#import "KegaVideo.h"

@implementation KegaVideo

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();


RCT_EXPORT_METHOD(getThumbnail:(NSString *)path seconds:(int64_t *)seconds callback:(RCTResponseSenderBlock)callback)
{
    
    NSURL *url = [NSURL fileURLWithPath:path];

    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];

    NSString *filename = [NSString stringWithFormat:@"%@.png", asset.URL.lastPathComponent];

    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;

    NSError* error;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:CMTimeMake(seconds, 1) actualTime:NULL error:&error];
    if (error) NSLog(@"imageGenerator error: %@", error);

    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *thumbnail_path = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];

    // Save image.
    [UIImagePNGRepresentation(thumbnail) writeToFile:thumbnail_path atomically:YES];
    
    NSDictionary *response = @{
        @"path": thumbnail_path,
        @"filename": filename
    };
        
    callback(@[response]);

}

@end
