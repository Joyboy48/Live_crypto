import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade500,

        )
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

}



// Widget CryptoWidget(){
//   return Container(
//     child: Column(
//       children: [
//         Flexible(
//             child: ListView.builder(itemBuilder: (context, index) {
//               Map<dynamic, dynamic> currency = currencies?[index];
//               MaterialColor? color = colors?[index % colors!.length];
//
//               return getListItemUi(currency, color);
//             },itemCount: currencies?.length,)
//
//         ),
//       ],
//     ),
//   );
// }
