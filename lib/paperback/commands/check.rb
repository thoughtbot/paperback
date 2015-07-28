module Paperback
  module Commands
    class Check
      def self.call
        new.check_dependencies!
      end

      def check_dependencies!
        puts "Checking Paperback dependencies..."
        missing_dependencies = dependencies.select do |dependency|
          printf "%-30s", "Checking for #{dependency[:name]}..."
          if present?(dependency[:check])
            puts "Found"
          else
            puts "Missing"
            dependency
          end
        end

        if missing_dependencies.empty?
          puts "All dependencies satisfied."
        else
          puts "Missing dependencies:"
          missing_dependencies.each do |dependency|
            puts "  • " + dependency[:message]
          end
        end
      end

      def dependencies
        [
          {
            name: "LaTeX",
            check: "xelatex -v",
            message: <<-MSG
LaTeX (http://latex-project.org/ftp.html)
      ∟ Huge download—start it now!
            MSG
          },
          # {
          #   name: "KindleGen",
          #   check: "kindlegen -v",
          #   message: <<-MSG,
# KindleGen (http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211)
      # ∟ Put the kindlegen executable on your path, e.g., in /usr/local/bin
          #   MSG
          # },
          {
            name: "Inconsolata",
            check: "#{LIST_FONTS} | grep -i inconsolata",
            message: <<-MSG,
Inconsolata (http://www.levien.com/type/myfonts/inconsolata.html)
      ∟ Download and install the font
            MSG
          },
          {
            name: "Open Sans",
            check: %(#{LIST_FONTS} | grep -i "Open Sans"),
            message: <<-MSG
Open Sans (https://www.google.com/fonts#UsePlace:use/Collection:Open+Sans)
      ∟ Download and install the font
            MSG
          },
        ]
      end

      def present?(command)
        `#{command}`
        $?.success?
      end

      LIST_FONTS = %{(if ([ "$(uname)" = "Darwin" ]); then
  /usr/X11/bin/fc-list
else
  fc-list
fi)}
      private_constant :LIST_FONTS
    end
  end
end
