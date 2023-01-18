import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_test/core/injections/injections.dart';
import 'package:stock_market_test/logic/stock_cubit/stock_cubit.dart';
import 'package:stock_market_test/models/company_overview_ui/company_overview_ui.dart';
import 'package:stock_market_test/ui/widgets/companies_loaded_widget.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool isLoading = false;
  List<String> selectedCompanies = ['IBM', 'AAPL', 'AMZN', 'GOOG', 'META'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<StockCubit, StockState>(
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (companiesOverview) {
                if (companiesOverview.isNotEmpty) {
                  final double totalMarketCap = companiesOverview.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + (element.marketCapitalization ?? 0),
                  );

                  return CompaniesLoadedWidget(
                    totalMarketCap: totalMarketCap,
                    companiesOverviewUi: List.generate(
                      companiesOverview.length,
                      (index) {
                        final backgroundColor =
                            Color((Random().nextDouble() * 0xFFFFFF).toInt())
                                .withOpacity(1);

                        return CompanyOverviewUi(
                          backgroundColor: backgroundColor,
                          companyOverview: companiesOverview[index],
                          marketCapPercentage:
                              ((companiesOverview[index].marketCapitalization ??
                                          0) *
                                      100 /
                                      totalMarketCap)
                                  .toStringAsFixed(2),
                          textColor: backgroundColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        );
                      },
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Компании не были получены\nПроверьте подключние к интеренету и свой api key\n(читать READEME.MD)',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          getIt<StockCubit>().fetchCompaniesOverview(
                            companySymbols: selectedCompanies,
                          );
                        },
                        child: const Text('Повторить загрузку'),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              initial: () {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          getIt<StockCubit>().fetchCompaniesOverview(
                            companySymbols: selectedCompanies,
                          );
                        },
                        child: const Text('Загрузить данные по компаниям'),
                      ),
                      Text(selectedCompanies.map((e) => '$e  ').join()),
                    ],
                  ),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
