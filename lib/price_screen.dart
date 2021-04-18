import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'USD';
  String currencyRate = '?';
  String currencyRateBTC = '?';
  String currencyRateETH = '?';
  String currencyRateLTC = '?';
  String currencyBaseBTC = 'BTC';
  String currencyBaseETH = 'ETH';
  String currencyBaseLTC = 'LTC';

  CoinData coinData = CoinData();

  void getCoinDataBTC(String rate, String currency) {
    setState(() {
      currencyRateBTC = rate;
      currentCurrency = currency;
      print(currencyRateBTC + currentCurrency);
    });
  }

  void getCoinDataETH(String rate, String currency) {
    setState(() {
      currencyRateETH = rate;
      currentCurrency = currency;
      print(currencyRateETH + currentCurrency);
    });
  }

  void getCoinDataLTC(String rate, String currency) {
    setState(() {
      currencyRateLTC = rate;
      currentCurrency = currency;
      print(currencyRateLTC + currentCurrency);
    });
  }

  Widget getDropDownWidget() {
    List<DropdownMenuItem<String>> listItens = [];
    for (String currency in currenciesList) {
      listItens.add(
        new DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: currentCurrency,
      items: listItens,
      onChanged: (value) async {
        for (String currencyBase in cryptoList) {
          String currencyRateValue =
              await coinData.getCoinData(currencyBase, value);
          if (currencyBaseBTC == currencyBase) {
            getCoinDataBTC(currencyRateValue, value);
          }

          if (currencyBaseETH == currencyBase) {
            getCoinDataETH(currencyRateValue, value);
          }

          if (currencyBaseLTC == currencyBase) {
            getCoinDataLTC(currencyRateValue, value);
          }
        }
      },
    );
  }

  Widget getiOSPicker() {
    List<Text> listItens = [];
    for (String currency in currenciesList) {
      listItens.add(
        new Text(currency),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children: listItens,
      itemExtent: 32.0,
      onSelectedItemChanged: (indexItem) {
        print(indexItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $currencyBaseBTC = $currencyRateBTC $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $currencyBaseETH = $currencyRateETH $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $currencyBaseLTC = $currencyRateLTC $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getiOSPicker() : getDropDownWidget(),
          ),
        ],
      ),
    );
  }
}

// currenciesList.map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// child: Text(value),
// value: value,
// );
// }).toList()
