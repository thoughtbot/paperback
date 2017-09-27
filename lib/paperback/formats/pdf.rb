require "paperback/formats/pandoc_base"
require "thor"

module Paperback
  module Formats
    class PDF < PandocBase
      def extension
        "pdf"
      end

      private

      def args
        [
          "--top-level-division=chapter",
          "--latex-engine=xelatex",
          "--template=#{pdf_latex_template_path}",
          "--toc",
          '--variable=mainfont:"Open Sans"',
          "--variable=monofont:Inconsolata"
        ]
      end

      def pdf_latex_template_path
        File.expand_path "../../templates/pdf.latex", __FILE__
      end
    end
  end
end
