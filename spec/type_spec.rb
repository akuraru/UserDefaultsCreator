require 'spec_helper'

describe Udgenerator do
  before(:all) {
    @creater = Udgenerator::Core.new
  }
  context 'Type' do
    it :expect do
      expect(@creater.exchange([""])).to eq []
    end
    Udgenerator::c.each { |d|
      context d[:string] do
        before(:each) {
          @exchange = @creater.exchange([d[:text]])[0]
        }
        it :expect do
          expect(@exchange).to eq d[:exchange]
        end
        it :capitalize do
          expect(@exchange.capitalize).to eq d[:capitalize]
        end
        it :define do
          expect(@exchange.define).to eq d[:define]
        end
        it :to_nsstring do
          expect(@exchange.to_nsstring).to eq d[:to_nsstring]
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
