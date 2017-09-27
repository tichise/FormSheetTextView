Pod::Spec.new do |s|
  s.name = 'FormSheetTextView'
  s.version = '1.1.0'
  s.license = 'MIT'
  s.summary = 'FormSheetTextView is a FormSheet style UITextView.'
  s.homepage = 'https://github.com/tichise/FormSheetTextView'
  s.social_media_url = 'http://twitter.com/tichise'
  s.author = "Takuya Ichise"
  s.source = { :git => 'https://github.com/tichise/FormSheetTextView.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true

  s.resource_bundles = {
    'Storyboards' => [
        'Storyboards/*.storyboard'
    ]
  }
end
