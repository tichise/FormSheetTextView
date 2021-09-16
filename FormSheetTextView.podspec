Pod::Spec.new do |s|
  s.name = 'FormSheetTextView'
  s.version = '1.5.0'
  s.license = 'MIT'
  s.summary = 'FormSheetTextView is a FormSheet style UITextView.'
  s.homepage = 'https://github.com/tichise/FormSheetTextView'
  s.social_media_url = 'http://twitter.com/tichise'
  s.author = "Takuya Ichise"
  s.source = { :git => 'https://github.com/tichise/FormSheetTextView.git', :tag => s.version }

  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true

  s.resource_bundles = {
    'FormSheetTextViewStoryboards' => [
        'Storyboards/*.storyboard'
    ]
  }
end
