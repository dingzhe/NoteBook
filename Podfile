platform :ios, '7.0'

workspace 'NoteBook'

# Dummy default project
project 'NoteBook/NoteBook.xcodeproj'

target :NoteBookLib do
    project 'NoteBookLib/NoteBookLib.xcodeproj'
    
    pod 'AFNetworking', '2.6.0', :inhibit_warnings => true
end

def testing_pods
    pod 'Masonry', '0.6.1'
    pod 'MJRefresh', '1.4.1'
    pod 'MBProgressHUD', '0.9.1'
    pod 'AJWValidator', '0.0.7'
    pod 'Tortuga22-NinePatch', '0.1.1', :inhibit_warnings => true
    pod 'JSONModel', '1.1.0'
    pod 'ISO8601', '0.3.0'
end
target :"NoteBook" do
    project 'NoteBook/NoteBook.xcodeproj'
    testing_pods
    pod 'MMMarkdown'
#    pod 'Reveal-iOS-SDK', '1.5.1', :configurations => ['Debug']
    pod 'ReactiveCocoa', '2.4.7'
    pod 'ReactiveViewModel', '0.3'
    pod 'CocoaLumberjack', '2.0.0-rc'
    pod 'UMengSocialCOM', '~> 5.1'
    pod 'FMDB'
    pod 'OneAPM','~> 2.2.1'
    pod 'JSPatch'
end
target :"NoteBookTests" do
    testing_pods
end
if defined? installer_representation.project
    post_install do |installer_representation|
        installer_representation.project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '7.0'
                config.build_settings['SDKROOT'] = 'iphoneos8.4'
                config.build_settings['OTHER_LDFLAGS'] = '-framework AFNetworking'
                config.build_settings['ARCHS'] = 'armv7 arm64'
                config.build_settings['VALID_ARCHS'] = 'armv7 arm64'
                config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            end
        end
    end
end
if defined? installer_representation.pods_project
    post_install do |installer_representation|
        installer_representation.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '7.0'
                config.build_settings['SDKROOT'] = 'iphoneos8.4'
                config.build_settings['OTHER_LDFLAGS'] = '-framework AFNetworking'
                config.build_settings['ARCHS'] = 'armv7 arm64'
                config.build_settings['VALID_ARCHS'] = 'armv7 arm64'
                config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            end
        end
    end
end
