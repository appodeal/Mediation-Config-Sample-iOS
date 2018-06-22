//
//  AdProvider.swift
//  ABSample-Swift
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

import Foundation
import Appodeal
import MoPub

enum AdType {
    case rewarded
    case interstitial
    case banner
}

protocol AdProvider {
    func prepare()
    func hasReadyAd(_ type: AdType) -> Bool
    func presentAd(_ type: AdType, _ rootViewController : UIViewController)
}

private extension AdType {
    func toAppodealAdType() -> AppodealAdType {
        var type : AppodealAdType?
        switch self {
        case .banner:
            type = AppodealAdType.banner
        case .interstitial:
            type = AppodealAdType.interstitial
        case .rewarded:
            type = AppodealAdType.rewardedVideo
        }
        return type!
    }
    
    func toAppodealShowStyle() -> AppodealShowStyle {
        var type : AppodealShowStyle?
        switch self {
        case .banner:
            type = AppodealShowStyle.bannerBottom
        case .interstitial:
            type = AppodealShowStyle.interstitial
        case .rewarded:
            type = AppodealShowStyle.rewardedVideo
        }
        return type!
    }
}

class AppodealProvider : AdProvider {
    private struct Constants {
        static let apiKey = "Put your api key here"
        static let userConsent = true
        static let placement = "default"
        static let adTypes : AppodealAdType = [.banner, .interstitial, .rewardedVideo]
    }

    func prepare() {
       Appodeal.initialize(withApiKey: Constants.apiKey,
                           types: Constants.adTypes,
                           hasConsent: Constants.userConsent)
    }
    
    func hasReadyAd(_ type: AdType) -> Bool {
        return Appodeal.canShow(type.toAppodealAdType(), forPlacement:Constants.placement)
    }
    
    func presentAd(_ type: AdType, _ rootViewController : UIViewController) {
        Appodeal.showAd(type.toAppodealShowStyle(), rootViewController: rootViewController)
    }
}

class MoPubProvider : AdProvider {
    private struct Constants {
        static let interstitialAdUnit = "4f117153f5c24fa6a3a92b818a5eb630"
        static let bannerAdUnit = "0ac59b0996d947309c33f59d6676399f"
        static let rewardedAdUnit = "8f000bd5e00246de9c789eed39ff6096"
    }
    
    private lazy var banner : MPAdView = {
        return MPAdView(adUnitId: Constants.bannerAdUnit, size:MOPUB_BANNER_SIZE)
    }()
    private lazy var interstitial : MPInterstitialAdController = {
        return MPInterstitialAdController(forAdUnitId: Constants.interstitialAdUnit)
    }()
    
    func prepare() {
        banner.loadAd()
        interstitial.loadAd()
        MPRewardedVideo.loadAd(withAdUnitID: Constants.rewardedAdUnit, withMediationSettings: [])
    }
    
    func hasReadyAd(_ type: AdType) -> Bool {
        var ready = false
        switch type {
        case .banner:
            // Force banner availability
            ready = true
        case .interstitial:
            ready = interstitial.ready
        case .rewarded:
            ready = MPRewardedVideo.hasAdAvailable(forAdUnitID: Constants.rewardedAdUnit)
        }
        return ready
    }
    
    func presentAd(_ type: AdType, _ rootViewController : UIViewController) {
        switch type {
        case .banner:
            layoutBanner(superview: banner)
        case .interstitial:
            interstitial.show(from: rootViewController)
        case .rewarded:
            MPRewardedVideo.presentAd(forAdUnitID: Constants.rewardedAdUnit,
                                      from: rootViewController,
                                      with: MPRewardedVideoReward(currencyType: "Coins", amount: 23))
        }
    }
}

private extension MoPubProvider {
    func layoutBanner(superview: UIView) {
        if superview.subviews.contains(banner) {
            return
        }
        
        let size = banner.adContentViewSize()
        let origin = CGPoint(x: (superview.bounds.width - size.width) / 2,
                             y: superview.bounds.height - size.height)
        let frame = CGRect(origin: origin,
                           size: size)
        banner.frame = frame
        superview.addSubview(banner)
    }
}
