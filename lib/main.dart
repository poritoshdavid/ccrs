import 'package:ccrs/CardLimit.dart';
import 'package:ccrs/loanCalculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CCRS',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MainActivity(),
    );
  }
}

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: Text('CCRS'),
        centerTitle: true,
      ),
      body: PaymentGenerators(),
    );
  }
}

// taxInterest = (interest / 100) * (1 + bsmv + kkdf);
//  taxInterest = (((interest / 100) / 12) % 10);
// temp1 = taxInterest * pow((1 + taxInterest), length);
// temp1 = taxInterest;
// temp2 = (1 - pow((1 + taxInterest), -length));
// installment = creditAmount * temp1 / temp2;
