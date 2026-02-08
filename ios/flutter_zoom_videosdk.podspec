#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_zoom_videosdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_zoom_videosdk'
  s.version          = '2.4.12'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'zoom' => 'http://example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/*.h'
  s.dependency 'Flutter'
  s.dependency 'ZoomVideoSDK/ZoomVideoSDK', '2.4.12'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  # ZoomVideoSDK does NOT support Mac Catalyst; disable it at pod target level.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64',
    # Explicitly exclude macOS/Catalyst builds for this pod.
    'EXCLUDED_ARCHS[sdk=macosx*]' => 'arm64 x86_64',
    'SUPPORTS_MACCATALYST' => 'NO'
  }

  # Ensure the app target doesn't try to build this pod for Mac Catalyst.
  s.user_target_xcconfig = {
    # Ensure the app target never links this pod for Catalyst/macOS.
    'EXCLUDED_ARCHS[sdk=macosx*]' => 'arm64 x86_64',
    'SUPPORTS_MACCATALYST' => 'NO'
  }

  s.preserve_paths = 'ZoomVideoSDK.xcframework/**/*'
  s.exclude_files = [
    'Classes/FlutterZoomVideoSdkAnnotationHelper.*',
    'Classes/FlutterZoomVideoSdkWhiteboardHelper.*',
    'Classes/FlutterZoomVideoSdkLiveStreamHelper.*',
    'Classes/FlutterZoomVideoSdkVirtualBackgroundHelper.*',
    'Classes/FlutterZoomVideoSdkVirtualBackgroundItem.*',
  ]
end
