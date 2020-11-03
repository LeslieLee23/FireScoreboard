# Uncomment the next line to define a global platform for your project
 platform :ios, '13.5'

target 'Score1031' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Score1031
  
  pod 'Firebase'
  # pod 'FirebaseUI'
  # pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'

  # pod 'FirebaseUI/Auth'
  # pod 'FirebaseUI/OAuth' 


end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
end
end
end
