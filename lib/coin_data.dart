import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '3C22AD44-96C7-4DF1-AC9D-896767BF1280';
const urlBase = 'https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getCoinData(String baseCoin, String quoteCoin) async {
    Uri url = Uri.parse('$urlBase$baseCoin/$quoteCoin?apiKey=$apiKey');
    var response = await http.get(url);
    String coinData = response.body;

    double currencyQuote = jsonDecode(coinData)['rate'];
    return currencyQuote.toStringAsFixed(5);
  }
}
