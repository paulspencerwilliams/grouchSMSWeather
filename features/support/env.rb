require 'aruba/cucumber'
require 'aruba'
require 'aruba/in_process'
require 'vcr'
require 'webmock'
require 'grouchSMSWeather'

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
end

class VcrFriendlyMain
  def initialize(argv, stdin, stdout, stderr, kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout
    GrouchSMSWeather::CLI.start(@argv)
  end
end

Before('@vcr') do
  Aruba::InProcess.main_class = VcrFriendlyMain
  Aruba.process = Aruba::InProcess
end

After('@vcr') do
  Aruba.process = Aruba::SpawnProcess
  VCR.eject_cassette
  $stdin = STDIN
  $stdout = STDOUT
end
