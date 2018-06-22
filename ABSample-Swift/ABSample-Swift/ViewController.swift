//
//  ViewController.swift
//  ABSample-Swift
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

import UIKit

private extension String {
    var adType : AdType? {
        get {
            var adType : AdType?
            switch self {
            case "BannerCell":
                adType = .banner
            case "RewardedVideoCell":
                adType = .rewarded
            case "InterstitialCell":
                adType = .rewarded
            default:
                break
            }
            return adType
        }
    }
}

class ViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        guard let adType = cell.reuseIdentifier?.adType else {
            return
        }
        
        if AdMediation.sharedInstance.provider?.hasReadyAd(adType) ?? false {
            AdMediation.sharedInstance.provider!.presentAd(adType, self)
        }
    }
}

