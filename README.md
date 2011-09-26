HashToObject
============

HashToObject is a mixin for converting hashes into ruby objects.  For instance, if you wanted an Order class that could be instantiated from a hash, you could define it as such:

    class Order
      include HashToObject

      def initialize(options = {})
        objectify(options)
      end
    end

And you have a hash like such:
 
   hash_to_object = {:amount => 25, :type => "credit", :admin => false}

Then you can call `Order.new(hash_to_object)` and get an `Order` object with instance variables `@amount`, `@type`, `@admin`.

Nesting
=======
HashToObject also supports nesting of object creation.  It defines the nested objects' class based on the name of the parent class and the singularized key name of the nested value.

Example:

    Order.new({:item => {:name => "foo"}, :transactions => [{:id => "bar"},{:id => "baz"}])

This would create an object of type `Order`, with instance variables `@item` and `@transactions` linking to objects of type `Order::Item` (with instance variable `@name`), and `Order::Transaction` (with instance variable `@id`).  

The only caveat is that you need to have `Order::Item` and `Order::Transaction` defined, and mix-in HashToObject similarly to `Order` above.
