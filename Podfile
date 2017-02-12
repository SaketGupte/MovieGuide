# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MovieGuide' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieGuide

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end

  target 'MovieGuideTests' do
    inherit! :search_paths
    # Pods for testing
  end

pod 'AlamofireImage', '~> 3.1'
pod 'Typhoon'
pod 'RxCocoa',    '~> 3.0.0'
pod 'Moya-ModelMapper/RxSwift', '~> 4.0.0-beta.3'
pod 'RxOptional', '~> 3.1.2'
pod 'SwiftLint'
end
