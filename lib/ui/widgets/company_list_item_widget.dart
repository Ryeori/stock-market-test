import 'package:flutter/material.dart';
import 'package:stock_market_test/core/utils/money_formatter_extension.dart';
import 'package:stock_market_test/core/utils/project_sizes.dart';
import 'package:stock_market_test/models/company_overview_ui/company_overview_ui.dart';
import 'package:stock_market_test/ui/widgets/market_cap_text_widget.dart';

class CompanyListItemWidget extends StatelessWidget {
  const CompanyListItemWidget({
    super.key,
    required this.companyOverviewUi,
    required this.onCompanyTap,
  });

  final CompanyOverviewUi companyOverviewUi;
  final VoidCallback onCompanyTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: companyOverviewUi.textColor);
    final marketCapitalization =
        (companyOverviewUi.companyOverview.marketCapitalization ?? 0).round();
    return GestureDetector(
      onTap: onCompanyTap,
      child: Container(
        decoration: BoxDecoration(
          color: companyOverviewUi.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: projectPrimaryPadding / 2),
        padding: const EdgeInsets.all(projectPrimaryPadding * 2),
        child: Row(
          children: [
            Text(
              companyOverviewUi.companyOverview.symbol,
              style: textStyle,
            ),
            const VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyOverviewUi.companyOverview.name,
                  style: textStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: projectPrimaryPadding),
                MarketCapTextWidget(
                  formattedMarketCap: marketCapitalization.formatMoney(),
                  currency: companyOverviewUi.companyOverview.currency,
                  textStyle: textStyle,
                ),
                const SizedBox(height: projectPrimaryPadding),
                Text(
                  companyOverviewUi.companyOverview.country,
                  style: textStyle,
                ),
              ],
            ),
            const Spacer(),
            Text(
              '${companyOverviewUi.marketCapPercentage} %',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
