//
//  SASAdinCubeBaseAdapter.m
//  SmartAdServer
//
//  Created by Loïc GIRON DIT METAZ on 21/09/2018.
//  Copyright © 2018 Smart AdServer. All rights reserved.
//

#import "SASAdinCubeBaseAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SASAdinCubeBaseAdapter

- (void)configureApplicationIDWithServerParameterString:(NSString *)serverParameterString {
    self.applicationID = serverParameterString;
    [AdinCube setAppKey:self.applicationID];
}

- (void)configureGDPRWithClientParameters:(NSDictionary *)clientParameters {
    // AdinCube is IAB compliant with the Ogury CMP
    // No need to set manually the IAB Consent String
}

@end

NS_ASSUME_NONNULL_END
