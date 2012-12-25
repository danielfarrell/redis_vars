require "spec_helper"
require "redis_vars/store"

describe "RedisVars::Store" do
  subject { RedisVars::Store.new }

  describe "add" do
    before { subject.expects(:app_key).returns("test_key") }
    it "should delegate to redis.hset" do
      Redis.any_instance.expects(:hset).with("test_key", "TEST_VAR", "working")
      subject.add "TEST_VAR", "working"
    end
    it "should upcase variable" do
      Redis.any_instance.expects(:hset).with("test_key", "TEST_VAR2", "upcasing")
      subject.add "test_var2", "upcasing"
    end
  end

  describe "remove" do
    before do
      subject.expects(:app_key).returns("test_key")
      Redis.any_instance.expects(:hdel).with("test_key", "TEST_VAR")
    end
    it "should delegate to redis.hdel" do
      subject.remove "TEST_VAR"
    end
  end

  describe "hash" do
    before do
      subject.expects(:app_key).returns("test_key")
      @test_hash = {"TEST_VAR" => "working"}
      Redis.any_instance.expects(:hgetall).with("test_key").returns(@test_hash)
    end

    it "should delegate to redis.hgetall" do
      subject.hash
    end
    it "should return a hash" do
      subject.hash.should == @test_hash
    end
  end

  describe "list" do
    before { subject.expects(:hash).returns({"TEST_VAR" => "working", "test_var2" => "upcasing"}) }
    it "should return all variables in a list" do
      subject.list.should == "TEST_VAR=working\nTEST_VAR2=upcasing"
    end
  end

  describe "export" do
    before { subject.expects(:hash).returns({"TEST_VAR" => "working", "test_var2" => "upcasing"}) }
    it "should return all variables in an export list" do
      subject.export.should == "export TEST_VAR=working\nexport TEST_VAR2=upcasing"
    end
  end

  describe "execute" do
    before { subject.expects(:hash).returns({"TEST_VAR" => "working", "test_var2" => "upcasing"}) }
    it "should return all variables in an list on one line" do
      subject.execute.should == "TEST_VAR=working TEST_VAR2=upcasing"
    end
  end

end
