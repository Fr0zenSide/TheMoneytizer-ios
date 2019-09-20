//
//  TMZConfiguration.h
//  TheMoneytizer
//
//  Created by Jeoffrey Thirot on 05/09/2019.
//  Copyright © 2019 The Moneytizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SASDisplayKit/SASDisplayKit.h>
#import <AdinCube/AdinCube.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMZConfiguration : NSObject

//@property (class, nonatomic, readonly) TMZConfiguration *sharedInstance NS_SWIFT_NAME(shared);
@property (nonatomic, assign) unsigned long smartID;
@property (nullable, nonatomic, copy) NSString *oguryID;
@property (nullable, nonatomic, copy) NSString *baseURL;

@property (nonatomic, assign) unsigned long bannerFormatID;
@property (nonatomic, assign) unsigned long interstitialFormatID;
@property (nonatomic, assign) unsigned long rewardedVideoFormatID;

@property (nonatomic, assign) unsigned long pageID;
@property (nonatomic, assign) unsigned long bannerPageID;
@property (nonatomic, assign) unsigned long interstitialPageID;
@property (nonatomic, assign) unsigned long rewardedVideoPageID;

@property (nonatomic, assign, getter=isTestingMode) BOOL testMode;
//@property (nullable, nonatomic, copy) NSString *customIdentifier;

#pragma mark - Method to initiate the configuration object

+ (instancetype) sharedInstance NS_SWIFT_NAME(shared());

#pragma mark - Methods to setup the configuration

// You can use this method for displaying a fake advertising during the development phase.
- (void) setupInTestMode;

/**
 * Method to call for initialize the advertising system.
 * This method need to be call at the launch of the app inside the AppDelegate.
 *
 * @param smartID identifier you can find in your account
 * @param oguryID identifier you can find in your account
 * @param pageID identifier you can find in your account
 */
- (void) setupWithSmartID:(NSInteger)smartID oguryID:(NSString *)oguryID pageID:(NSInteger)pageID NS_SWIFT_NAME(setup(smartID:oguryID:pageID:));

#pragma mark - Methods to manage the CMP

// Method you need to call before displaying advert inside the app and when you are ready to display the CMP for the first time to ask the user consent for advert if needed. For example inside the viewDidLoad method.
// You already need to call the setupWithSmartID:oguryID:baseURL:pageID;
- (void) askUserConsentWithRootViewController:(UIViewController *)rootViewController NS_SWIFT_NAME(askUserConsent(rootViewController:));

// Method you can call to edit choices of CMP
- (void) editUserConsentWithRootViewController:(UIViewController *)rootViewController NS_SWIFT_NAME(editUserConsent(rootViewController:));

/**
 * Method to get the IAB consent string
 *
 * @return the current IAB consent string used for the app
 */
- (NSString *) getIABConsentString;


#pragma mark - Helpers to get the right placement for displaying a format

- (SASAdPlacement *) getBannerPlacement;
- (SASAdPlacement *) getInterstitialPlacement;
- (SASAdPlacement *) getRewardedVideoPlacement;


@end

NS_ASSUME_NONNULL_END
