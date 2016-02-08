require 'spec_helper'

describe Slidox::CLI do
  let(:project_name) { 'slidox1' }

  before :each do
    FileUtils::mkdir_p(File.join(ROOT, "tmp"))
  end

  after :each do
    FileUtils.rm_rf(File.join(ROOT, "tmp"))
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
        "build/#{project_name}.html",
        "build/#{project_name}.pdf"
      ].each do |path|
        file = File.join(ROOT, "tmp/#{project_name}/#{path}")
        expect(File.exists?(file)).to be_truthy
      end
    end
  end
end
