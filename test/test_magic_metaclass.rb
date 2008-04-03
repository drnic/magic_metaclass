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
      PersonClass
      PersonEigen
      PersonEigenclass
    end
  end

  def test_magic_class_is_metaclass
    metaclass = class << Person; self; end
    assert_equal(metaclass, PersonMetaclass)
    assert_equal(metaclass, PersonClass)
    assert_equal(metaclass, PersonEigenclass)
    assert_equal(metaclass, PersonEigen)
  end
  
  def test_badclass
    assert_raise(NameError) { PersonXXX }
    assert_raise(NameError) { XXX }
  end
  
  def test_metaclass_name_but_no_actual_class
    assert_raise(NameError) { SomeclassMetaclass }
    assert_raise(NameError) { SomeclassClass }
    assert_raise(NameError) { SomeclassEigen }
    assert_raise(NameError) { SomeclassEigenclass }
  end
end
