require 'fileutils'
require 'pathname'
require 'yaml'
require 'github/markdown'
require 'nokogiri'
require 'pdfkit'
require 'pygments'

module Slidox
  class Builder

    def build
      prepare_target_dirs

      html = styles + slides.join(page_break)

      save_html(html)
      save_pdf(html)
    end

    private

    def slides
      Dir.glob("#{slides_path}/*.md").to_a.sort.map do |file|
        text = File.read(file)

        html = GitHub::Markdown.to_html(text, :markdown)

        doc = Nokogiri::HTML::DocumentFragment.parse(html)

        doc.search('pre').each do |node|
          next unless lang = node['lang']

          html = Pygments.highlight(node.inner_text, lexer: lang.to_sym, options: {linespans: 'line'})
          node = node.replace(html).first
          node["class"] = [node["class"], "highlight-#{lang}"].compact.join(" ")
        end

        doc.search('img').each do |node|
          node['src'] = "#{assets_path}/#{node['src']}"
        end

        doc.to_s
      end

    end

    def styles
      styles = Dir.glob("#{assets_path}/*.css").map { |file| File.read(file) }
      styles = styles.map { |style| "<style>#{style}</style>" }.join

      styles.gsub(/url\(['"](?<file>.*)['"]\)/) do |match|
        if $~[:file][0] == "/"
          match
        else
          match.gsub($~[:file], "#{assets_path}/#{$~[:file]}")
        end
      end
    end

    def prepare_target_dirs
      FileUtils::mkdir_p(html_target.dirname)
      FileUtils::mkdir_p(pdf_target.dirname)
    end

    def save_html(html)
      File.write(html_target, html)
    end

    def save_pdf(html)
      PDFKit.new(html, pdf_config).to_file(pdf_target)
    end

    def slides_path
      File.join(root_path, 'slides')
    end

    def assets_path
      File.join(root_path, 'assets')
    end

    def pdf_config
      config['pdf']
    end

    def html_target
      Pathname.new(config['target']['html'])
    end

    def pdf_target
      Pathname.new(config['target']['pdf'])
    end

    def page_break
      "<div style='page-break-before:always'></div>"
    end

    def root_path
      Dir.pwd
    end

    def config
      @config ||= YAML.load_file(File.join(root_path, 'config.yml'))
    end
  end
end
