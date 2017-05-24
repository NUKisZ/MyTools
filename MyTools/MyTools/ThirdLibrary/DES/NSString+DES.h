//
//  NSString+DES.h
//  DaoDao
//
//  Created by hetao on 2016/12/5.
//  Copyright © 2016年 soouya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (DES)

- (NSString *)encrypt;
- (NSString *)decrypt;

@end
