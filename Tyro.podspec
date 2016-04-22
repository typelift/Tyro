Pod::Spec.new do |s|
  s.name        = "Tyro"
  s.version     = "0.0.8"
  s.summary     = "Functional JSON parsing and encoding."
  s.homepage    = "https://github.com/typelift/Tyro"
  s.license     = { :type => "BSD" }
  s.authors     = { "CodaFi" => "devteam.codafi@gmail.com", "pthariensflame" => "alexanderaltman@me.com", "mpurland" => "m.purland@gmail.com" }

  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.1"
  s.watchos.deployment_target = "2.1"  
  s.source   = { :git => "https://github.com/typelift/Tyro.git", :tag => "v#{s.version}", :submodules => true }
  s.source_files = "Tyro/*.swift"
  s.dependency "Swiftz"
end
