# frozen_string_literal: true

# print the lists
class Printer
  def print_in_visits_format(visit_list)
    puts 'list of webpages with total visits:'
    visit_list.each do |visit|
      puts "#{visit[0]} #{visit[1].count} #{visit[1].count > 1 ? 'visits' : 'visit'}"
    end
  end
end
