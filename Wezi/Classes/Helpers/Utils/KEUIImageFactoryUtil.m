//
//  KEUIImageFactoryUtil.m
//  Wezi
//
//  Created by Каркан Евгений on 31.05.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "KEUIImageFactoryUtil.h"

@implementation KEUIImageFactoryUtil


+ (UIImage *)imageDependsOnURL:(NSString *)URLString
{
    UIImage *icon = nil;
    //day icons
    if ([URLString rangeOfString:@"clear"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_sun.png"];
    }
    if ([URLString rangeOfString:@"chanceflurries"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_snow.png"];
    }
    if ([URLString rangeOfString:@"chancerain"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_rain.png"];
    }
    if ([URLString rangeOfString:@"chancesleet"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_rain_and_snow.png"];
    }
    if ([URLString rangeOfString:@"chancesnow"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_snow.png"];
    }
    if ([URLString rangeOfString:@"chancetstorms"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_cloud_thunder_rain.png"];
    }
    if ([URLString rangeOfString:@"cloudy"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_max_cloud.png"];
    }
    if ([URLString rangeOfString:@"flurries"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_snow.png"];
    }
    if ([URLString rangeOfString:@"fog"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_fog.png"];
    }
    if ([URLString rangeOfString:@"hazy"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_fog.png"];
    }
    if ([URLString rangeOfString:@"mostlycloudy"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_sun_maximum_clouds.png"];
    }
    if ([URLString rangeOfString:@"mostlysunny"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_sun_minimal_clouds.png"];
    }
    if ([URLString rangeOfString:@"partlycloudy"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_cloud_sun.png"];
    }
    if ([URLString rangeOfString:@"partlysunny"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_cloud_sun.png"];
    }
    if ([URLString rangeOfString:@"rain"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_rain.png"];
    }
    if ([URLString rangeOfString:@"sleet"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_rain_and_snow.png"];
    }
    if ([URLString rangeOfString:@"snow"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_snow.png"];
    }
    if ([URLString rangeOfString:@"sunny"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_sun.png"];
    }
    if ([URLString rangeOfString:@"tstorms"].location != NSNotFound) {
        icon = [UIImage imageNamed:@"DayRetina.bundle/weezle_cloud_thunder_rain.png"];
    }
    //night icons
    
    return icon;
}

@end

    //daily mapping

//chanceflurries  >  weezle_snow.png
//chancerain  >  weezle_rain.png
//chancesleet  >  weezle_rain_and_snow.png
//chancesnow  >  weezle_snow.png
//chancetstorms  >  weezle_cloud_thunder_rain.png
//clear  >  weezle_sun.png
//cloudy  >  weezle_max_cloud.png
//flurries  >  weezle_snow.png
//fog > weezle_fog.png
//hazy > weezle_fog.png
//mostlycloudy  >  weezle_sun_maximum_clouds.png
//mostlysunny >  weezle_sun_minimal_clouds.png
//partlycloudy > weezle_cloud_sun.png
//partlysunny  >  weezle_cloud_sun.png
//rain > weezle_rain.png
//sleet > weezle_rain_and_snow.png
//snow >  weezle_snow.png
//sunny > weezle_sun.png
//tstorms > weezle_cloud_thunder_rain.png

