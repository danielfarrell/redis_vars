require "spec_helper"
require "redis_vars"

describe "RedisVars" do

  describe "VERSION" do
    subject { RedisVars::VERSION }
    it { should be_a String }
  end

  describe "load" do
    before { RedisVars::Store.any_instance.expects(:hash).returns({'TEST_VAR' => 'working'}) }
    it "should load ENV with data from store" do
      ENV["TEST_VAR"] = nil
      RedisVars.load
      ENV["TEST_VAR"].should == "working"
    end
    it "should not overwrite previous set env vars" do
      test_val = "previous"
      ENV["TEST_VAR"] = test_val
      RedisVars.load
      ENV["TEST_VAR"].should == test_val
    end
  end
end
