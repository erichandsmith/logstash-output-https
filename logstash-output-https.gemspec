Gem::Specification.new do |s|

  s.name            = 'logstash-output-https'
  s.version         = '0.0.8'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "Simple HTTPS Output."
  s.description     = "This gem is a logstash plugin to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program."
  s.authors         = ["Emdeon Enterprise Monitoring"]
  s.email           = 'ISSProductionMonitoring-Data@emdeon.com'
  s.homepage        = "http://www.emdeon.com/"
  s.require_paths = ["lib"]

  # Files
  s.files = `git ls-files`.split($\)

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", '>= 1.4.0', '< 2.0.0'
  s.add_runtime_dependency "connection_pool", '= 2.2.0'
  s.add_runtime_dependency "net-http-pipeline", '= 1.0.1'
  s.add_runtime_dependency "net-http-persistent", '= 2.9.4'
  s.add_development_dependency 'logstash-devutils', '= 0.0.12'

end
