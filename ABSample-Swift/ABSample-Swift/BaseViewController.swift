//
//  ViewController.swift
//  ABSample-Swift
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBAction func presenBanner() {
        show(.banner)
    }
    
    @IBAction func presentInterstitial() {
        show(.interstitial)
    }
    
    @IBAction func presentRewardedVideo() {
        show(.rewarded)
    }
    
    func show(_ type: AdType) {
        if AdMediation.sharedInstance.provider?.hasReadyAd(type) ?? false {
            AdMediation.sharedInstance.provider!.presentAd(type, self)
        }
    }
}

