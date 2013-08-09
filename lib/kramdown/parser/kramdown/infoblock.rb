require 'kramdown/parser/kramdown/blank_line'
require 'kramdown/parser/kramdown/extensions'
require 'kramdown/parser/kramdown/eob'

module Kramdown
  module Parser
    class Kramdown

      INFOBLOCK_START = /^#{OPT_SPACE}I> ?/

      # Parse the aside at the current location.
      def parse_infoblock
        result = @src.scan(PARAGRAPH_MATCH)
        while !@src.match?(self.class::LAZY_END)
          result << @src.scan(PARAGRAPH_MATCH)
        end
        result.gsub!(INFOBLOCK_START, '')

        el = new_block_el(:infoblock)
        @tree.children << el
        parse_blocks(el, result)
        true
      end
      define_parser(:infoblock, INFOBLOCK_START)

    end
  end
end
