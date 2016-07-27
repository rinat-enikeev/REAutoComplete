Pod::Spec.new do |s|
  s.name             = 'REAutoComplete'
  s.version          = '0.1.3'
  s.summary          = 'UITextField suggestions in UITableView'

  s.description      = <<-DESC
Auto complete solution for UITextField.
                       DESC

  s.homepage         = 'https://github.com/rinat-enikeev/REAutoComplete'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rinat Enikeev' => 'rinat-enikeev.github.io' }
  s.source           = { :git => 'https://github.com/rinat-enikeev/REAutoComplete.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'REAutoComplete/Classes/**/*'
end
