HashToObject
============

HashToObject is a mixin for converting hashes into ruby objects.  For instance, if you wanted to build Foo objects, you could define it as such:

    class Foo
      include HashToObject

      def initialize(options = {})
        objectify(options)
      end
    end

You can now build new Foo objects with arbitrary key value pairs and have access to them.
    
    foo = Foo.new('bar' => 'baz', 'qux' => [1,2,3])
    
    foo.bar
    => "baz"
    foo.bar = "garply"
    => "garply"
    
    quux = Foo.new('corge' => 'grault')
    
    quux.bar
    => NoMethodError: undefined method 'bar'
    quux.corge
    => "grault"


Recursion and Nesting
=====================
HashToObject also supports nesting of object creation.  Note that you will need classes that correspond to the hash structure.

    class Foo::Item
      include HashToObject

      def initialize(options = {})
        objectify(options)
      end
    end
    
    class Foo::Lolipop
      include HashToObject

      def initialize(options = {})
        objectify(options)
      end

      def waldo
        "Where in the world is #{@id}?"
      end
    end

    foo = Foo.new('item' => {'name' => 'foo'}, 'lolipops' => [{'id'=> 'bar'}, {'id'=> 'baz'}])

    foo.item
    => #<Foo::Item:0x007fbf40ee1e78 @name="foo">
    foo.lolipops
    => [#<Foo::Lolipop:0x007fbf429d4780 @id="bar">, #<Foo::Lolipop:0x007fbf42bc1a48 @id="baz">]
    foo.lolipops.first.waldo
    => "Where in the world is bar?"
