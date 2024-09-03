// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
//
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class  _HomePageState extends State<HomePage>{
//
//   List<dynamic>? currencies;
//
//   final List<MaterialColor> colors = [
//     Colors.indigo,
//     Colors.green,
//     Colors.yellow,
//     Colors.red,
//     Colors.blue,
//     Colors.orange,
//     Colors.brown,
//     Colors.pink,
//     Colors.teal,
//     Colors.deepPurple,
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCurrrencies();
//   }
//
//   void fetchCurrrencies()async {
//     currencies = await getCurrencies();
//     setState((){
//
//     });
//   }
//
//   Future<List<dynamic>> getCurrencies() async{
//     String cryptoUrl ="https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=9b32f690-ac67-4bf5-b5a8-cdd92f484f1b";
//     http.Response response = await http.get(Uri.parse(cryptoUrl));
//     return json.decode(response.body);
//
//   }
//
//
//   @override
//   Widget CryptoWidget(){
//     return Container(
//       child: currencies != null ? ListView.builder(
//         itemBuilder: (context, index) {
//           Map<dynamic, dynamic>? currency = currencies?[index];
//           if (currency != null) {
//             MaterialColor? color = colors[index % colors.length];
//             return getListItemUi(currency, color);
//           } else {
//             return SizedBox(); // Return an empty SizedBox if currency is null
//           }
//         },
//         itemCount: currencies?.length ?? 0,
//       ) : Center(
//         child: CircularProgressIndicator(), // Show a loading indicator while currencies are being fetched
//       ),
//     );
//   }
//
//
//   ListTile? getListItemUi(Map currency, MaterialColor? color){
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: color,
//         child: Text(currency['name'][0]) ,
//       ),
//       title:Text(currency['name']),
//       subtitle: getSubtitleText(currency['price'],currency['percent_change_1h'],currency['market_cap']) ,
//      isThreeLine: true,
//     );
//
//   }
//
//   Widget? getSubtitleText(String price,String percentagechange, String marketCap ){
//     TextSpan priceTextWidget = TextSpan(text:'\$$price\n' );
//     String percentageChangeText = '1 Hour: $percentagechange';
//     TextSpan percentageChangeTextWidget;
//
//     if(double.parse(percentagechange)>0){
//       percentageChangeTextWidget = TextSpan(text: percentageChangeText,style: TextStyle(color: Colors.green) );
//     }else{
//       percentageChangeTextWidget = TextSpan(text: percentageChangeText,style: TextStyle(color: Colors.red));
//     }
//     TextSpan marketCapWidget = TextSpan(text: '\$$marketCap');
//
//     return RichText(text: TextSpan(
//       children: [
//         priceTextWidget,
//         percentageChangeTextWidget,
//         marketCapWidget,
//       ]
//     ));
//
//
//
//   }
//
//
//
//   Widget build(BuildContext ){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LiveCryto',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
//         centerTitle: true,
//       ),
//       body: CryptoWidget(),
//     );
//   }
//
//
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? currencies;

  final List<MaterialColor> colors = [
    Colors.indigo,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.brown,
    Colors.pink,
    Colors.teal,
    Colors.deepPurple,
  ];

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    try {
      currencies = await getCurrencies();
    } catch (e) {
      print('Error fetching currencies: $e');
    }
    setState(() {});
  }

  Future<List<dynamic>> getCurrencies() async {
    String cryptoUrl =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=9b32f690-ac67-4bf5-b5a8-cdd92f484f1b";
    http.Response response = await http.get(Uri.parse(cryptoUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LiveCrypto',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: CryptoWidget(),
    );
  }

  Widget CryptoWidget() {
    return Container(
      child: currencies != null
          ? ListView.builder(
        itemBuilder: (context, index) {
          Map<dynamic, dynamic>? currency = currencies?[index];
          if (currency != null) {
            MaterialColor? color = colors[index % colors.length];
            return getListItemUi(currency, color);
          } else {
            return SizedBox(); 
          }
        },
        itemCount: currencies?.length ?? 0,
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  ListTile getListItemUi(Map currency, MaterialColor? color) {
    String currencySymbol = currency['symbol'];
    String currencyName = currency['name'];
    String price = currency['quote']['USD']['price'].toString();
    String percentageChange =
    currency['quote']['USD']['percent_change_1h'].toString();
    String marketCap =
    currency['quote']['USD']['market_cap'].toStringAsFixed(2);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          currencySymbol.length > 3
              ? currencySymbol.substring(0, 3)
              : currencySymbol, 
          style: TextStyle(fontSize: 16),
        ),
      ),
      title: Text(currencyName),
      subtitle: getSubtitleText(price, percentageChange, marketCap),
      isThreeLine: true,
    );
  }


  Widget getSubtitleText(String price, String percentageChange, String marketCap) {
    TextSpan priceTextWidget = TextSpan(text: '\$$price\n');
    String percentageChangeText = '1 Hour: $percentageChange%\n';
    TextSpan percentageChangeTextWidget;
    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget =
          TextSpan(text: percentageChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget =
          TextSpan(text: percentageChangeText, style: TextStyle(color: Colors.red));
    }
    TextSpan marketCapWidget = TextSpan(text: 'Market Cap: \$$marketCap\n');
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          priceTextWidget,
          percentageChangeTextWidget,
          marketCapWidget,
        ],
      ),
    );
  }
}
