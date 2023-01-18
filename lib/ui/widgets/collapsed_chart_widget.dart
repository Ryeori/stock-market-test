import 'package:flutter/material.dart';
import 'package:stock_market_test/models/company_overview_ui/company_overview_ui.dart';

class CollapsedChartWidget extends StatelessWidget {
  const CollapsedChartWidget({
    super.key,
    required this.companiesOverviewUi,
  });

  final List<CompanyOverviewUi> companiesOverviewUi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: companiesOverviewUi.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              //Список вмещает до 4 компаний, если их больше, то скролится
              return SizedBox(
                width: companiesOverviewUi.length > 4
                    ? MediaQuery.of(context).size.width / 4.5
                    : MediaQuery.of(context).size.width /
                        companiesOverviewUi.length,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      companiesOverviewUi[index].companyOverview.symbol,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${companiesOverviewUi[index].marketCapPercentage}%',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Text(
          'Можно скролить горизонтально',
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText2?.color?.withOpacity(0.33),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
