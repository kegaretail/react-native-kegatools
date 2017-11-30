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


RCT_EXPORT_METHOD(getThumbnail:(NSString *)path callback:(RCTResponseSenderBlock)callback)
{
    
    NSURL *url = [NSURL fileURLWithPath:path];

    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];

    NSString *filename = [NSString stringWithFormat:@"%@.png", asset.URL.lastPathComponent];

    //  Get thumbnail at the very start of the video
    CMTime thumbnailTime = [asset duration];
    thumbnailTime.value = 0;

    //  Get image from the video at the given time
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];

    NSError* error;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:thumbnailTime actualTime:NULL error:&error];
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
