import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_market_test/models/company_overview/company_overview.dart';

part 'company_overview_ui.freezed.dart';

@freezed

///DTO for ui
class CompanyOverviewUi with _$CompanyOverviewUi {
  const factory CompanyOverviewUi({
    required CompanyOverview companyOverview,
    required Color backgroundColor,
    required Color textColor,
    required String marketCapPercentage,
  }) = _CompanyOverviewUi;
}
