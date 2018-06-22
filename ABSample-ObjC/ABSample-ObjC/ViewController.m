//
//  ViewController.m
//  ABSample-ObjC
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "ViewController.h"
#import "AdMediation.h"


@interface ViewController ()

@end

@implementation ViewController

- (IBAction)presentBanner {
    [self showAd:AdTypeBanner];
}

- (IBAction)presentRewardedVideo {
    [self showAd:AdTypeRewardedVideo];
}

- (IBAction)presentInterstitial:(id)sender {
    [self showAd:AdTypeInterstitial];
}

- (void)showAd:(AdType)adType {
    if ([AdMediation.sharedInstance.provider hasReadyAd:adType]) {
        [AdMediation.sharedInstance.provider presentAd:adType rootViewController:self];
    }
}

@end
