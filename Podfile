platform :ios, '14.0'

def base_pods
  source 'https://cdn.cocoapods.org/'
  
  pod 'AppAuth', :git => 'git@github.com:elenakacharmina/AppAuth-iOS.git'
  pod 'Moya', '~> 14.0'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'RxCocoa'
  pod 'Swinject'
end

target 'ios-oauth-example' do
  use_frameworks!
  base_pods
end
