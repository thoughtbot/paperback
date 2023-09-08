require "paperback/formats/pandoc_base"

module Paperback
  module Formats
    class HTML < PandocBase
      def extension
        "html"
      end

      private

      def args
        [
          "--css=#{css_path}",
          "--include-in-header=#{google_fonts_path}",
          "--section-divs",
          "--embed-resources",
          "--standalone",
          "--to=html5",
          "--toc"
        ]
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
