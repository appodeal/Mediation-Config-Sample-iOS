//
//  AdMediation.swift
//  ABSample-Swift
//
//  Created by Stas Kochkin on 21/06/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

import UIKit
import Firebase

enum AdMediationType : String {
    case Unknown = ""
    case Appodeal = "appodeal"
    case MoPub = "mopub"
}

final class AdMediation: NSObject {
    private struct Constants {
        static let key = "mediation_partner"
    }
    
    private(set) var type: AdMediationType = .Unknown
    private lazy var config : RemoteConfig = {
       return RemoteConfig.remoteConfig()
    }()
    
    private(set) var provider : AdProvider?
    
    static let sharedInstance : AdMediation = AdMediation()
    
    override init() {
        FirebaseApp.configure()
    }
    
    func update(_ completion : @escaping (AdMediationType)->()) {
        config.fetch { [unowned self] status, error in
            guard  status == RemoteConfigFetchStatus.success else {
                print("Error while fetching remote config \(error.map{$0.localizedDescription} ?? "unknown")")
                completion(self.type)
                return
            }
            self.config.activateFetched()
            let value = self.config.configValue(forKey: Constants.key)
            self.type = value.stringValue.map { AdMediationType(rawValue: $0)}! ?? .Unknown
            // Update provider
            switch self.type {
            case .Appodeal:
                self.provider = AppodealProvider()
            case .MoPub:
                self.provider = MoPubProvider()
            case .Unknown:
                break
            }
            
            completion(self.type)
        }
    }
}
