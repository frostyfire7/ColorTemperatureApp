platform :ios, '15.0'
use_frameworks!

target 'ColorTemperature' do
  pod 'OpenCV2'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['CLANG_CXX_LANGUAGE_STANDARD'] = 'c++11'
        config.build_settings['CLANG_CXX_LIBRARY'] = 'libc++'
        config.build_settings['GCC_C_LANGUAGE_STANDARD'] = 'c11'
      end
    end
  end
end
