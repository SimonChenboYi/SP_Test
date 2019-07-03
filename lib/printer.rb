# frozen_string_literal: true

# print the lists
class Printer
  def print_in_visits_format(visit_list)
    puts 'list of webpages with total visits:'
    visit_list.each do |visit|
      puts "#{visit[0]} #{visit[1].count} #{visit[1].count > 1 ? 'visits' : 'visit'}"
    end
  end

  def print_in_unique_views_format(unique_view_list)
    puts 'list of webpages with unique views:'
    unique_view_list.each do |view|
      puts "#{view[0]} #{view[1].count} unique #{view[1].count > 1 ? 'views' : 'view'}"
    end
  end
end
