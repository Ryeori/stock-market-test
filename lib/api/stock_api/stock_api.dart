import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_market_test/api/stock_api/stock_api_constant.dart';
import 'package:stock_market_test/api/stock_api/stock_api_function.dart';
import 'package:stock_market_test/models/company_overview/company_overview.dart';

@Singleton()
class StockApi {
  StockApi(this.dio) {
    _initStockApi();
  }

  final Dio dio;

  void _initStockApi() {
    dio.options.baseUrl = stockApiHost;
    dio.options.connectTimeout = stockApiRequstTimeoutMs;
    dio.options.queryParameters = {'apikey': stockApiKey};
  }

  Future<List<CompanyOverview>> fetchCompaniesOverview({
    ///for ex IBM
    required List<String> companySymbols,
  }) async {
    final List<CompanyOverview> companiesOverview = [];
    final Map<String, dynamic> queryParameters =
        Map.fromEntries([StockApiFunction.overview.toMapEntry()]);

    if (companySymbols.isEmpty) {
      print('Please provide at least one company symbol, ex. - IBM');
    } else {
      for (var i = 0; i < companySymbols.length; i++) {
        if (companySymbols[i].isNotEmpty) {
          try {
            await dio
                .get(
              '/query',
              queryParameters: Map.from(queryParameters)
                ..addEntries([MapEntry('symbol', companySymbols[i])]),
            )
                .then((companyOverviewResponse) {
              companiesOverview.add(
                CompanyOverview.fromJson(
                  companyOverviewResponse.data as Map<String, dynamic>,
                ),
              );
            });
          } catch (e) {
            //TODO: ADD ERROR HANDLER
            print(e);
          }
        }
      }
    }
    return companiesOverview;
  }
}

@module
abstract class RegisterStockApiModule {
  Dio dio() => Dio();
}
