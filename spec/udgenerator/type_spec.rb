require 'spec_helper'

describe Udgenerator do
  before(:all) {
    @creater = Udgenerator::Core.new
  }
  context 'Type' do
    Udgenerator::c.each { |d|
      context d[:string] do
        before(:each) {
          @exchange = @creater.exchange([d[:text]])
        }
        it :capitalize do
          expect(@creater.capitalize(d[:key])).to eq d[:capitalize]
        end
        it :define do
          expect(@creater.define(d[:key])).to eq d[:define]
        end
        it :to_nsstring do
          expect(@creater.to_nsstring(d[:key])).to eq d[:to_nsstring]
        end
        it :type_name do
          expect(@exchange.type_name).to eq d[:type_name]
        end
        it :interface_getter do
          expect(@exchange.interface_getter).to eq d[:interface_getter]
        end
        it :interface_setter do
          expect(@exchange.interface_setter).to eq d[:interface_setter]
        end
        it :imp_define do
          expect(@exchange.imp_define).to eq d[:imp_define]
        end
        it :register_default do
          expect(@exchange.register_default).to eq d[:register_default]
        end
        it :imp_get_message do
          expect(@exchange.imp_get_message).to eq d[:imp_get_message]
        end
        it :imp_set_message do
          expect(@exchange.imp_set_message).to eq d[:imp_set_message]
        end
      end
    }
  end
end
