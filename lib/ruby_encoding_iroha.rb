# frozen_string_literal: true

require_relative "ruby_encoding_iroha/version"

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

    UTF8_TO_IROHA_TABLE = {
      "い" => "\x80",
      "ろ" => "\x81",
      "は" => "\x82",
      "に" => "\x83",
      "ほ" => "\x84",
      "へ" => "\x85",
      "と" => "\x86",
      "ち" => "\x87",
      "り" => "\x88",
      "ぬ" => "\x89",
      "る" => "\x8A",
      "を" => "\x8B",
      "わ" => "\x8C",
      "か" => "\x8D",
      "よ" => "\x8E",
      "た" => "\x8F",
      "れ" => "\x90",
      "そ" => "\x91",
      "つ" => "\x92",
      "ね" => "\x93",
      "な" => "\x94",
      "ら" => "\x95",
      "む" => "\x96",
      "う" => "\x97",
      "ゐ" => "\x98",
      "の" => "\x99",
      "お" => "\x9A",
      "く" => "\x9B",
      "や" => "\x9C",
      "ま" => "\x9D",
      "け" => "\x9E",
      "ふ" => "\x9F",
      "こ" => "\xA0",
      "え" => "\xA1",
      "て" => "\xA2",
      "あ" => "\xA3",
      "さ" => "\xA4",
      "き" => "\xA5",
      "ゆ" => "\xA6",
      "め" => "\xA7",
      "み" => "\xA8",
      "し" => "\xA9",
      "ゑ" => "\xAA",
      "ひ" => "\xAB",
      "も" => "\xAC",
      "せ" => "\xAD",
      "す" => "\xAE",
    }

    IROHA_TO_UTF8_TABLE = UTF8_TO_IROHA_TABLE.to_h { |utf8, iroha|
      [iroha.b, utf8]
    }

    def encode(encoding, from_encoding = self.encoding, **options)

      to_enc = convert_encoding_constant(encoding)
      from_enc = convert_encoding_constant(from_encoding)

      if to_enc == Encoding::IROHA
        return to_iroha(from_enc)
      elsif from_encoding == Encoding::IROHA
        return from_iroha(to_enc)
      end

      super
    end

    private

    def convert_encoding_constant(encoding)
      if encoding.is_a?(String) || encoding.is_a?(Encoding)
        Encoding.find(encoding)
      else
        raise ArgumentError
      end
    end

    def to_iroha(encoding)
      raise Encoding::ConverterNotFoundError unless UNICODE.include?(encoding)

      self.each_char.map { |char| utf8_to_iroha(char.encode(Encoding::UTF_8)) }.join.force_encoding(Encoding::IROHA)
    end

    def from_iroha(encoding)
      raise Encoding::ConverterNotFoundError unless UNICODE.include?(encoding)

      self.each_char.map { |char| iroha_to_utf8(char) }.join.encode(encoding)
    end

    def utf8_to_iroha(char)
      iroha = UTF8_TO_IROHA_TABLE[char]

      if iroha
        iroha
      else iroha.nil?
        if char.ascii_only?
          char
        else
          raise Encoding::UndefinedConversionError
        end
      end
    end

    def iroha_to_utf8(char)
      utf8 = IROHA_TO_UTF8_TABLE[char.b]

      if utf8
        utf8
      else utf8.nil?
        if char.ascii_only?
          char
        else
          raise Encoding::UndefinedConversionError
        end
      end
    end
  }
end
