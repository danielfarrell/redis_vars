require "spec_helper"
require "redis_vars/config"

describe "RedisVars::Config" do
  subject { RedisVars::Config.new }

  describe "url" do
    it "should allow setting url from env var" do
      test_url = "redis://testing/5"
      ENV["REDIS_VARS_URL"] = test_url
      subject.url.should == test_url
    end
    it "should return nil if no env var" do
      ENV["REDIS_VARS_URL"] = nil
      subject.url.should == nil
    end
  end

  describe "app_key" do
    it "should allow setting app_key from env var" do
      test_key = "testing_key"
      ENV["APP_KEY"] = test_key
      subject.app_key.should == test_key
    end
    it "should default to pwd" do
      ENV["APP_KEY"] = nil
      test_pwd = "test"
      subject.expects(:pwd).returns(test_pwd)
      subject.app_key.should == test_pwd
    end
  end

  describe "pwd" do
    before { Dir.expects(:pwd).returns("/var/www/app_name") }
    it "should display folder name of of the pwd" do
      subject.pwd.should == "app_name"
    end
  end

end
