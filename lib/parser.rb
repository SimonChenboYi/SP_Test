# frozen_string_literal: true

# handel the log data
class Parser
  def initialize
    @visits = {}
  end

  def read_log(filename)
    raise 'file does not exsit, please check again' unless File.file?(filename)

    File.open(filename, 'r') do |file|
      file.readlines.each do |line|
        url, ip = line.chomp.split(' ')
        @visits.key?(url) ? @visits[url].push(ip) : @visits[url] = [ip]
      end
    end
    @visits
  end
end
