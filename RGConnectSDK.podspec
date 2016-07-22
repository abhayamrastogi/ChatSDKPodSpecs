Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "RGConnectSDK"
s.summary = "RGConnectSDK lets a user communicate internally."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "abhayam" => "abhayam.rastogi@round.glass" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/abhayamrastogi/ChatSDK"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/abhayamrastogi/ChatSDK.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"
s.dependency 'RealmSwift'
s.dependency 'ObjectMapper'

# 8
s.source_files = "RGConnectSDK/**/*.{swift}"

# 9
s.resources = "RGConnectSDK/**/*.{png,jpeg,jpg,storyboard,xib}"
end