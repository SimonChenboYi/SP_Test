# frozen_string_literal: true

require 'parser'

describe Parser do
  let(:printer) { double(:printer, print_in_visits_format: '', print_in_unique_views_format: '') }
  subject { described_class.new(printer) }

  before do
    allow(File).to receive(:file?).and_return(true)
  end

  describe '#read_log' do
    context 'When file exsits and is not empty' do
      it 'transfer the log file data into a hash' do
        file1 = 'file1.log'
        content1 = '/home 235.313.352.950'
        allow(File).to receive(:open).with(file1, 'r').and_yield(StringIO.new(content1))
        expect(subject.read_log(file1)).to eq('/home' => ['235.313.352.950'])
      end

      it 'transfer another log file data into a hash' do
        file2 = 'file2.log'
        content2 = '/contact 184.123.665.067'
        allow(File).to receive(:open).with(file2, 'r').and_yield(StringIO.new(content2))
        expect(subject.read_log(file2)).to eq('/contact' => ['184.123.665.067'])
      end

      it 'add the ips to an array when visited the same page ' do
        file3 = 'file3.log'
        content2 = "/home 184.123.665.067\n/home 235.313.352.950"
        allow(File).to receive(:open).with(file3, 'r').and_yield(StringIO.new(content2))
        expect(subject.read_log(file3)).to eq('/home' => ['184.123.665.067', '235.313.352.950'])
      end
    end

    context 'When file does not exsit' do
      it 'raise an error when filemame is wrong' do
        file4 = 'not_exsit.log'
        allow(File).to receive(:file?).and_return(false)
        expect { subject.read_log(file4) }
          .to raise_error('file does not exsit, please check again')
      end
    end

    context 'when file is empty' do
      it 'raise an error when file is empty' do
        file5 = 'empty.log'
        content5 = ''
        allow(File).to receive(:open).with(file5, 'r').and_yield(StringIO.new(content5))
        expect { subject.read_log(file5) }. to raise_error('file is empty, please check again')
      end
    end
  end

  describe '#order_by_visits' do
    it 'sort the pages by number of total visits' do
      file6 = 'file6.log'
      content6 = "/home 184.123.665.067\n/home 235.313.352.950\n/contact 184.123.665.067"
      allow(File).to receive(:open).with(file6, 'r').and_yield(StringIO.new(content6))
      subject.read_log(file6)
      expect(subject.order_by_visits).to eq [['/home', ['184.123.665.067', '235.313.352.950']],
                                             ['/contact', ['184.123.665.067']]]
    end

    it 'sort the pages in alphabetical order when having same total visits' do
      file7 = 'file7.log'
      content7 = "/home 184.123.665.067\n/home 235.313.352.950\n" \
                 "/contact 184.123.665.067\n/index 158.577.775.616\n/index 722.247.931.582"
      allow(File).to receive(:open).with(file7, 'r').and_yield(StringIO.new(content7))
      subject.read_log(file7)
      expect(subject.order_by_visits).to eq [['/home', ['184.123.665.067', '235.313.352.950']],
                                             ['/index', ['158.577.775.616', '722.247.931.582']],
                                             ['/contact', ['184.123.665.067']]]
    end
  end

  describe '#order_by_uniq_views' do
    it 'sort the page by number of unique ips - no repeated ip' do
      file8 = 'file8.log'
      content8 = "/home 184.123.665.067\n/home 235.313.352.950\n/contact 184.123.665.067"
      allow(File).to receive(:open).with(file8, 'r').and_yield(StringIO.new(content8))
      subject.read_log(file8)
      expect(subject.order_by_uniq_views).to eq [['/home', ['184.123.665.067', '235.313.352.950']],
                                                 ['/contact', ['184.123.665.067']]]
    end

    it 'sort the page by number of uniq ips - repeated ip' do
      file9 = 'file9.log'
      content9 = "/home 235.313.352.950\n/home 235.313.352.950\n/home 235.313.352.950\n" \
                 "/index 158.577.775.616\n/index 722.247.931.582"
      allow(File).to receive(:open).with(file9, 'r').and_yield(StringIO.new(content9))
      subject.read_log(file9)
      expect(subject.order_by_uniq_views)
        .to eq [['/index', ['158.577.775.616', '722.247.931.582']],
                ['/home', ['235.313.352.950']]]
    end

    it 'sort the page by number of uniq ips and in alphabetical order  - repeated ip' do
      file10 = 'file10.log'
      content10 = "/home 184.123.665.067\n/home 235.313.352.950\n/contact 184.123.665.067\n" \
                 "/index 158.577.775.616\n/index 722.247.931.582"
      allow(File).to receive(:open).with(file10, 'r').and_yield(StringIO.new(content10))
      subject.read_log(file10)
      expect(subject.order_by_uniq_views)
        .to eq [['/home', ['184.123.665.067', '235.313.352.950']],
                ['/index', ['158.577.775.616', '722.247.931.582']],
                ['/contact', ['184.123.665.067']]]
    end
  end

  describe '#print_list_of_visits' do
    it 'print the list in_visits_format' do
      expect(printer). to receive(:print_in_visits_format)
      subject.print_list_of_visits
    end
  end

  describe '#print_list_of_unique_views' do
    it 'print the list in_unique_views_format' do
      expect(printer). to receive(:print_in_unique_views_format)
      subject.print_list_of_unique_views
    end
  end
end
