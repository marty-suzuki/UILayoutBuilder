#
#  Be sure to run `pod spec lint Unio.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  last_commit = `git rev-list --tags --max-count=1`.strip
  last_tag = `git describe --tags #{last_commit}`.strip

  s.name         = "UILayoutBuilder"
  s.version      = last_tag
  s.summary      = "An AutoLayout DSL that intuitive syntax and viewable hierarchy."
  s.homepage     = "https://github.com/marty-suzuki/UILayoutBuilder"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Taiki Suzuki" => "s1180183@gmail.com" }
  s.ios.deployment_target  = "10.0"
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '10.0'
  s.source       = { :git => "https://github.com/marty-suzuki/UILayoutBuilder.git", :tag => "#{s.version}" }
  s.source_files = "Sources/**/*.{swift}"
  s.swift_version = '5.0'
end
