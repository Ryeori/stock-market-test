import 'package:flutter/material.dart';

class CompanyDetailedListItem extends StatelessWidget {
  const CompanyDetailedListItem({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title\n\n',
            style: Theme.of(context).textTheme.headline5,
          ),
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
