# frozen_string_literal: true

# handel the log data
class Parser
  def initialize
    @visits = {}
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

  private

  def file_exsit?(filename)
    raise 'file does not exsit, please check again' unless File.file?(filename)
  end

  def file_empty?
    raise 'file is empty, please check again' if @visits.empty?
  end
end
