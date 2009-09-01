require 'rubygems'
require 'test/unit'
require 'active_support/test_case'
require File.expand_path(File.dirname(__FILE__) + "/../lib/number_to_chinese_amount_in_words_helper")

class NumberToChineseAmountInWordsHelperTest < ActiveSupport::TestCase
  include NumberToChineseAmountInWordsHelper

  def test_greater_than_zero
    assert_equal '壹万元整', number_to_capital_zh(10000.00)
    assert_equal '壹拾万元壹角整', number_to_capital_zh(100000.10)
    assert_equal '壹角整', number_to_capital_zh(0.1)
    assert_equal '壹元壹角壹分', number_to_capital_zh(1.11)
    assert_equal '壹元零壹分', number_to_capital_zh(1.01)
    assert_equal '壹分', number_to_capital_zh(0.01)
    assert_equal '壹元整', number_to_capital_zh(1)
    assert_equal '壹拾元整', number_to_capital_zh(10)
    assert_equal '壹拾万零壹拾元壹角整', number_to_capital_zh(100010.10)
    assert_equal '壹亿元整', number_to_capital_zh(100000000)
    assert_equal "壹仟零贰拾玖元伍角玖分", number_to_capital_zh(1029.59)
    assert_equal "壹仟零贰拾玖元伍角捌分", number_to_capital_zh(1029.58)
    assert_equal "壹仟零贰拾玖元陆角整", number_to_capital_zh(1029.6)
    assert_equal "壹仟零贰拾玖元整", number_to_capital_zh(1029)
  end

  def test_equal_than_zero
    assert_equal '零', number_to_capital_zh(0)
    assert_equal '零', number_to_capital_zh(0.0)
    assert_equal '零', number_to_capital_zh(0.00)
    assert_equal '零', number_to_capital_zh(-0)
    assert_equal '零', number_to_capital_zh(-0.0)
    assert_equal '零', number_to_capital_zh(-0.00)
  end

  def test_less_than_zero
    assert_equal("负叁佰陆拾元整", number_to_capital_zh(-360.0))
    assert_equal '负壹万元整', number_to_capital_zh(-10000.00)
    assert_equal '负壹拾万元壹角整', number_to_capital_zh(-100000.10)
    assert_equal '负壹角整', number_to_capital_zh(-0.1)
    assert_equal '负壹元壹角壹分', number_to_capital_zh(-1.11)
    assert_equal '负壹元零壹分', number_to_capital_zh(-1.01)
    assert_equal '负壹分', number_to_capital_zh(-0.01)
    assert_equal '负壹元整', number_to_capital_zh(-1)
    assert_equal '负壹拾元整', number_to_capital_zh(-10)
    assert_equal '负壹拾万零壹拾元壹角整', number_to_capital_zh(-100010.10)
    assert_equal '负壹亿元整', number_to_capital_zh(-100000000)
    assert_equal "负壹仟零贰拾玖元零贰分", number_to_capital_zh(-1029.015)
    assert_equal "负壹仟零贰拾玖元伍角玖分", number_to_capital_zh(-1029.59)
    assert_equal "负壹仟零贰拾玖元伍角捌分", number_to_capital_zh(-1029.58)
    assert_equal "负壹仟零贰拾玖元陆角整", number_to_capital_zh(-1029.6)
    assert_equal "负壹仟零贰拾玖元整", number_to_capital_zh(-1029)
    assert_equal "负壹仟零贰拾玖元零贰分", number_to_capital_zh(-1029.015)
  end

  def test_tip
    assert_raise(RuntimeError) {
      assert_equal '整数部分加二位小数长度不能大于15', number_to_capital_zh(10000000000000000)
    }
    assert_raise(RuntimeError) {
      assert_equal '整数部分加二位小数长度不能大于15', number_to_capital_zh(1000000000000000.0)
    }
    assert_raise(RuntimeError) {
      assert_equal '整数部分加二位小数长度不能大于15', number_to_capital_zh(1000000000000000.01)
    }
  end
end
