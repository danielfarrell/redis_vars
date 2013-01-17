require "spec_helper"
require "redis_vars/cli"

describe "RedisVars::CLI" do

  describe "add" do
    before { RedisVars::Store.any_instance.expects(:add).with("TEST_VAR", "working") }
    it "should delegate to store.add" do
      redis_vars("add TEST_VAR working")
    end
  end

  describe "remove" do
    before { RedisVars::Store.any_instance.expects(:remove).with("TEST_VAR") }
    it "should delegate to store.remove " do
      redis_vars("remove TEST_VAR")
    end
  end

  describe "list" do
    before { RedisVars::Store.any_instance.expects(:list).returns("TEST_VAR=working") }
    it "should delegate to store.list" do
      redis_vars("list")
    end
    it "should display list of all variables" do
      redis_vars("list").chomp.should == "TEST_VAR=working"
    end
  end

  describe "export" do
    before { RedisVars::Store.any_instance.expects(:export).returns("export TEST_VAR=working") }
    it "should delegate to store.export" do
      redis_vars("export")
    end
    it "should display list of all variables in export format" do
      redis_vars("export").chomp.should == "export TEST_VAR=working"
    end
  end

  describe "exec" do
    before do
      RedisVars::Store.any_instance.expects(:hash).returns({"TEST_VAR" => "working"})
      Kernel.expects(:exec).with({"TEST_VAR" => "working"}, "echo", "test")
    end
    it "should delegate to store.execute and exec command" do
      redis_vars("exec echo test")
    end
  end

  describe "version" do
    it "should display gem version" do
      redis_vars("version").chomp.should == RedisVars::VERSION
    end
  end

end
