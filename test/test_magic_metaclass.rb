require File.dirname(__FILE__) + '/test_helper.rb'

class Person
end

class TestMagicMetaclass < Test::Unit::TestCase

  def setup
    Object.const_remove("PersonMetaclass") if Object.const_defined?("PersonMetaclass")
  end
  
  def test_meta
    assert_nothing_thrown do
      PersonMetaclass
      metaclass = class << Person; self; end
      assert_equal(metaclass, PersonMetaclass)
    end
  end
end
