//
//  MoPubProvider.m
//  ABSample-ObjC
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "MoPubProvider.h"
#import <MoPubSDK/MoPub.h>

static NSString * const kMoPubInterstitialAdUnit        = @"";
static NSString * const kMoPubRewardedAdUnit            = @"";
static NSString * const kMoPubBannerAdUnit              = @"";

@interface MoPubProvider ()

@property (nonatomic, strong) MPAdView * bannerView;
@property (nonatomic, strong) MPInterstitialAdController * interstitial;

@end

@implementation MoPubProvider

- (void)prepare {
    // Load interstitial
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:kMoPubInterstitialAdUnit];
    [self.interstitial loadAd];
    // Load banner view
    self.bannerView = [[MPAdView alloc] initWithAdUnitId:kMoPubBannerAdUnit
                                                    size:MOPUB_BANNER_SIZE];
    [self.bannerView loadAd];
    // Load rewarded video
    [MoPub.sharedInstance initializeRewardedVideoWithGlobalMediationSettings:nil delegate:nil];
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:kMoPubRewardedAdUnit withMediationSettings:nil];
}

- (BOOL)hasReadyAd:(AdType)type {
    BOOL hasReadyAd = NO;
    switch (type) {
        case AdTypeBanner: {
            // Force availability of banner
            hasReadyAd = YES;
            break; }
        case AdTypeRewardedVideo: {
            hasReadyAd = [MPRewardedVideo hasAdAvailableForAdUnitID:kMoPubRewardedAdUnit];
            break; }
        case AdTypeInterstitial: {
            hasReadyAd = self.interstitial.ready;
            break; }
    }
    return hasReadyAd;
}

- (void)presentAd:(AdType)type rootViewController:(UIViewController *)rootViewController {
    switch (type) {
        case AdTypeInterstitial: {
            [self.interstitial showFromViewController:rootViewController];
            break; }
        case AdTypeBanner: {
            [rootViewController.view addSubview:self.bannerView];
            break; }
        case AdTypeRewardedVideo: {
            [MPRewardedVideo presentRewardedVideoAdForAdUnitID:kMoPubRewardedAdUnit
                                            fromViewController:rootViewController
                                                    withReward:nil];
            break; }
    }
}

- (void)layoutBannerOnView:(UIView *)view {
    if ([view.subviews containsObject:self.bannerView]) {
        return
    }
    
    CGSize size = [self.bannerView adContentViewSize];
    CGRect newFrame = view.frame;
    newFrame.size = size;
    newFrame.origin.x = (view.bounds.size.width - size.width) / 2;
    newFrame.origin.y = (view.bounds.size.height - size.height);
    self.bannerView.frame = newFrame;
    [view addSubview:self.bannerView];
}

@end
