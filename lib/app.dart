import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_test/core/injections/injections.dart';
import 'package:stock_market_test/logic/stock_cubit/stock_cubit.dart';
import 'package:stock_market_test/ui/pages/overview_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StockCubit>(),
      child: const OverviewPage(),
    );
  }
}
