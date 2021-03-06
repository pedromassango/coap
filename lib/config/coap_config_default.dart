// GENERATED CODE, do not edit this file.

import 'package:coap/coap.dart';

/// Configuration loading class. The config file itself is a YAML
/// file. The configuration items below are marked as optional to allow
/// the config file to contain only those entries that override the defaults.
/// The file can't be empty, so version must as a minimum be present.
class CoapConfigDefault extends DefaultCoapConfig {
  CoapConfigDefault() {
    DefaultCoapConfig.inst = this;
  }

  @override
  CoapISpec spec;

  @override
  String get version => 'RFC7252';

  @override
  String get deduplicator => 'MarkAndSweep';
}
