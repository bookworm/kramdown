require 'kramdown/parser/kramdown/blank_line'
require 'kramdown/parser/kramdown/extensions'
require 'kramdown/parser/kramdown/eob'

module Kramdown
  module Parser
    class Kramdown

      TEXTBLOCK_START = /^#{OPT_SPACE}([WTEIQDX])> ?/
      TEXTBLOCK_TYPES = {
        "W" => "warning",
        "T" => "tip",
        "E" => "error",
        "I" => "information",
        "Q" => "question",
        "D" => "discussion",
        "X" => "exercise"
      }

      # Parse the aside at the current location.
      def parse_textblock
        result = @src.scan(PARAGRAPH_MATCH)
        while !@src.match?(self.class::LAZY_END)
          result << @src.scan(PARAGRAPH_MATCH)
        end
        type_char = TEXTBLOCK_START.match(result).captures.first
        result.gsub!(TEXTBLOCK_START, '')

        el = new_block_el(:textblock)
        el.attr['textblock_type'] = TEXTBLOCK_TYPES[type_char]
        
        @tree.children << el
        parse_blocks(el, result)
        true
      end
      define_parser(:textblock, TEXTBLOCK_START)

    end
  end
end
