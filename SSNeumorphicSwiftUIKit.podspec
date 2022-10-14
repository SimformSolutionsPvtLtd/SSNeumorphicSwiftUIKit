#
# Be sure to run `pod lib lint SSNeumorphicSwiftUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SSNeumorphicSwiftUIKit'
  s.version          = '0.0.1'
  s.summary          = 'SSNeumorphicSwiftUIKit is a library to build elegant Nemorphic Views, Buttons, and Textfields in SwiftUI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


  s.description      = 'SSNeumorphicSwiftUIKit is a library to build elegant Nemorphic Views, Buttons, and Textfields in the SwiftUI.'

  s.homepage         = 'https://github.com/SimformSolutionsPvtLtd/SSNeumorphicSwiftUIKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author           = { 'Simform Solutions' => 'developer@simform.com' }

  s.source           = { :git => 'https://github.com/SimformSolutionsPvtLtd/SSNeumorphicSwiftUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.swift_version = '5.0'
  
  s.source_files = ['Sources/SSNeumorphicSwiftUIKit/**/*']


  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
end

