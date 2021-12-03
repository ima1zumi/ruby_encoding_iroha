Encoding::ASCII_8BIT.replicate("IROHA")

class String
  prepend Module.new {
    UNICODE =
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

    def encode(encoding, from_encoding = __ENCODING__, **options)

      to_enc = convert_encoding_constant(encoding)
      from_enc = convert_encoding_constant(from_encoding)

      if to_enc == Encoding::IROHA
        return to_iroha(to_enc, from_enc)
      elsif from_encoding == Encoding::IROHA
        return from_iroha(to_enc, from_enc)
      end

      super
    end

    private

    def convert_encoding_constant(encoding)
      if encoding.is_a?(String)
        Encoding.find(encoding)
      elsif encoding.is_a?(Encoding)
        encoding
      else
        raise ArgumentError
      end
    end

    def to_iroha(encoding, from_encoding)
      raise Encoding::ConverterNotFoundError unless UNICODE.include?(from_encoding)

      self.each_grapheme_cluster.map { |char| utf8_to_iroha(char.encode(Encoding::UTF_8)) }.join.force_encoding(encoding)
    end

    def from_iroha(encoding, from_encoding)
      raise Encoding::ConverterNotFoundError unless UNICODE.include?(encoding)

      self.each_char.map { |char| iroha_to_utf8(char) }.join.encode(encoding)
    end

    def utf8_to_iroha(char)
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

    def iroha_to_utf8(char)
      case char.b
      when "\x80".b
        "い"
      when "\x81".b
        "ろ"
      when "\x82".b
        "は"
      when "\x83".b
        "に"
      when "\x84".b
        "ほ"
      when "\x85".b
        "へ"
      when "\x86".b
        "と"
      when "\x87".b
        "ち"
      when "\x88".b
        "り"
      when "\x89".b
        "ぬ"
      when "\x8A".b
        "る"
      when "\x8B".b
        "を"
      when "\x8C".b
        "わ"
      when "\x8D".b
        "か"
      when "\x8E".b
        "よ"
      when "\x8F".b
        "た"
      when "\x90".b
        "れ"
      when "\x91".b
        "そ"
      when "\x92".b
        "つ"
      when "\x93".b
        "ね"
      when "\x94".b
        "な"
      when "\x95".b
        "ら"
      when "\x96".b
        "む"
      when "\x97".b
        "う"
      when "\x98".b
        "ゐ"
      when "\x99".b
        "の"
      when "\x9A".b
        "お"
      when "\x9B".b
        "く"
      when "\x9C".b
        "や"
      when "\x9D".b
        "ま"
      when "\x9E".b
        "け"
      when "\x9F".b
        "ふ"
      when "\xA0".b
        "こ"
      when "\xA1".b
        "え"
      when "\xA2".b
        "て"
      when "\xA3".b
        "あ"
      when "\xA4".b
        "さ"
      when "\xA5".b
        "き"
      when "\xA6".b
        "ゆ"
      when "\xA7".b
        "め"
      when "\xA8".b
        "み"
      when "\xA9".b
        "し"
      when "\xAA".b
        "え"
      when "\xAB".b
        "ひ"
      when "\xAC".b
        "も"
      when "\xAD".b
        "せ"
      when "\xAE".b
        "す"
      else
        if char.ascii_only?
          char
        else
          raise Encoding::UndefinedConversionError
        end
      end
    end
  }
end

str = 'い'.encode(Encoding::IROHA)
pp str
pp str.encoding
pp 'a'.encode(Encoding::IROHA)
pp 'a'.encode('IROHA')
# pp 'ば'.encode(Encoding::IROHA) #error
i = 'aい'.encode(Encoding::IROHA)
pp i.encode(Encoding::UTF_8, Encoding::IROHA)
pp 'a'.encode(Encoding::US_ASCII)
