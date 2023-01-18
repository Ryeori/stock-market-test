import 'package:flutter/foundation.dart';

enum StockApiFunction { overview }

extension StockApiExtensions on Enum {
  MapEntry<String, dynamic> toMapEntry() {
    return MapEntry('function', describeEnum(this).toUpperCase());
  }
}
