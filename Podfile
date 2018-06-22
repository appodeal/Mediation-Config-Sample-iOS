platform :ios, '8.0'
workspace 'ABSample.xcworkspace'

use_frameworks!

# Firebase dependency: https://firebase.google.com/docs/remote-config/use-config-ios
def firebase 
	pod 'Firebase/Core'
	pod 'Firebase/RemoteConfig'
end

# Appodeal dependency https://www.appodeal.com/sdk/ios_beta
def appodeal(networks)
    networks.each { |network| pod "Appodeal/#{network}", '2.4.3-Beta6' }
end

# MoPub
def mopub
    pod 'mopub-ios-sdk'
end
# Target configuration

target 'ABSample-ObjC' do
    project 'ABSample-ObjC/ABSample-ObjC.xcodeproj'
    firebase
    # For Obj-C we can use MoPub SDK that binded in Appodeal TwitterMoPub Adapter
    appodeal(['AdColonyAdapter', 'AdExchangeAdapter', 'AmazonAdsAdapter', 'AppLovinAdapter', 'FacebookAudienceAdapter', 'FlurryAdapter', 'GoogleAdMobAdapter', 'InMobiAdapter', 'AdColonyAdapter', 'AdExchangeAdapter', 'IronSource', 'MobvistaAdapter', 'MyTargetAdapter', 'PubnativeAdapter', 'StartAppAdapter', 'TapjoyAdapter', 'TwitterMoPubAdapter', 'UnityAdapter', 'VungleAdapter', 'YandexAdapter'])
end

target 'ABSample-Swift' do
    project 'ABSample-Swift/ABSample-Swift.xcodeproj'
    firebase
    # But for  swift it's not supported yet, cause framework not contains modulemap
    appodeal(['AdColonyAdapter', 'AdExchangeAdapter', 'AmazonAdsAdapter', 'AppLovinAdapter', 'FacebookAudienceAdapter', 'FlurryAdapter', 'GoogleAdMobAdapter', 'InMobiAdapter', 'AdColonyAdapter', 'AdExchangeAdapter', 'IronSource', 'MobvistaAdapter', 'MyTargetAdapter', 'PubnativeAdapter', 'StartAppAdapter', 'TapjoyAdapter', 'UnityAdapter', 'VungleAdapter', 'YandexAdapter'])
    mopub
end
