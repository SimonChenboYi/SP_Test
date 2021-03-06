# frozen_string_literal: true

require 'printer'

describe Printer do
  url1 = '/contact'
  url2 = '/home'
  ip1 = '235.313.352.950'
  ip2 = '184.123.665.067'

  describe '#print_in_visits_format' do
    it 'print when there is one webpage visit' do
      visit_list = [[url1, [ip1]]]
      expect { subject.print_in_visits_format(visit_list) }
        .to output("list of webpages with total visits:\n/contact 1 visit\n").to_stdout
    end

    it 'print when there are multiple webpage visits' do
      visit_list = [[url2, [ip1, ip1]]]
      expect { subject.print_in_visits_format(visit_list) }
        .to output("list of webpages with total visits:\n/home 2 visits\n").to_stdout
    end

    it 'print when multiple webpages were visited' do
      visit_list = [[url2, [ip2, ip2]],
                    [url1, [ip1]]]
      expect { subject.print_in_visits_format(visit_list) }
        .to output("list of webpages with total visits:\n/home 2 visits\n/contact 1 visit\n")
        .to_stdout
    end
  end

  describe '#print_in_unique_views_format' do
    it 'print when webpage was viewed by one unique ip' do
      unique_view_list = [[url1, [ip2]]]
      expect { subject.print_in_unique_views_format(unique_view_list) }
        .to output("list of webpages with unique views:\n/contact 1 unique view\n").to_stdout
    end

    it 'print when webpage was viewed by multiple unique ips' do
      unique_view_list = [[url2, [ip1, ip2]]]
      expect { subject.print_in_unique_views_format(unique_view_list) }
        .to output("list of webpages with unique views:\n/home 2 unique views\n").to_stdout
    end

    it 'print when multiple webpages were viewed' do
      unique_view_list = [[url2, [ip1, ip2]], [url1, [ip1]]]
      expect { subject.print_in_unique_views_format(unique_view_list) }
        .to output("list of webpages with unique views:\n/home 2 unique views\n" \
          "/contact 1 unique view\n").to_stdout
    end
  end
end
