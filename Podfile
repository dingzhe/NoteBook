platform :ios, '7.0'

workspace 'NoteBook'

# Dummy default project
xcodeproj 'NoteBook/NoteBook.xcodeproj'

target :NoteBookLib do
    xcodeproj 'NoteBookLib/NoteBookLib.xcodeproj'
    
    pod 'AFNetworking', '2.6.0', :inhibit_warnings => true
end

target :"NoteBook" do
    xcodeproj 'NoteBook/NoteBook.xcodeproj'
    
    pod 'Reveal-iOS-SDK', '1.5.1', :configurations => ['Debug']
    pod 'Masonry', '0.6.1'
    pod 'MJRefresh', '1.4.1'
    pod 'ReactiveCocoa', '2.4.7'
    pod 'ReactiveViewModel', '0.3'
    pod 'MBProgressHUD', '0.9.1'
    pod 'AJWValidator', '0.0.7'
    pod 'Tortuga22-NinePatch', '0.1.1', :inhibit_warnings => true
    pod 'JSONModel', '1.1.0'
    pod 'ISO8601', '0.3.0'
end

post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '7.0'
            config.build_settings['SDKROOT'] = 'iphoneos8.4'
        end
    end
end
