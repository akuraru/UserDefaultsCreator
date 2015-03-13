require 'spec_helper'

describe Udgenerator do
	before {
		@parser = Udgenerator::Objective.new
    @creater = Udgenerator::Core.new
	}
	context 'Type' do
		it :expect do
			expect(@creater.exchange([""])).to eq({})
		end
		Udgenerator::c.each { |d|
			context d[:string] do
				before(:each) {
					@exchange = @creater.exchange([d[:text]])
				}
				it :expect do
					expect(@exchange).to eq d[:exchange]
				end
				it :has_key? do
					expect(@exchange.has_key?(d[:key])).to eq true
				end
			end
		}
	end
end
