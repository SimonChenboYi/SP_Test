# frozen_string_literal: true

require_relative './printer'

# handel the log data
class Parser
  def initialize(printer = Printer.new)
    @visits = {}
    @url_visits = []
    @uniq_url_views = []
    @printer = printer
  end

  def read_log(filename)
    file_exsit?(filename)
    File.open(filename, 'r') do |file|
      file.readlines.each do |line|
        url, ip = line.chomp.split(' ')
        @visits.key?(url) ? @visits[url].push(ip) : @visits[url] = [ip]
      end
    end
    file_empty?
    @visits
  end

  def order_by_visits
    @url_visits =
      @visits.sort.reverse
             .sort_by { |url_visits| url_visits[1].length }.reverse
  end

  def order_by_uniq_views
    @uniq_url_views = @visits.sort.reverse
    @uniq_url_views.map { |url_visits| url_visits[1] = url_visits[1].uniq }
    @uniq_url_views.sort_by! { |uniq_url_visits| uniq_url_visits[1].length }.reverse!
  end

  def print_list_of_visits
    @printer.print_in_visits_format(@url_visits)
  end

  def print_list_of_unique_views
    @printer.print_in_unique_views_format(@uniq_url_views)
  end

  private

  def file_exsit?(filename)
    raise 'file does not exsit, please check again' unless File.file?(filename)
  end

  def file_empty?
    raise 'file is empty, please check again' if @visits.empty?
  end
end
