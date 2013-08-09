require 'kramdown/parser/kramdown/blank_line'
require 'kramdown/parser/kramdown/extensions'
require 'kramdown/parser/kramdown/eob'

module Kramdown
  module Parser
    class Kramdown

      INCLUDEBLOCK_START = /^#{OPT_SPACE}<</
      INCLUDEBLOCK_MATCH = /^#{OPT_SPACE}<<\((.*)\)/

      # Parse the aside at the current location.
      def parse_includeblock
        result = @src.scan(INCLUDEBLOCK_MATCH)
        result.gsub!(INCLUDEBLOCK_START, '')
        result.gsub!('(', '')
        result.gsub!(')', '')

        el = new_block_el(:includeblock)
        @tree.children << el
        parse_blocks(el, result)
        true
      end
      define_parser(:includeblock, INCLUDEBLOCK_START)

    end
  end
end
