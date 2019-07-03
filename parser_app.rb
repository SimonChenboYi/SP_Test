# frozen_string_literal: true

require './lib/parser'
require './lib/printer'

parser = Parser.new
parser.read_log(ARGV.first)
parser.order_by_visits
parser.order_by_uniq_views
parser.print_list_of_visits
parser.print_list_of_unique_views
