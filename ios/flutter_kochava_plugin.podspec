#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_kochava_plugin'
  s.version          = '0.0.1'
  s.summary          = 'flutter_kochava_plugin'
  s.description      = <<-DESC
flutter_kochava_plugin
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.ios.deployment_target = '8.0'
  s.dependency 'KochavaTrackeriOS', '3.11.3'
  # added when I got an error "[!] The 'Pods-Runner' target has transitive dependencies that include statically linked binaries:"
  s.static_framework = true
  #s.xcconfig = { 'SWIFT_OBJC_BRIDGING_HEADER' => 'Classes/bridging_header.h' }
end

