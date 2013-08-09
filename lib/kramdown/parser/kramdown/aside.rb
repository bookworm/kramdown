# -*- coding: utf-8 -*-
#
#--
# Copyright (C) 2009-2013 Thomas Leitner <t_leitner@gmx.at>
#
# This file is part of kramdown which is licensed under the MIT.
#++
#

require 'kramdown/parser/kramdown/blank_line'
require 'kramdown/parser/kramdown/extensions'
require 'kramdown/parser/kramdown/eob'

module Kramdown
  module Parser
    class Kramdown

      ASIDE_START = /^#{OPT_SPACE}A> ?/

      # Parse the aside at the current location.
      def parse_aside
        result = @src.scan(PARAGRAPH_MATCH)
        while !@src.match?(self.class::LAZY_END)
          result << @src.scan(PARAGRAPH_MATCH)
        end
        result.gsub!(ASIDE_START, '')

        el = new_block_el(:aside)
        @tree.children << el
        parse_blocks(el, result)
        true
      end
      define_parser(:aside, ASIDE_START)

    end
  end
end
