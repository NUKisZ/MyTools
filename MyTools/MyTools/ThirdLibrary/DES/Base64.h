//
//  Base64.h
//  DaoDao
//
//  Created by hetao on 2016/12/6.
//  Copyright © 2016年 soouya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject
+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)data;

@end
