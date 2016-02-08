require 'slidox'

ROOT = File.expand_path('../', File.dirname(__FILE__))

def run_cmd(cmd)
  `bundle exec #{Gem.ruby} #{ROOT}/bin/slidox #{cmd}`
end

def remove_tmp_dir(name)
  FileUtils.rm_rf(File.join(ROOT, "tmp/#{name}"))
end

