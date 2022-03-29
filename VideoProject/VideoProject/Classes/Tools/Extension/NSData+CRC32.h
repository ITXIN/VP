//
//  NSData+CRC32.h
//  VideoProject
//
//  Created by ITXX on 2018/3/8.
//  Copyright © 2018年 icoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>
@interface NSData (CRC32)
-(int32_t)crc_32;

-(uLong)getCRC32;
@end
