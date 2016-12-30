//
//  KEUIImageFactoryUtil.h
//  Wezi
//
//  Created by Evgeny Karkan on 31.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface KEUIImageFactoryUtil : NSObject

+ (UIImage *)imageDependsOnURL:(NSString *)URLString
					bundleName:(NSString *)bundleName;

@end
