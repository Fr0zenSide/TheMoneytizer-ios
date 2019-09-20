//
//  TMZConfiguration.m
//  TheMoneytizer
//
//  Created by Jeoffrey Thirot on 05/09/2019.
//  Copyright © 2019 The Moneytizer. All rights reserved.
//

#import "TMZConfiguration.h"

@interface TMZConfiguration () {
}

- (void) _initSDKs;

@end

@implementation TMZConfiguration

#pragma mark - Methods to init the Singleton

+ (instancetype) sharedInstance {
    static TMZConfiguration *sharedObject = nil;
    if( sharedObject == nil ) {
        sharedObject = [[super allocWithZone:NULL] init];
        
        sharedObject.testMode = NO;
    }
    return sharedObject;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}


#pragma mark - Methods to setup the configuration

- (void) setupInTestMode {
    self.testMode   = YES;
    self.baseURL    = @"https://mobile.smartadserver.com";
    self.smartID    = 45220;
    self.oguryID    = @"";
    
    self.bannerFormatID         = 15140;
    self.interstitialFormatID   = 12167;
    self.rewardedVideoFormatID  = 12167;
    
    self.bannerPageID           = 663262;
    self.interstitialPageID     = 663264;
    self.rewardedVideoPageID    = 1010691;
    
    [self _initSDKs];
}

- (void) setupWithSmartID:(NSInteger)smartID oguryID:(NSString *)oguryID pageID:(NSInteger)pageID {
    self.testMode   = NO;
    self.baseURL    = @"https://ww1097.smartadserver.com";
    self.smartID    = smartID;
    self.oguryID    = oguryID;
    
    self.bannerFormatID         = 81916;
    self.interstitialFormatID   = 81935;
    self.rewardedVideoFormatID  = 81982;
    
    self.pageID                 = pageID;
    self.bannerPageID           = self.pageID;
    self.interstitialPageID     = self.pageID;
    self.rewardedVideoPageID    = self.pageID;
    
    [self _initSDKs];
}


#pragma mark - Methods to manage the CMP

- (void) askUserConsentWithRootViewController:(UIViewController *)rootViewController {
    if( self.testMode == YES ) {
        NSLog(@"The user consent panel can be open only in production mode");
        return;
    }
    [[AdinCube UserConsent] ask:rootViewController];
}

- (void) editUserConsentWithRootViewController:(UIViewController *)rootViewController {
    if( self.testMode == YES ) {
        NSLog(@"The user consent panel can be open only in production mode");
        return;
    }
    [[AdinCube UserConsent] edit:rootViewController];
}

- (NSString *) getIABConsentString {
    NSString *iabConsentString = [[AdinCube UserConsent] getIABConsentString];
    // if the CMP is IAB compliant, we can get the consent string in NSUserDefaults
    // [[NSUserDefaults standardUserDefaults] stringForKey:@"IABConsent_ConsentString"];
    return iabConsentString;
}


#pragma mark - Helpers to get the right placement for displaying a format

- (SASAdPlacement *) getBannerPlacement {
    SASAdPlacement *adPlacement = [[SASAdPlacement alloc] initWithSiteId:self.smartID pageId:self.bannerPageID formatId:self.bannerFormatID];
    return adPlacement;
}

- (SASAdPlacement *) getInterstitialPlacement {
    SASAdPlacement *adPlacement = [[SASAdPlacement alloc] initWithSiteId:self.smartID pageId:self.interstitialPageID formatId:self.interstitialFormatID];
    return adPlacement;
}

- (SASAdPlacement *) getRewardedVideoPlacement {
    SASAdPlacement *adPlacement = [[SASAdPlacement alloc] initWithSiteId:self.smartID pageId:self.rewardedVideoPageID formatId:self.rewardedVideoFormatID];
    return adPlacement;
}


#pragma mark - Private Methods

- (void) _initSDKs {
    [[SASConfiguration sharedInstance] configureWithSiteId:self.smartID baseURL:self.baseURL];
    [AdinCube setAppKey:self.oguryID];
}

@end
