# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


inhibit_all_warnings!

def appPods
  pod 'IQKeyboardManagerSwift'
  pod 'ImageSlideshow/Alamofire'
  pod 'ClassyConfetti'
  pod 'DropDown'
  pod 'Kingfisher'
  pod 'FSCalendar'
  pod 'IndicateKit', '~> 2.0.0'
  pod 'AEOTPTextField'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'



end


def apiPods
pod 'SwiftyJSON'
pod 'Result'
pod 'Moya'
end


target 'Stylz' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  appPods
  
end

target 'StylzWebkit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  apiPods
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
