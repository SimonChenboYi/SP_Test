# frozen_string_literal: true

require 'parser'

describe Parser do
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
end
