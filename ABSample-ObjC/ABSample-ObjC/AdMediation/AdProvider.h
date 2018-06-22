//
//  AdProvider.h
//  ABSample-ObjC
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, AdType) {
    AdTypeBanner = 1,
    AdTypeInterstitial,
    AdTypeRewardedVideo
};

@protocol AdProvider <NSObject>

- (void)prepare;
- (BOOL)hasReadyAd:(AdType)type;
- (void)presentAd:(AdType)type rootViewController:(UIViewController *)rootViewController;

@end
