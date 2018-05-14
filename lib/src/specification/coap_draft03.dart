/*
 * Package : Coap
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 14/05/2018
 * Copyright :  S.Hamblett
 */

part of coap;

/// draft-ietf-core-coap-03
class CoapDraft03 implements CoapISpec {
  static const int version = 1;
  static const int versionBits = 2;
  static const int typeBits = 2;
  static const int optionCountBits = 4;
  static const int codeBits = 8;
  static const int idBits = 16;
  static const int optionDeltaBits = 4;
  static const int optionLengthBaseBits = 4;
  static const int optionLengthExtendedBits = 8;
  static const int maxOptionDelta = (1 << optionDeltaBits) - 1;
  static const int maxOptionLengthBase = (1 << optionLengthBaseBits) - 2;
  static const int fencepostDivisor = 14;

  static CoapILogger _log = new CoapLogManager("console").logger;

  String get name => "draft-ietf-core-coap-03";

  int get defaultPort => 61616;

  CoapIMessageEncoder newMessageEncoder() {
    return new messageEncoder03();
  }

  static int getOptionNumber(int optionType) {
    switch (optionType) {
      case optionTypeReserved:
        return 0;
      case optionTypeContentType:
        return 1;
      case optionTypeMaxAge:
        return 2;
      case optionTypeProxyUri:
        return 3;
      case optionTypeETag:
        return 4;
      case optionTypeUriHost:
        return 5;
      case optionTypeLocationPath:
        return 6;
      case optionTypeUriPort:
        return 7;
      case optionTypeLocationQuery:
        return 8;
      case optionTypeUriPath:
        return 9;
      case optionTypeToken:
        return 11;
      case optionTypeUriQuery:
        return 15;
      case optionTypeObserve:
        return 10;
      case optionTypeFencepostDivisor:
        return 14;
      case optionTypeBlock2:
        return 13;
      default:
        return optionType;
    }
  }

  static int nextFencepost(int optionNumber) {
    return ((optionNumber / fencepostDivisor + 1) * fencepostDivisor).toInt();
  }

  static int mapOutMediaType(int mediaType) {
    switch (mediaType) {
      case CoapMediaType.applicationXObixBinary:
        return 48;
      case CoapMediaType.applicationFastinfoset:
        return 49;
      case CoapMediaType.applicationSoapFastinfoset:
        return 50;
      case CoapMediaType.applicationJson:
        return 51;
      default:
        return mediaType;
    }
  }

  static int mapOutCode(int code) {
    switch (code) {
      case CoapCode.content:
        return 80;
      default:
        return (code >> 5) * 40 + (code & 0xf);
    }
  }
}