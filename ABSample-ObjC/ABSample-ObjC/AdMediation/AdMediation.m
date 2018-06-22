//
//  AdMediation.m
//  ABSample-ObjC
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "AdMediation.h"
#import "AppodealProvider.h"
#import "MoPubProvider.h"


@import Firebase;

static NSString * const kAdMediationTypeKey = @"mediation_partner";

@interface AdMediation ()

@property (nonatomic, assign, readwrite) AdMediationType type;
@property (nonatomic, strong, readwrite) id <AdProvider> provider;
@property (nonatomic, strong) FIRRemoteConfig * config;

@end

@implementation AdMediation

#pragma mark - Designited initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        // Configure Firebase
        [FIRApp configure];
        self.type = AdMediationTypeUnknown;
    }
    return self;
}

+ (instancetype)sharedInstance {
    static AdMediation * _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [AdMediation new];
    });
    return _sharedInstance;
}

#pragma mark - Accessing

- (id<AdProvider>)provider {
    if (!_provider) {
        switch (self.type) {
            case AdMediationTypeAppodeal:
                _provider = [AppodealProvider new];
                break;
            case AdMediationTypeMoPub:
                _provider = [MoPubProvider new];
            default: break;
        }
    }
    return _provider;
}

#pragma mark - Public

- (void)updateMediationType:(void (^)(AdMediationType))completion {
    self.config = FIRRemoteConfig.remoteConfig;
    
    __weak typeof(self) weakSelf = self;
    [self.config fetchWithCompletionHandler:^(FIRRemoteConfigFetchStatus status, NSError * error) {
        AdMediationType type = AdMediationTypeUnknown;
        if (status == FIRRemoteConfigFetchStatusSuccess) {
            [weakSelf.config activateFetched];
            FIRRemoteConfigValue * value = [weakSelf.config configValueForKey:kAdMediationTypeKey];
            if ([value.stringValue isEqualToString:@"appodeal"]) {
                type = AdMediationTypeAppodeal;
            } else if ([value.stringValue isEqualToString:@"mopub"]){
                type = AdMediationTypeMoPub;
            }
        }
        
        weakSelf.type = type;
        completion ? completion(self.type) : nil;
    }];
}


@end
