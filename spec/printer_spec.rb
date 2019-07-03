# frozen_string_literal: true

require 'printer'

describe Printer do
  describe '#print_in_visits_format' do
    it 'print when there is one webpage visit' do
      visit_list = [['/contact', ['184.123.665.067']]]
      expect { subject.print_in_visits_format(visit_list) }
        .to output("list of webpages with total visits:\n/contact 1 visit\n").to_stdout
    end

    it 'print when there are multiple webpage visits' do
      visit_list = [['/home', ['184.123.665.067', '184.123.665.067']]]
      expect { subject.print_in_visits_format(visit_list) }
        .to output("list of webpages with total visits:\n/home 2 visits\n").to_stdout
    end

    it 'print when multiple webpages were visited' do
      visit_list = [['/home', ['184.123.665.067', '184.123.665.067']],
                    ['/contact', ['184.123.665.067']]]
      expect { subject.print_in_visits_format(visit_list) }
        .to output("list of webpages with total visits:\n/home 2 visits\n/contact 1 visit\n")
        .to_stdout
    end
  end
end
