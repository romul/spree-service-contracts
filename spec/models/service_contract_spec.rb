require File.dirname(__FILE__) + '/../spec_helper'

describe ServiceContract do
  before(:each) do
    @service_contract = ServiceContract.new
  end

  it "should be valid" do
    @service_contract.should be_valid
  end
end
