# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'revolut_ios_test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for revolut_ios_test

  target 'revolut_ios_testTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'revolut_ios_testTests_quick_nimble' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'Nimble-Snapshots'
    pod 'Mockingjay'
    
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        if %w(Mockingjay URITemplate).include?(target.name)
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
  end
end
