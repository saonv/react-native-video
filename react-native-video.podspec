require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name           = 'react-native-video'
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = 'https://github.com/react-native-community/react-native-video'
  s.source       = { :git => "https://github.com/saonv/react-native-video.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.subspec "Video" do |ss|
    ss.source_files  = "ios/Video/*.{h,m}","ios/SigmaDRM/include/*.h"
    ss.vendored_libraries = 'ios/SigmaDRM/lib/libSigmaDRM.a'
    ss.public_header_files = "ios/SigmaDRM/include/**"
    ss.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/#{s.name}/ios/SigmaDRM/include/**" }
    s.static_framework = true
  end

  s.subspec "VideoCaching" do |ss|
    ss.dependency "react-native-video/Video"
    ss.dependency "SPTPersistentCache", "~> 1.1.0"
    ss.dependency "DVAssetLoaderDelegate", "~> 0.3.1"

    ss.source_files = "ios/VideoCaching/**/*.{h,m}"
    s.static_framework = true
  end

  s.dependency "React"

  s.default_subspec = "Video"
end
