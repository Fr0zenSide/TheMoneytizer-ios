#
# Be sure to run `pod lib lint TheMoneytizer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TheMoneytizer'
  s.version          = '1.0.0'
  s.summary          = 'The Moneytizer Ads SDK for managing in App advertising.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The Moneytizer Ads SDK for managing in App advertising. Monetize your app by displaying ads in your app from all ours partners.
                       DESC

  s.homepage         = 'https://www.themoneytizer.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'CC BY SA', :file => 'LICENSE' }
  s.author           = { 'Jeoffrey Thirot' => 'jthirot@themoneytizer.com' }
  s.source           = { :git => 'https://github.com/Fr0zenSide/TheMoneytizer-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'TheMoneytizer/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'TheMoneytizer' => ['TheMoneytizer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.static_framework = true
  s.dependency 'Smart-Display-SDK', '~> 7.1'
  s.dependency 'AdinCube', '~> 2.8'
end
