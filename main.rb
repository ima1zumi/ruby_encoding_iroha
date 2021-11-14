Encoding::ASCII_8BIT.replicate("IROHA")

class String
  def encode(encoding, from_encoding = __ENCODING__, options = nil)

    # TODO: from も
    if encoding.class.name == 'String'
      to_enc = Encoding.find(encoding)
    elsif encoding.class.name == 'Encoding'
      to_enc = encoding
    else
      raise ArgumentError
    end

    raise Encoding::ConverterNotFoundError unless unicode.include?(from_encoding)

    if to_enc == Encoding::IROHA
      return to_iroha(to_enc, from_encoding)
    elsif unicode.include?(to_enc) && from_encoding == Encoding::IROHA
      return from_iroha(to_enc, from_encoding)
    end

    super
  end

  private

  # options 非対応
  def to_iroha(encoding, from_encoding)
    self.each_grapheme_cluster.map { |char|
      unicode_to_iroha(char)
    }.join.force_encoding(Encoding::IROHA)
  end

  def unicode
    [
      Encoding::UTF_16,
      Encoding::UTF_16BE,
      Encoding::UTF_16LE,
      Encoding::UTF_32,
      Encoding::UTF_32BE,
      Encoding::UTF_32LE,
      Encoding::UTF_7,
      Encoding::UTF_8,
      Encoding::UTF8_DOCOMO,
      Encoding::UTF8_KDDI,
      Encoding::UTF8_MAC,
      Encoding::UTF8_SOFTBANK,
    ]
  end

  def unicode_to_iroha(char)
    case char
    when "い"
      "\x80"
    when "ろ"
      "\x81"
    when "は"
      "\x82"
    when "に"
      "\x83"
    when "ほ"
      "\x84"
    when "へ"
      "\x85"
    when "と"
      "\x86"
    when "ち"
      "\x87"
    when "り"
      "\x88"
    when "ぬ"
      "\x89"
    when "る"
      "\x8A"
    when "を"
      "\x8B"
    when "わ"
      "\x8C"
    when "か"
      "\x8D"
    when "よ"
      "\x8E"
    when "た"
      "\x8F"
    when "れ"
      "\x90"
    when "そ"
      "\x91"
    when "つ"
      "\x92"
    when "ね"
      "\x93"
    when "な"
      "\x94"
    when "ら"
      "\x95"
    when "む"
      "\x96"
    when "う"
      "\x97"
    when "ゐ"
      "\x98"
    when "の"
      "\x99"
    when "お"
      "\x9A"
    when "く"
      "\x9B"
    when "や"
      "\x9C"
    when "ま"
      "\x9D"
    when "け"
      "\x9E"
    when "ふ"
      "\x9F"
    when "こ"
      "\xA0"
    when "え"
      "\xA1"
    when "て"
      "\xA2"
    when "あ"
      "\xA3"
    when "さ"
      "\xA4"
    when "き"
      "\xA5"
    when "ゆ"
      "\xA6"
    when "め"
      "\xA7"
    when "み"
      "\xA8"
    when "し"
      "\xA9"
    when "え"
      "\xAA"
    when "ひ"
      "\xAB"
    when "も"
      "\xAC"
    when "せ"
      "\xAD"
    when "す"
      "\xAE"
    else
      if char.ascii_only?
        char
      else
        raise Encoding::UndefinedConversionError
      end
    end
  end
end

str = 'い'.encode(Encoding::IROHA)
pp str
pp str.encoding
pp 'a'.encode(Encoding::IROHA)
pp 'a'.encode('IROHA')
# pp 'ば'.encode(Encoding::IROHA)
