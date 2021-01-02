import 'dart:async';

import 'package:flutter/material.dart';
class CardLimit extends StatefulWidget {
  @override
  _CardLimitState createState() => _CardLimitState();
}

class _CardLimitState extends State<CardLimit> {
  double amount;
  double rate;
  double interest;
  bool showResult = false;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Form(
                child: Column(
                  children: <Widget>[
                    amountCustomFields('Balance','Credit Amount'),
                    rateCustomFields('Rate (%)','Interest Rate'),
                    SizedBox(height: 10.0,),
                    Container(child: RaisedButton(
                      onPressed: ()=> showData(),
                      child: Text('Show'),
                    ),)
                  ],
                ),
              ),
            SizedBox(height: 20.0,),
            showResult ?
                  interest != null
                      ? Container(
                          child: Center(
                            child: Text('Credit Interest Limit : ' + '\$'+interest.toString()),
                          ),
                        )
                  : Container()
                : Container(),
            ],
          ),
        ),
      ),
    );
  }
  Widget errorDialog( ){
    return Container(
      child: Text('eint'),
    );
  }
  showData()async{
        double result = amount *(rate/100);
        setState(() {
          interest = result;
          showResult = true;
        });
  }
  Widget amountCustomFields(String title, String hintText){
    return Container(
      child:  Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5.0),
            child: Text(title),),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (v){
                  setState(() {
                    amount = double.parse(v);
                  });
                },
                decoration: InputDecoration(

                  hintText: hintText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget rateCustomFields(String title, String hintText){
    return Container(
      child:  Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5.0),
            child: Text(title),),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (v){
                  setState(() {
                    rate = double.parse(v);
                  });
                },
                decoration: InputDecoration(
                  hintText: hintText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
