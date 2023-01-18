import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_test/core/utils/debouncer.dart';
import 'package:stock_market_test/core/utils/project_sizes.dart';
import 'package:stock_market_test/models/company_overview_ui/company_overview_ui.dart';
import 'package:stock_market_test/ui/pages/detailed_page.dart';
import 'package:stock_market_test/ui/widgets/companies_pie_chart_header.dart';
import 'package:stock_market_test/ui/widgets/company_list_item_widget.dart';

class CompaniesLoadedWidget extends StatefulWidget {
  const CompaniesLoadedWidget({
    super.key,
    required this.companiesOverviewUi,
    required this.totalMarketCap,
  });

  final List<CompanyOverviewUi> companiesOverviewUi;
  final double totalMarketCap;

  @override
  State<CompaniesLoadedWidget> createState() => _CompaniesLoadedWidgetState();
}

class _CompaniesLoadedWidgetState extends State<CompaniesLoadedWidget> {
  final Debouncer tapDebouncer = Debouncer(milliseconds: 50);

  void onPieChartTap(PieTouchResponse? mouseCursorResolver) {
    tapDebouncer.run(() {
      if ((mouseCursorResolver?.touchedSection?.touchedSectionIndex ?? -1) >
              -1 &&
          mouseCursorResolver is PieTouchResponse) {
        navigateToDetailedPage(
          widget.companiesOverviewUi[
              mouseCursorResolver.touchedSection?.touchedSectionIndex ?? 0],
        );
      }
    });
  }

  void navigateToDetailedPage(CompanyOverviewUi companyOverviewUi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedPage(
          companyOverviewUi: companyOverviewUi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: CompaniesPieChartWidget(
            companiesOverviewUi: widget.companiesOverviewUi,
            onPieChartSectionTap: onPieChartTap,
            totalMarketCap: widget.totalMarketCap,
          ),
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height / 2,
          collapsedHeight: MediaQuery.of(context).size.height / 6,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            projectPrimaryPadding,
            projectPrimaryPadding * 2,
            projectPrimaryPadding,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Список компаний',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            projectPrimaryPadding,
            projectPrimaryPadding,
            projectPrimaryPadding,
            projectPrimaryPadding * 10,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CompanyListItemWidget(
                  onCompanyTap: () {
                    navigateToDetailedPage(widget.companiesOverviewUi[index]);
                  },
                  companyOverviewUi: widget.companiesOverviewUi[index],
                );
              },
              childCount: widget.companiesOverviewUi.length,
            ),
          ),
        )
      ],
    );
  }
}
