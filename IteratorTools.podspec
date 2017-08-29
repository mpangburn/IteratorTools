Pod::Spec.new do |s|
  s.name             = "IteratorTools"
  s.version          = "1.0.0"
  s.summary          = "A Swift port of Python's itertools."

  s.description      = <<-DESC
                       A Swift port of Python's itertools. Contains utility functions utilizing IteratorProtocol, Sequence, and LazySequenceProtocol.
                       DESC

  s.homepage         = "https://github.com/mpangburn/IteratorTools"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "mpangburn" => "michaelpangburn@comcast.net" }
  s.source           = { :git => "https://github.com/mpangburn/IteratorTools.git", :tag => s.version.to_s }

  s.ios.deployment_target = "8.0"

  s.source_files = "Sources/**/*"
end
