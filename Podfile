# Uncomment the next line to define a global platform for your project
 platform :ios, '13.5'

target 'Score1031' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Score1031
  
  pod 'Firebase', '7.2-M1'
  pod 'Firebase/Firestore', '7.2-M1'
  pod 'FirebaseFirestoreSwift', '7.2-M1'
  pod 'Firebase/Core', '7.2-M1'
  pod 'Firebase/Database', '7.2-M1'
  pod 'Firebase/Auth', '7.2-M1'
end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|

config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
end
end
end


