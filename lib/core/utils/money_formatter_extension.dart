import 'package:intl/intl.dart';

extension MoneyFormatterExtension on num {
  String formatMoney() {
    return NumberFormat.compact().format(this);
  }
}
