//
//  AppodealProvider.m
//  ABSample-ObjC
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "AppodealProvider.h"
@import Appodeal;

// Constants
static NSString * const kAppodealApiKey             = @"Put your api key here";
static NSString * const kAppodealDefaultPlacement   = @"default";
static BOOL const kHasUserConsent                   = YES;
static AppodealAdType const kAppodealAdTypes        = AppodealAdTypeBanner | AppodealAdTypeInterstitial | AppodealAdTypeRewardedVideo;


AppodealAdType AppodealAdTypeFromType(AdType type) {
    switch (type) {
        case AdTypeBanner:          return AppodealAdTypeBanner; break;
        case AdTypeInterstitial:    return AppodealAdTypeInterstitial; break;
        case AdTypeRewardedVideo:   return AppodealAdTypeRewardedVideo; break;
    }
}

AppodealShowStyle AppodealShowStyleFromType(AdType type) {
    switch (type) {
        case AdTypeBanner:          return AppodealShowStyleBannerBottom; break;
        case AdTypeInterstitial:    return AppodealShowStyleInterstitial; break;
        case AdTypeRewardedVideo:   return AppodealShowStyleRewardedVideo; break;
    }
}

@implementation AppodealProvider

- (void)prepare {
    [Appodeal initializeWithApiKey:kAppodealApiKey
                             types:kAppodealAdTypes
                        hasConsent:kHasUserConsent];
}

- (BOOL)hasReadyAd:(AdType)type {
    return [Appodeal canShow:AppodealAdTypeFromType(type) forPlacement:kAppodealDefaultPlacement];
}

- (void)presentAd:(AdType)type rootViewController:(UIViewController *)rootViewController {
    [Appodeal showAd:AppodealShowStyleFromType(type)
        forPlacement:kAppodealDefaultPlacement
  rootViewController:rootViewController];
}

@end
