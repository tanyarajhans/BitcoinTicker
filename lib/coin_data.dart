import 'package:http/http.dart' as http;
import 'dart:convert';

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

  
  String initialURL = 'https://rest.coinapi.io/v1/exchangerate';
  String apiKey = '4F12F8DC-6E16-4407-8582-0CB142D289E9';

  Future getCoinData(String selectedCurrency) async{
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String url = '$initialURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      }
      else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    } 
    return cryptoPrices;
  } 
  
}
