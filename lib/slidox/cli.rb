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

      ['assets', 'slides'].each do |dir|
        Dir.glob("#{source}/#{dir}/*").
            map { |f| f.gsub("#{source}/", '') }.each do |file|
          copy_file(file, File.join(target, file))
        end
      end

      @name = name
      template('config.yml', File.join(target, 'config.yml'))
    end

    desc "build", "build slidox"
    def build
      Slidox::Builder.new.build
    end
  end
end
