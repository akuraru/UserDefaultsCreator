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
        "NSString *itIsLongName;",
        "NSNumber *number;",
        "NSArray *array;",
        "NSDictionary *dict;",
        "NSData *data;",
        "NSDate *date;",
        "NSInteger i;",
        "BOOL b;",
        "float f;",
        "double d;",
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

    end
  end
end
