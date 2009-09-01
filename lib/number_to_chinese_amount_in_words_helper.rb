module NumberToChineseAmountInWordsHelper
  # Formats a +number+ into a chinese amount in words(e.g., 壹万元整).
  #
  # === Examples
  # number_to_capital_zh(10001.00)                   # => '壹万元整', 
  # number_to_capital_zh(100000.10)              # => '壹拾万元壹角整', 
  # number_to_capital_zh(0.1)                    # => '壹角整', 
  # number_to_capital_zh(1.11)                   # => '壹元壹角壹分', 
  # number_to_capital_zh(1.01)                   # => '壹元零壹分', 
  # number_to_capital_zh(0.01)                   # => '壹分', 
  # number_to_capital_zh(1)                      # => '壹元整', 
  # number_to_capital_zh(10)                     # => '壹拾元整', 
  # number_to_capital_zh(100010.10)              # => '壹拾万零壹拾元壹角整',
  # number_to_capital_zh(100000000)              # => '壹亿元整', 
  # number_to_capital_zh(1029.59)                # => '壹仟零贰拾玖元伍角玖分', 
  # number_to_capital_zh(1029.58)                # => '壹仟零贰拾玖元伍角捌分', 
  # number_to_capital_zh(1029.6)                 # => '壹仟零贰拾玖元陆角整', 
  # number_to_capital_zh(1029)                   # => '壹仟零贰拾玖元整', 
  #
  # number_to_capital_zh(0)                      # => '零', 
  # number_to_capital_zh(0.0)                    # => '零', 
  # number_to_capital_zh(0.00)                   # => '零', 
  # number_to_capital_zh(-0)                     # => '零', 
  # number_to_capital_zh(-0.0)                   # => '零', 
  # number_to_capital_zh(-0.00)                  # => '零', 
  #
  # number_to_capital_zh(-360.0)                 # => '负叁佰陆拾元整', 
  # number_to_capital_zh(-10000.00)              # => '负壹万元整', 
  # number_to_capital_zh(-100000.10)             # => '负壹拾万元壹角整', 
  # number_to_capital_zh(-0.1)                   # => '负壹角整', 
  # number_to_capital_zh(-1.11)                  # => '负壹元壹角壹分', 
  # number_to_capital_zh(-1.01)                  # => '负壹元零壹分', 
  # number_to_capital_zh(-0.01)                  # => '负壹分', 
  # number_to_capital_zh(-1)                     # => '负壹元整', 
  # number_to_capital_zh(-10)                    # => '负壹拾元整', 
  # number_to_capital_zh(-100010.10)             # => '负壹拾万零壹拾元壹角整', 
  # number_to_capital_zh(-100000000)             # => '负壹亿元整', 
  # number_to_capital_zh(-1029.015)              # => '负壹仟零贰拾玖元零贰分', 
  # number_to_capital_zh(-1029.59)               # => '负壹仟零贰拾玖元伍角玖分', 
  # number_to_capital_zh(-1029.58)               # => '负壹仟零贰拾玖元伍角捌分', 
  # number_to_capital_zh(-1029.6)                # => '负壹仟零贰拾玖元陆角整', 
  # number_to_capital_zh(-1029)                  # => '负壹仟零贰拾玖元整', 
  # number_to_capital_zh(-1029.015)              # => '负壹仟零贰拾玖元零贰分', 
  def number_to_capital_zh(n)
    cNum = ["零","壹","贰","叁","肆","伍","陆","柒","捌","玖","-","-","万","仟","佰","拾","亿","仟","佰","拾","万","仟","佰","拾","元","角","分"]
    cCha = [['零元','零拾','零佰','零仟','零万','零亿','亿万','零零零','零零','零万','零亿','亿万','零元'], [ '元','零','零','零','万','亿','亿','零','零','万','亿','亿','元']]

    i = 0
    sNum = ""
    sTemp = ""
    result = ""
    tmp = ("%.0f" % (n.abs.to_f * 100)).to_i
    return '零' if tmp == 0
    raise '整数部分加二位小数长度不能大于15' if tmp.to_s.size > 15
    sNum = tmp.to_s.rjust(15, ' ')

    for i in 0..14
      stemp = sNum.slice(i, 1)
      if stemp == ' '
        next
      else
        result += cNum[stemp.to_i] + cNum[i + 12];
      end
    end

    for m in 0..12
      result.gsub!(cCha[0][m], cCha[1][m])
    end

    if result.index('零分').nil? # 没有分时, 零角改成零
      result.gsub!('零角','零')
    else
      if result.index('零角').nil? # 有没有分有角时, 后面加"整"
        result += '整'
      else
        result.gsub!('零角', '整')
      end
    end

    result.gsub!('零分', '')
    "#{n < 0 ? "负" : ""}#{result}"
  end
end
