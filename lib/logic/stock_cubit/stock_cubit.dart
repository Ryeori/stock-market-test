import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:stock_market_test/api/stock_api/stock_api.dart';
import 'package:stock_market_test/models/company_overview/company_overview.dart';

part 'stock_cubit.freezed.dart';
part 'stock_state.dart';

@lazySingleton
class StockCubit extends Cubit<StockState> {
  StockCubit(this._stockApi) : super(const StockState.initial());

  final StockApi _stockApi;

  Future<void> fetchCompaniesOverview({
    ///for ex [ 'IBM' ]
    required List<String> companySymbols,
  }) async {
    if (state != const StockState.loading()) {
      try {
        emit(const StockState.loading());
        final companiesOverviewResponse = await _stockApi
            .fetchCompaniesOverview(companySymbols: companySymbols);
        emit(
          StockState.loaded(
            // Response дублируется, так как api позволяет делать не более 5 запросов в минуту
            // И в нем нет получения всех интересущих компаний, приходится каждую по отдельности
            companiesOverview: [
              ...companiesOverviewResponse,
              // ...companiesOverviewResponse,
            ],
          ),
        );
      } catch (e) {
        emit(StockState.error(errorMessage: e.toString()));
      }
    }
  }
}
