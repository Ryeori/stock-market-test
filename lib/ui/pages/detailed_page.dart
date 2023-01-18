import 'package:flutter/material.dart';
import 'package:stock_market_test/core/utils/project_sizes.dart';
import 'package:stock_market_test/models/company_overview_ui/company_overview_ui.dart';
import 'package:stock_market_test/ui/widgets/company_detailed_list_item.dart';

class DetailedPage extends StatelessWidget {
  const DetailedPage({
    super.key,
    required this.companyOverviewUi,
  });

  final CompanyOverviewUi companyOverviewUi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.keyboard_arrow_left),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: projectPrimaryPadding),
        child: ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + projectPrimaryPadding,
          ),
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: companyOverviewUi.companyOverview.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: companyOverviewUi.backgroundColor),
                  ),
                  TextSpan(
                    text: '  ${companyOverviewUi.companyOverview.symbol}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: companyOverviewUi.backgroundColor),
                  ),
                ],
              ),
            ),
            const Divider(),
            CompanyDetailedListItem(
              title: 'Описание',
              text: companyOverviewUi.companyOverview.description,
            ),
            const Divider(),
            CompanyDetailedListItem(
              title: 'Адрес',
              text: companyOverviewUi.companyOverview.address,
            ),
            const Divider(),
            CompanyDetailedListItem(
              title: 'Индустрия',
              text: companyOverviewUi.companyOverview.industry,
            ),
            const Divider(),
            CompanyDetailedListItem(
              title: 'Сектор',
              text: companyOverviewUi.companyOverview.sector,
            ),
            const Divider(),
            CompanyDetailedListItem(
              title: 'Тип активов',
              text: companyOverviewUi.companyOverview.assetType,
            ),
          ],
        ),
      ),
    );
  }
}
