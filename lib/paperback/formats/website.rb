require "paperback/formats/pandoc_base"

module Paperback
  module Formats
    class Website < PandocBase
      def type
        "website"
      end

      def extension
        "html.zip"
      end

      private

      def args
        [
          "-t chunkedhtml",
          "--template=#{website_template_path}",
          "--chunk-template=%i.html",
          "--split-level=2",
          "--lua-filter=#{clickable_headers_filter_path}",
          "--toc-depth=2",
          "--toc"
        ]
      end

      def website_template_path
        File.expand_path "../../templates/website.erb", __FILE__
      end

      def clickable_headers_filter_path
        File.expand_path "../../templates/clickable_headers.lua", __FILE__
      end

      def css_path
        File.expand_path "../../assets/css/application.css", __FILE__
      end

      def google_fonts_path
        File.expand_path "../../assets/google_fonts.html", __FILE__
      end
    end
  end
end
