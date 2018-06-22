//
//  AdMediation.h
//  ABSample-ObjC
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdProvider.h"


/**
 Enum for mediation type

 - AdMediationTypeUnknown: Mediation type is not defined yet
 - AdMediationTypeAppodeal: Ad should be provided by Appodeal
 - AdMediationTypeAnythingElse: Ad should be provided by another partner
 */
typedef NS_ENUM(NSInteger, AdMediationType){
    AdMediationTypeUnknown = 0,
    AdMediationTypeAppodeal,
    AdMediationTypeMoPub
};

/**
 Define current mediation partner
 */
@interface AdMediation : NSObject
/**
 Choosed partner
 */
@property (nonatomic, readonly, assign) AdMediationType type;
/**
 Provider of ad
 */
@property (nonatomic, readonly) id <AdProvider> provider;
/**
 Designited initializer

 @return shared instance of meditation
 */
+ (instancetype)sharedInstance;
/**
 Update mediation status

 @param completion call when type defined
 */
- (void)updateMediationType:(void(^)(AdMediationType type))completion;

@end
