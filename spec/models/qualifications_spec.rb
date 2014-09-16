require 'spec_helper'

describe Qualification do

    it { should respond_to(:key) }
    it { should respond_to(:name) }
    it { should respond_to(:country) }
    it { should respond_to(:subjects_data) }
    it { should respond_to(:link) }
    it { should respond_to(:default_products) }

    it { should validate_presence_of :key }
    it { should validate_uniqueness_of :key }

	describe ".parse_url_data" do
		it "responds with valid JSON" do
	  		expect {
	  		  Qualification.parse_url_data
	  		}.to_not raise_error
	  	end
	end

	describe ".last_modified" do
		it "should be a valid date" do
			date = Qualification.last_modified
			expect(date).to be < Date.tomorrow
		end
	end

	describe ".create_qualification" do
		let!(:qualification) { FactoryGirl.create(:qualification) }

		context "with a duplicate key" do
			it "should not be valid" do
				object = { "id" => qualification.key }
				Qualification.create_qualification(object)
				Qualification.count.should == 1
			end
		end

		context "with a valid key" do
			it "should not be valid" do
				object = { "id" => "0fe4c738-f43c-4a66-bd5b-fc9cf6255355" }
				Qualification.create_qualification(object)
				Qualification.count.should == 2
			end
		end
	end

	describe ".update_qualifications" do
		it "should create new qualification records" do
			Qualification.update_qualifications
			Qualification.count.should > 0
		end
	end
end