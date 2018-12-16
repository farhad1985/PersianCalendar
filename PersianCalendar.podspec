Pod::Spec.new do |s|
  s.name             = 'PersianCalendar'
  s.version          = '0.1.0'
  s.summary          = 'PersianCalendar is a Calendar. by : farhad faramarzi'


  s.homepage         = 'https://github.com/farhad1985/PersianCalendar'
  s.author           = { 'Farhad Faramarzi' => 'farhad.public@gmail.com' }
  s.license          = { :type => 'GPL2', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/farhad1985/PersianCalendar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.source_files = 'PersianCalendar/*'
  s.exclude_files = "PersianCalendar/**/*.plist"
  s.swift_version = '4.2'

end
