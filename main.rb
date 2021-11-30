Encoding::ASCII_8BIT.replicate("IROHA")

class String
  prepend Module.new {
    def encode(encoding, from_encoding = __ENCODING__, options = nil)

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
#         raise ArgumentError
      end
    end

    # options 非対応
    def to_iroha(encoding, from_encoding)
      #     raise Encoding::ConverterNotFoundError unless unicode.include?(from_encoding)

      self.each_grapheme_cluster.map { |char|
        utf8_to_iroha(char)
      }.join.force_encoding(encoding)
    end

    # options 非対応
    def from_iroha(encoding, from_encoding)
      #     raise Encoding::ConverterNotFoundError unless unicode.include?(encoding)

      self.each_byte.map { |char|
        iroha_to_utf8(char)
      }.join.force_encoding(encoding)
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
      case char
      when "\x80"
        "い"
      when "\x81"
        "ろ"
      when "\x82"
        "は"
      when "\x83"
        "に"
      when "\x84"
        "ほ"
      when "\x85"
        "へ"
      when "\x86"
        "と"
      when "\x87"
        "ち"
      when "\x88"
        "り"
      when "\x89"
        "ぬ"
      when "\x8A"
        "る"
      when "\x8B"
        "を"
      when "\x8C"
        "わ"
      when "\x8D"
        "か"
      when "\x8E"
        "よ"
      when "\x8F"
        "た"
      when "\x90"
        "れ"
      when "\x91"
        "そ"
      when "\x92"
        "つ"
      when "\x93"
        "ね"
      when "\x94"
        "な"
      when "\x95"
        "ら"
      when "\x96"
        "む"
      when "\x97"
        "う"
      when "\x98"
        "ゐ"
      when "\x99"
        "の"
      when "\x9A"
        "お"
      when "\x9B"
        "く"
      when "\x9C"
        "や"
      when "\x9D"
        "ま"
      when "\x9E"
        "け"
      when "\x9F"
        "ふ"
      when "\xA0"
        "こ"
      when "\xA1"
        "え"
      when "\xA2"
        "て"
      when "\xA3"
        "あ"
      when "\xA4"
        "さ"
      when "\xA5"
        "き"
      when "\xA6"
        "ゆ"
      when "\xA7"
        "め"
      when "\xA8"
        "み"
      when "\xA9"
        "し"
      when "\xAA"
        "え"
      when "\xAB"
        "ひ"
      when "\xAC"
        "も"
      when "\xAD"
        "せ"
      when "\xAE"
        "す"
      else
        if char # FIXME
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
i = 'い'.encode(Encoding::IROHA)
pp i
pp i.encode(Encoding::UTF_8, Encoding::IROHA)
