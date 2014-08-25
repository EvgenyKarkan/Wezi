//
//  KEUIImageFactoryUtil.m
//  Wezi
//
//  Created by Evgeniy Karkan on 31.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEUIImageFactoryUtil.h"


@implementation KEUIImageFactoryUtil;

+ (UIImage *)imageDependsOnURL:(NSString *)URLString bundleName:(NSString *)bundleName
{
	UIImage *icon = nil;
	if ([URLString rangeOfString:@"clear"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_fullmoon.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_sun.png"]];
		}
	}
	if ([URLString rangeOfString:@"chanceflurries"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_flurry.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_snow.png"]];
		}
	}
	if ([URLString rangeOfString:@"chancerain"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_rain.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_rain.png"]];
		}
	}
	if ([URLString rangeOfString:@"chancesleet"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_rain.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_rain_and_snow.png"]];
		}
	}
	if ([URLString rangeOfString:@"chancesnow"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_and_snow.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_snow.png"]];
		}
	}
	if ([URLString rangeOfString:@"chancetstorms"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_thunder_rain.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_cloud_thunder_rain.png"]];
		}
	}
	if ([URLString rangeOfString:@"cloudy"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_moon_cloud.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_max_cloud.png"]];
		}
	}
	if ([URLString rangeOfString:@"flurries"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_flurry.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_snow.png"]];
		}
	}
	if ([URLString rangeOfString:@"fog"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_fog.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_fog.png"]];
		}
	}
	if ([URLString rangeOfString:@"hazy"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_fog.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_fog.png"]];
		}
	}
	if ([URLString rangeOfString:@"mostlycloudy"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_moon_cloud_medium.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_sun_maximum_clouds.png"]];
		}
	}
	if ([URLString rangeOfString:@"mostlysunny"].location != NSNotFound) {
		icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_sun_minimal_clouds.png"]];
	}
	if ([URLString rangeOfString:@"partlycloudy"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_moon_cloud.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_cloud_sun.png"]];
		}
	}
	if ([URLString rangeOfString:@"partlysunny"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_moon_cloud.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_cloud_sun.png"]];
		}
	}
	if ([URLString rangeOfString:@"rain"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_rain.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_rain.png"]];
		}
	}
	if ([URLString rangeOfString:@"sleet"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_rain.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_rain_and_snow.png"]];
		}
	}
	if ([URLString rangeOfString:@"snow"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_and_snow.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_snow.png"]];
		}
	}
	if ([URLString rangeOfString:@"sunny"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_fullmoon.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_sun.png"]];
		}
	}
	if ([URLString rangeOfString:@"tstorms"].location != NSNotFound) {
		if ([URLString rangeOfString:@"nt"].location != NSNotFound) {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_night_thunder_rain.png"]];
		}
		else {
			icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_cloud_thunder_rain.png"]];
		}
	}
	if ([URLString rangeOfString:@"nt_mostlycloudy"].location != NSNotFound) {
		icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundleName, @"/weezle_moon_cloud_medium.png"]];
	}
	
	return icon;
}

@end
