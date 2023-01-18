part of 'stock_cubit.dart';

@freezed
class StockState with _$StockState {
  const factory StockState.initial() = _Initial;
  const factory StockState.loaded({
    required List<CompanyOverview> companiesOverview,
  }) = _Loaded;
  const factory StockState.loading() = _Loading;
  const factory StockState.error({required String errorMessage}) = _Error;
}
