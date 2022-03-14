# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

def default_pods
  pod 'PureLayout'
  pod 'CCBottomRefreshControl'
end

def tests_pod
  pod 'Quick'
  pod 'Nimble'
end

target 'marvelapp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for marvelapp
  default_pods
  pod 'UITestHelper/App'
  
  target 'marvelappTests' do
    inherit! :search_paths
    tests_pod
  end
  
  target 'marvelappUITests' do
    inherit! :search_paths
    default_pods
    tests_pod
    pod 'UITestHelper'
  end
  
  # This will make sure your test project has ENABLE_BITCODE set to NO
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if ['UITestHelperUITests'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
      end
    end
  end
end

