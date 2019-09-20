//
//  TMZViewController.m
//  TheMoneytizer
//
//  Created by Jeoffrey Thirot on 09/12/2019.
//  Copyright (c) 2019 Jeoffrey Thirot. All rights reserved.
//

#import "TMZViewController.h"

@interface TMZViewController () {
    SASBannerView *_bannerView;
}

- (void) _createBanner;

@end

@implementation TMZViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	
    // You need to ask the user consent for the fisrt time before displaying advertising
    // The CMP is display only when you are in production mode
    [[TMZConfiguration sharedInstance] askUserConsentWithRootViewController:self];
    
    [self _createBanner];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) _createBanner {
    _bannerView = [[SASBannerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 50) loader:SASLoaderActivityIndicatorStyleWhite];
    _bannerView.delegate = self;
    
    _bannerView.expandsFromTop = YES;
    _bannerView.refreshInterval = 20;
    // Setting the modal parent view controller. To display detail when you touch the banner
    _bannerView.modalParentViewController = self;
    
    // Create a placement
    SASAdPlacement *adPlacement = [[TMZConfiguration sharedInstance] getBannerPlacement];
    [_bannerView loadWithPlacement:adPlacement];
    [self.view addSubview:_bannerView];
    
    // Please note that if you deactivate autoresizing translation (and you create your constraints yourself) on the ad view, it will prevent creatives that resize/reposition the view to work (like toaster or resize banners).
    // if you use the constraint
    BOOL useConstraints = YES;
    if (useConstraints) {
        [self _addBannerConstraints];
    } else {
        _bannerView.translatesAutoresizingMaskIntoConstraints = YES;
    }
}

- (void) _addBannerConstraints {
    _bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11, *)) {
        UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
        [[_bannerView.topAnchor constraintEqualToAnchor:safeArea.topAnchor] setActive:YES];
        [[_bannerView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor] setActive:YES];
        [[_bannerView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor] setActive:YES];
        [[_bannerView.heightAnchor constraintEqualToConstant:50] setActive:YES];
    } else {
        [[_bannerView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor] setActive:YES];
        [[_bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
        [[_bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
        [[_bannerView.heightAnchor constraintEqualToConstant:50] setActive:YES];
    }
}

#pragma mark - SASBannierViewDelegate Methods

- (void) bannerViewDidLoad:(SASBannerView *)bannerView {
    NSLog(@"Banner has been loaded");
}

- (void) bannerView:(SASBannerView *)bannerView didFailToLoadWithError:(NSError *)error {
    NSLog(@"Banner has failed to load with error: %@", [error localizedDescription]);
}

@end
