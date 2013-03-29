module Paperback
  # Allows multiple variables and values to be provided to pandoc-ruby.
  #
  # Pandoc accepts variables as multiple invocations of the --variable flag.
  # Variables with multiple values are specified more than once.
  #
  # For example:
  #
  #   PandocVariables.new(
  #     monofont: 'Inconsolata',
  #     geometry: ['paperwidth=6.0in', 'paperheight=9.0in']
  #   )
  #
  # Will produce:
  #
  #   --variable "monofont:Inconsolata" \
  #   --variable "geometry:paperwidth=6.0in" \
  #   --variable "geometry:paperheight=9.0in"
  class PandocVariables
    PDF = {
      geometry: ['paperwidth=6.0in', 'paperheight=9.0in'],
      mainfont: 'Proxima Nova',
      monofont: 'Inconsolata'
    }

    include Enumerable

    def initialize(variables = {})
      @variables = variables
    end

    def each
      @variables.each do |name, values|
        Array(values).each do |value|
          yield ['variable', %{"#{name}:#{value}"}]
        end
      end
    end

    def each_pair
      each do |(name, value)|
        yield name, value
      end
    end
  end
end
