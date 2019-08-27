#
# Be sure to run `pod lib lint fyydAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'fyydAPI'
  s.version          = '0.1.1'
  s.summary          = 'Swift API to work with fyyd.de'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift API for iOS to work with fyyd.de
                       DESC

  s.homepage         = 'https://github.com/JeanetteMueller/fyydAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JeanetteMueller' => 'github@themaverick.de' }
  s.source           = { :git => 'https://github.com/JeanetteMueller/fyydAPI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/JeanetteMueller'

  s.ios.deployment_target = '8.0'

  s.source_files = 'fyydAPI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'fyydAPI' => ['fyydAPI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 4.4'
end
