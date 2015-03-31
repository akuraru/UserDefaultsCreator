require 'spec_helper'
require 'udgenerator_expected'

describe Udgenerator do
  it 'has a version number' do
    expect(Udgenerator::VERSION).not_to be "1.0.0"
  end

  before(:all) {
    @creater = Udgenerator::Core.new
  }
  context 'userdefaults' do
    it 'does something useful' do
      text = @creater.fileRead('file/Base.h')
      ex = [
        "NSString *hogeHoge;",
        "NSData *ddd;",
        "NSInteger i;",
        "BOOL b;",
        "float f;",
        "double d;",
        "NSArray* ary;",
        "NSDictionary* dic;",
        "NSDate * day;",
        "NSURL * url;",
      ]
      expect(text).to eq ex
    end

    before {
      @exchange = @creater.exchange(Udgenerator::c.map{|d| d[:text]})
    }
    context 'header' do
      it 'true' do
        expect(@creater.header(@exchange, "UserDefaults", true)).to eq Udgenerator::expected[:header][:true]
      end
      it 'false' do
        expect(@creater.header(@exchange, "UserDefaults", false)).to eq Udgenerator::expected[:header][:false]
      end
    end
    context 'method' do
      it 'true' do
        expect(@creater.method(@exchange, "UserDefaults", true)).to eq Udgenerator::expected[:method][:true]
      end
      it 'false' do
        expect(@creater.method(@exchange, "UserDefaults", false)).to eq Udgenerator::expected[:method][:false]
      end
    end
    context 'swift' do
      it 'true' do
        expect(@creater.swift(@exchange, "UserDefaults", true)).to eq Udgenerator::expected[:swift][:true]
      end
      it 'false' do
        expect(@creater.swift(@exchange, "UserDefaults", false)).to eq Udgenerator::expected[:swift][:false]
      end
    end
    context :command do
      before {
        Dir.mkdir("tmp") unless Dir.exist?("tmp")
      }
      after {
        # dir = "tmp"
        # Dir::glob(dir + "**/").sort {
        #   |a,b| b.split('/').size <=> a.split('/').size
        # }.each {|d|
        #   Dir::foreach(d) {|f|
        #     File::delete(d+f) if ! (/\.+$/ =~ f)
        #   }
        #   Dir::rmdir(d)
        # }
        Dir.mkdir("tmp") unless Dir.exist?("tmp")
      }
      context 'true' do
        before(:all) {
          # @creater.generator({auto_init: true, input: "./file/Base.h", output: "./tmp/true/", file_name: "UserDefaults", swift: false})
          # @creater.generator({auto_init: true, input: "./file/Base.swift", output: "./tmp/true/", file_name: "UserDefaults", swift: true})
        }
        it 'header' do
          text = File.read('./tmp/true/UserDefaults.h', :encoding => Encoding::UTF_8)
          expect(text).to eq Udgenerator::expected[:header][:true]
        end
        it 'method' do
          text = File.read('./tmp/true/UserDefaults.m', :encoding => Encoding::UTF_8)
          expect(text).to eq Udgenerator::expected[:method][:true]
        end
        it 'swift' do
          text = File.read('./tmp/true/UserDefaults.swift', :encoding => Encoding::UTF_8)
          expect(text).to eq Udgenerator::expected[:swift][:true]
        end
      end
      context 'false' do
        before(:all) {
          # @creater.generator({auto_init: false, input: "./file/Base.h", output: "./tmp/false/", file_name: "UserDefaults", swift: false})
          # @creater.generator({auto_init: false, input: "./file/Base.swift", output: "./tmp/false/", file_name: "UserDefaults", swift: true})
        }
        it 'header' do
          text = File.read('./tmp/false/UserDefaults.h', :encoding => Encoding::UTF_8)
          expect(text).to eq Udgenerator::expected[:header][:false]
        end
        it 'method' do
          text = File.read('./tmp/false/UserDefaults.m', :encoding => Encoding::UTF_8)
          expect(text).to eq Udgenerator::expected[:method][:false]
        end
        it 'swift' do
          text = File.read('./tmp/false/UserDefaults.swift', :encoding => Encoding::UTF_8)
          expect(text).to eq Udgenerator::expected[:swift][:false]
        end
      end
    end
    context :reupdate do
      context 'header' do
        before {
          @exchange = @creater.exchange(Udgenerator::expected[:header][:true].scan(/(.*)\n/).flatten)
        }
        it 'true' do
          expect(@creater.header(@exchange, "UserDefaults", true)).to eq Udgenerator::expected[:header][:true]
        end
        it 'false' do
          expect(@creater.header(@exchange, "UserDefaults", false)).to eq Udgenerator::expected[:header][:false]
        end
      end
      context 'method' do
        before {
          @exchange = @creater.exchange(Udgenerator::expected[:header][:true].scan(/(.*)\n/).flatten)
        }
        it 'true' do
          expect(@creater.method(@exchange, "UserDefaults", true)).to eq Udgenerator::expected[:method][:true]
        end
        it 'false' do
          expect(@creater.method(@exchange, "UserDefaults", false)).to eq Udgenerator::expected[:method][:false]
        end
      end
      context 'swift' do
        before {
          @exchange = @creater.swift_exchange(Udgenerator::expected[:swift][:true].scan(/(.*)\n/).flatten)
        }
        it 'true' do
          expect(@creater.swift(@exchange, "UserDefaults", true)).to eq Udgenerator::expected[:swift][:true]
        end
        it 'false' do
          expect(@creater.swift(@exchange, "UserDefaults", false)).to eq Udgenerator::expected[:swift][:false]
        end
      end

    end
  end
end
