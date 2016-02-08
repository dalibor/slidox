require 'thor'

module Slidox
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end

    desc "new name", "create new slidox"
    def new(name)
      source = self.class.source_root.to_s
      target = File.join(Dir.pwd, name)
      files = Dir.glob("#{source}/**/*").
        reject { |f| File.directory?(f) }.
        map { |f| f.gsub("#{source}/", '') }

      files.each do |file|
        copy_file(file, File.join(target, file))
      end
    end

    desc "build", "build slidox"
    def build
      Slidox::Builder.new.build
    end
  end
end
