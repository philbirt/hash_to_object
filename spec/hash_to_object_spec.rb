require 'lib/hash_to_object.rb'

describe HashToObject do
  class Dummy
    include HashToObject
    def initialize(options = {})
      objectify(options)
    end
  end

  class Dummy::Item
    include HashToObject
    def initialize(options = {})
      objectify(options)
    end
  end

  class TopLevel
    include HashToObject
    def initialize(options = {})
      objectify(options)
    end
  end

  before do
    Settings = stub unless Object.const_defined?(:Settings)
    Settings.stub_chain(:hash_to_object, :send).and_return(nil)
  end
  
  context "creates a new object based on a class and a hash" do
    before :each do
      @dummy = Dummy.new({"amount" => 1, "body" => "text", "admin" => true})
    end
    it "has a class that matches the parameters" do
      @dummy.class.should == Dummy
    end

    it "creates instance variables based on the hash" do
      @dummy.amount.should == 1
      @dummy.body.should == "text"
      @dummy.admin.should == true
    end

    context "creates associations" do
      context "creates a new object if the association is 1:1" do
        before :each do
        @dummy = Dummy.new({"amount" => 1, "body" => "text", "admin" => true, "item" => {"foo" => "bar"}})
        end
        it "has a class that matches the parameters" do
          @dummy.item.class.should == Dummy::Item
        end

        it "creates instance variables based on the hash" do
          @dummy.item.foo.should == "bar"
        end          
      end

      context "creates an array of new objects if the association is 1:many" do
        before :each do
        @dummy = Dummy.new({"amount" => 1, "body" => "text", "admin" => true, "items" => [{"foo" => "bar"}, {"bar" => "baz"}]})
        end
        it "creates an instance variable based on the array" do
          @dummy.items.class.should == Array
        end
        it "creates objects of the desired class in the array" do
          @dummy.items.first.class.should == Dummy::Item
        end
      end
    end
  end

  context "throws exceptions if classes are undefined" do
    it "throws a NameError if the parent class provided is undefined" do
      lambda{Foo.new({"foo" => "bar"})}.should raise_error(NameError)
    end

    it "throws a NameError if a subclass is undefined" do
      lambda{Dummy.new({"foo" => "bar", "bar" => {"admin" => true}})}.should raise_error(NameError)
    end
  end

  it "creates objects of pre-defined classes if they are in hash_to_object.yml config" do
    pending
    Settings.stub_chain(:hash_to_object, :send).and_return('TopLevel')
    @dummy = Dummy.new({"amount" => 1, "body" => "text", "admin" => true, "top_level" => {"foo" => "bar"}})
    @dummy.top_level.class.should == TopLevel
  end
end
