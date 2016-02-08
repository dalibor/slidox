require 'spec_helper'

describe Slidox::CLI do
  let(:project_name) { 'slidox1' }

  after :each do
    remove_tmp_dir(project_name)
  end

  it "generates new slidox project" do
    Dir.chdir('tmp') do
      run_cmd("new #{project_name}")

      [
        'assets/main.css',
        'assets/elephants.jpg',
        'assets/OpenSans-Light-webfont.ttf',
        'slides/1.md',
        'slides/2.md'
      ].each do |path|
        file = File.join(ROOT, "tmp/#{project_name}/#{path}")
        expect(File.exists?(file)).to be_truthy
      end
    end
  end

  it "builds slidox project" do
    Dir.chdir('tmp') do
      run_cmd("new #{project_name}")
      Dir.chdir(project_name) do
        run_cmd("build")
      end

      [
        'build/presentation.html',
        'build/presentation.pdf'
      ].each do |path|
        file = File.join(ROOT, "tmp/#{project_name}/#{path}")
        expect(File.exists?(file)).to be_truthy
      end
    end
  end
end
