import 'package:expense_tracker_lite/src/core/error/exceptions.dart';
import 'package:expense_tracker_lite/src/core/service/network_service.dart';
import 'package:injectable/injectable.dart';

abstract class ExchangeRemoteDataSource {
  Future<double> getExchangeRate(String fromCurrency);
}

@Injectable(as: ExchangeRemoteDataSource)
class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final NetworkService networkService;

  ExchangeRemoteDataSourceImpl(this.networkService);

  @override
  Future<double> getExchangeRate(String fromCurrency) async {
    final onlyCurrency = fromCurrency.split(" - ").first;
    try {
      final response = await networkService.get(
        path: "v6/latest/USD",
      );

      if (response.data != null && response.data['rates'] != null) {
        final rates = response.data['rates'] as Map<String, dynamic>;

        if (onlyCurrency == 'USD') return 1.0;
        final rateToUsd = rates[onlyCurrency];

        if (rateToUsd != null) {
          return 1.0 / (rateToUsd).toDouble();
        } else {
          throw ServerException(error: 'Currency not found');
        }
      } else {
        throw ServerException(error: 'Invalid response format');
      }
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
