import 'package:flutter/material.dart';

class MarketCapTextWidget extends StatelessWidget {
  const MarketCapTextWidget({
    super.key,
    required this.formattedMarketCap,
    this.textStyle,
    this.currency = '',
  });
  final String formattedMarketCap;
  final String currency;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$currency ',
            style: textStyle,
          ),
          TextSpan(
            text: formattedMarketCap,
            style: textStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
