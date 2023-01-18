import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_test/core/utils/money_formatter_extension.dart';
import 'package:stock_market_test/core/utils/project_sizes.dart';
import 'package:stock_market_test/models/company_overview_ui/company_overview_ui.dart';
import 'package:stock_market_test/ui/widgets/collapsed_chart_widget.dart';
import 'package:stock_market_test/ui/widgets/market_cap_text_widget.dart';

class CompaniesPieChartWidget extends StatefulWidget {
  const CompaniesPieChartWidget({
    super.key,
    required this.companiesOverviewUi,
    required this.onPieChartSectionTap,
    required this.totalMarketCap,
  });

  final List<CompanyOverviewUi> companiesOverviewUi;
  final void Function(PieTouchResponse? mouseCursorResolver)
      onPieChartSectionTap;
  final double totalMarketCap;

  @override
  State<CompaniesPieChartWidget> createState() =>
      _CompaniesPieChartWidgetState();
}

class _CompaniesPieChartWidgetState extends State<CompaniesPieChartWidget> {
  late final PieChartData pieChartData;
  double appBarMaxHeight = 0;

  @override
  void didChangeDependencies() {
    final pieChartSections = List.generate(
      widget.companiesOverviewUi.length,
      (index) {
        final companyOverviewUi = widget.companiesOverviewUi[index];
        final titlePercentage = '${companyOverviewUi.marketCapPercentage}%';

        return PieChartSectionData(
          radius: MediaQuery.of(context).size.width / 5,
          color: companyOverviewUi.backgroundColor,
          titleStyle:
              TextStyle(color: companyOverviewUi.textColor, fontSize: 17),
          value: companyOverviewUi.companyOverview.marketCapitalization,
          title: titlePercentage,
        );
      },
    );
    pieChartData = PieChartData(
      pieTouchData: PieTouchData(
        touchCallback: (touchCallback, mouseCursorResolver) {
          widget.onPieChartSectionTap(mouseCursorResolver);
        },
      ),
      sections: pieChartSections,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        appBarMaxHeight =
            appBarMaxHeight == 0 ? constraints.maxHeight : appBarMaxHeight;
        final appBarPercentageHeight =
            (constraints.biggest.height / appBarMaxHeight - 1).abs();
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          centerTitle: true,
          title: IgnorePointer(
            ignoring: appBarPercentageHeight < 0.5,
            child: Opacity(
              opacity: appBarPercentageHeight,
              child: CollapsedChartWidget(
                companiesOverviewUi: widget.companiesOverviewUi,
              ),
            ),
          ),
          background: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: projectPrimaryPadding,
              ),
              child: Stack(
                children: [
                  PieChart(pieChartData),
                  Center(
                    child: MarketCapTextWidget(
                      currency: widget
                          .companiesOverviewUi.first.companyOverview.currency,
                      formattedMarketCap: widget.totalMarketCap.formatMoney(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
