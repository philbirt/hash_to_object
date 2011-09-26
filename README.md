HashToObject
============

HashToObject is a mixin for converting hashes into ruby objects.  For instance, if you have a class defined as such:

    class Order
      include HashToObject

      def initialize(options = {})
        objectify(options)
      end
    end

And you have a hash like such: `opts = {:amount => 25, :type => "credit", :admin => false}`, then you can call `Order.new(opts)` and get a ruby object with instance variables `@amount`, `@type`, `@admin`.

HashToObject also supports nesting of objects.  It defines the nested objects based on the name of the parent class, and the key name of the nested value.

Example: `Order.new({:amount => 25, :type => "credit", :admin => false, :item => {:name => "foo"}, :transactions => [{:id => "bar"},{:id => "baz"}])`

This would create objects of type `Order::Item` with an instance variable for name, and `Order::Transaction` with instance variable `@id`.  The only caveat is that you need to have Order::Item and Order::Transaction defined.
