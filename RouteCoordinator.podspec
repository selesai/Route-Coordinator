#
# Be sure to run `pod lib lint RouteCoordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RouteCoordinator'
  s.version          = '1.0.0'
  s.summary          = 'A short description of RouteCoordinator.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/selesai/Route-Coordinator.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marsudi Widodo' => 'mrsdwdd@gmail.com' }
  s.source           = { :git => 'https://github.com/selesai/Route-Coordinator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = "5.0"

  s.source_files = 'RouteCoordinator/*.{swift}'
end
