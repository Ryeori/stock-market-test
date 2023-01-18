import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:stock_market_test/models/company_overview/utils.dart';

part 'company_overview.freezed.dart';
part 'company_overview.g.dart';

@freezed
class CompanyOverview with _$CompanyOverview {
  const factory CompanyOverview({
    @JsonKey(name: 'Symbol') required String symbol,
    @JsonKey(name: 'AssetType') required String assetType,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Description') required String description,
    @JsonKey(name: 'CIK', fromJson: StringToIntConverter.fromJson, toJson: StringToIntConverter.toJson)
        required int? cik,
    @JsonKey(name: 'Exchange') required String exchange,
    @JsonKey(name: 'Currency') required String currency,
    @JsonKey(name: 'Country') required String country,
    @JsonKey(name: 'Sector') required String sector,
    @JsonKey(name: 'Industry') required String industry,
    @JsonKey(name: 'Address') required String address,
    @JsonKey(name: 'FiscalYearEnd') required String fiscalYearEnd,
    @JsonKey(name: 'LatestQuarter') required DateTime latestQuarter,
    @JsonKey(name: 'MarketCapitalization', fromJson: StringToDobuleConverter.fromJson, toJson: StringToDobuleConverter.toJson)
        required double? marketCapitalization,
    @JsonKey(name: 'ProfitMargin', fromJson: StringToDobuleConverter.fromJson, toJson: StringToDobuleConverter.toJson)
        required double? profitMargin,
  }) = _CompanyOverview;

  factory CompanyOverview.fromJson(Map<String, dynamic> json) =>
      _$CompanyOverviewFromJson(json);
}
