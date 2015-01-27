require "paperback/formats/pandoc_base"
require "thor"

module Paperback
  module Formats
    class PDF < PandocBase
      private

      def args
        [
          "--chapters",
          "--latex-engine=xelatex",
          "--template=#{pdf_latex_template_path}",
          "--toc",
          "--variable=geometry:paperheight=9.0in",
          "--variable=geometry:paperwidth=6.0in",
          '--variable=mainfont:"Open Sans"',
          "--variable=monofont:Inconsolata"
        ]
      end

      def extension
        "pdf"
      end

      def pdf_latex_template_path
        File.expand_path "../../templates/pdf.latex", __FILE__
      end
    end
  end
end
