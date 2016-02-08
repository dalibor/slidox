require 'slidox'

ROOT = File.expand_path('../', File.dirname(__FILE__))

def run_cmd(cmd)
  `bundle exec #{Gem.ruby} #{ROOT}/bin/slidox #{cmd}`
end
