import 'dart:math';
import 'package:ccrs/table_model.dart';
import 'package:flutter/material.dart';
import 'package:ccrs/table.dart';

class PaymentGenerators extends StatefulWidget {
  final String description;
  final Color backgroundColor;
  final Color tabBarLineColor;
  final Color selectedTabLabelColor;
  final Color unselectedTabLabelColor;
  final Color buttonColor;
  final Color selectedTabBorderColor;
  final Color unselectedTabBorderColor;
  final Color tablePageThemeColor;
  final Color tablePageLabelColor;

  const PaymentGenerators({
    Key key,
    this.description,
    this.backgroundColor,
    this.tabBarLineColor,
    this.selectedTabLabelColor,
    this.unselectedTabLabelColor,
    this.buttonColor,
    this.selectedTabBorderColor,
    this.unselectedTabBorderColor,
    this.tablePageThemeColor,
    this.tablePageLabelColor,
  }) : super(key: key);

  @override
  _PaymentGeneratorsState createState() => _PaymentGeneratorsState();
}

class _PaymentGeneratorsState extends State<PaymentGenerators>
    with SingleTickerProviderStateMixin {
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool isSelectedLeft = true;
  TabController _tabController;
  bool isVisible = false;
  double contSize = 300.0;
  double creditAmount;

  double creditCarAmounts;
  double creditCarTradeAmount;
  double creditCarAmount;
  double creditBalance;
  double creditPurchase;
  double interest;
  int creditTermM;
  int creditTermY;
  List<int> creditTermMonthly = [];
  List<int> creditTermYearly = [];

  CreditTableModel creditTableModel;
  List<CreditTableModel> creditModelList = [];
  double taxInterest;
  double temp1, temp2;
  double installment;
  double mainRemainingMoney;
  double creditRatio;
  double totalAmount;
  double anualPayment;
  double totalInterest;
  double creditLimitAmount;
  double creditLimitInterest;
  double result;

  String description =
      "This is a simulator to help calculate the accumulation of interest on your purchase as well as your balance, depending on the length of time it takes you to repay.";

  // todo: for Localization
  String descriptionTitle = "Car Offers";
  String tabFirstTitle = "Car";
  String tabSecondTitle = "Credit Card";
  String creditAmountInputLabelText = "Balance";
  String creditPriceInputLabelText = "Price of purchase";
  String creditCarAmountInputLabelText = "Price of the vehicle";
  String creditCarAmountTradeInputLabelText = "Trade-in/Down payment";
  String creditLimitAmountInputLabelText = "Credit Limit";
  String interestInputLabelText = "Interest";
  String termDropDownText = "Maturity";
  String monthText = " months";
  String settingsButtonText = "Advanced options";
  String bsmvText = "Bank insurance transaction tax";
  String kkdfText = "Resource Utilization Support Fund";
  String firstCalculatorButtonText = "Calculate Car Loan";
  String secondCalculatorButtonText = "Calculate";
  String validatorWarning = "Please fill in this field!";
  String validatorWarning2 = "Please enter usable value!";
  String timeOfRepaymentInMonths = "Time of repayment in months";

  Color selectedBorderColor;
  Color unSelectedBorderColor;
  @override
  void initState() {
    selectedBorderColor = widget.selectedTabBorderColor ?? Colors.blue;
    unSelectedBorderColor = widget.unselectedTabBorderColor ?? Colors.grey;

    if (widget.description != null) {
      description = widget.description;
    }

    _tabController = new TabController(vsync: this, length: 2);

    creditTermY = 12;
    creditTermM = 1;

    for (int i = 0; i < 60; i++) {
      creditTermMonthly.add((i + 1));
    }
    for (int i = 0; i < 30; i++) {
      creditTermYearly.add((i + 1) * 12);
    }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: tabBar(),
    );
  }

  Widget tabBar() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: widget.backgroundColor ?? Colors.white,
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: DefaultTabController(
                length: 2,
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        // Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(description),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        // Tab bar
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // Tab bar butonları
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  // Tab bar butonları çerçeve
                                  decoration: BoxDecoration(
                                    //border: Border.all(width: 1, color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(5.5)),
                                  ),
                                  child: Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Stack(
                                      children: <Widget>[
                                        // Gri tab
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: isSelectedLeft
                                                        ? Colors.black
                                                        : Colors.white,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: isSelectedLeft
                                                          ? widget.selectedTabBorderColor ??
                                                              Colors.black
                                                          : widget.unselectedTabBorderColor ??
                                                              Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5.5))),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: isSelectedLeft
                                                        ? Colors.white
                                                        : Colors.black,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: isSelectedLeft
                                                          ? widget.unselectedTabBorderColor ??
                                                              Colors.grey
                                                          : widget.selectedTabBorderColor ??
                                                              Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5.5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Tab butonları
                                        TabBar(
                                          controller: _tabController,
                                          labelColor:
                                              widget.selectedTabLabelColor ??
                                                  Colors.white,
                                          unselectedLabelColor:
                                              widget.unselectedTabLabelColor ??
                                                  Colors.black,
                                          indicator: UnderlineTabIndicator(
                                            borderSide: BorderSide(
                                              color: widget.tabBarLineColor ??
                                                  Colors.transparent,
                                              width: 4.0,
                                            ),
                                            insets: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 40.0),
                                          ),
                                          onTap: (index) {
                                            setState(() {
                                              isSelectedLeft =
                                                  index == 0 ? true : false;
                                            });
                                          },
                                          tabs: <Widget>[
                                            Tab(
                                              text: tabSecondTitle,
                                            ),
                                            Tab(
                                              text: tabFirstTitle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Tab bar elemanları
                              Container(
                                height: contSize,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                // İnnputlar dış çerçevesi
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.5)),
                                ),
                                child: TabBarView(
                                  controller: _tabController,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Tab(
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          // Main input
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  creditLimitAmountInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                onSaved: (input) {
                                                  creditLimitAmount =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      creditAmountInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) {
                                                  creditBalance =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  creditPriceInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) {
                                                  creditPurchase =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Faiz input
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      interestInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                onSaved: (input) {
                                                  interest =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),

                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  timeOfRepaymentInMonths,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                onSaved: (input) {
                                                  creditTermM =
                                                      int.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          // Vade input
                                          // Flexible(
                                          //   child: Container(
                                          //     width: MediaQuery.of(context)
                                          //         .size
                                          //         .width,
                                          //     margin: EdgeInsets.only(
                                          //       left: 10,
                                          //       right: 10,
                                          //     ),
                                          //     decoration: BoxDecoration(
                                          //       border: Border.all(
                                          //           width: 1,
                                          //           color:
                                          //               Colors.grey.shade200),
                                          //     ),
                                          //     child:
                                          //         DropdownButtonHideUnderline(
                                          //       child: DropdownButtonFormField<
                                          //           int>(
                                          //         hint: Padding(
                                          //           padding: EdgeInsets.only(
                                          //               left: 10),
                                          //           child:
                                          //               Text(termDropDownText),
                                          //         ),
                                          //         value: creditTermM,
                                          //         elevation: 16,
                                          //         style: TextStyle(
                                          //             color: Colors.black),
                                          //         onChanged: (int newValue) {
                                          //           setState(() {
                                          //             creditTermM = newValue;
                                          //           });
                                          //         },
                                          //         items: creditTermMonthly.map<
                                          //             DropdownMenuItem<
                                          //                 int>>((int value) {
                                          //           return DropdownMenuItem<
                                          //               int>(
                                          //             value: value,
                                          //             child: Padding(
                                          //               padding:
                                          //                   EdgeInsets.only(
                                          //                 left: 10,
                                          //               ),
                                          //               child: Text(
                                          //                   value.toString() +
                                          //                       monthText),
                                          //             ),
                                          //           );
                                          //         }).toList(),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: widget.buttonColor ??
                                                    Colors.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.5)),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: FlatButton(
                                                child: Text(
                                                  secondCalculatorButtonText,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    calculators(creditTermM);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TablePage(
                                                                      creditTableList:
                                                                          creditModelList,
                                                                      totalAmount: totalAmount,
                                                                      creditLimitInterest:result,
                                                                      creditRatio: creditRatio,
                                                                      anualPayment:anualPayment,
                                                                      totalInterest:totalInterest,
                                                                      creditBalance:creditBalance,
                                                                      creditAmount:
                                                                          creditAmount,
                                                                      
                                                                      creditTerm:
                                                                          creditTermM,
                                                                      interest:
                                                                          interest,
                                                                      // bsmv:
                                                                      //     bsmv,
                                                                      // kkdf:
                                                                      //     kkdf,
                                                                      installment:
                                                                          installment,
                                                                      themeColor:
                                                                          widget
                                                                              .tablePageThemeColor,
                                                                      labelColor:
                                                                          widget
                                                                              .tablePageLabelColor,
                                                                    )));
                                                  } else {
                                                    setState(() {
                                                      _autoValidate = true;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          //input Fields

                                          // Flexible(
                                          //   child: Container(
                                          //     margin: EdgeInsets.only(
                                          //         left: 10, right: 10),
                                          //     child: TextFormField(
                                          //       onTap: () {
                                          //         _autoValidate = false;
                                          //       },
                                          //       decoration: InputDecoration(
                                          //         labelText:
                                          //         creditLimitAmountInputLabelText,
                                          //         labelStyle: TextStyle(
                                          //             color: Colors.black54),
                                          //         errorStyle: TextStyle(
                                          //             height: 0.02,
                                          //             fontSize: 10),
                                          //         border: OutlineInputBorder(),
                                          //         contentPadding:
                                          //         EdgeInsets.only(left: 10),
                                          //       ),
                                          //       keyboardType:
                                          //       TextInputType.number,
                                          //       onSaved: (input) {
                                          //         setState(() {
                                          //           creditLimitAmount =
                                          //               double.parse(input);
                                          //         });
                                          //       },
                                          //       validator: (String value) {
                                          //         return validWarn(value);
                                          //       },
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(height: 10),

                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  creditCarAmountInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.02,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) {
                                                  setState(() {
                                                    creditCarAmounts =
                                                        double.parse(input);
                                                  });
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                // onTap: () {
                                                //   _autoValidate = false;
                                                // },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  creditCarAmountTradeInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  // errorStyle: TextStyle(
                                                  //     height: 0.02,
                                                  //     fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                // onSaved: (input) {
                                                //   input != null?
                                                //   setState(() {
                                                //     creditCarTradeAmount =
                                                //         double.parse(input);
                                                //   }): setState(() {
                                                //     creditCarTradeAmount =
                                                //         double.parse('1');
                                                //   });
                                                // },
                                                onChanged: (v){
                                                   setState(() {
                                                        creditCarTradeAmount =
                                                            double.parse(v);
                                                      });
                                                },
                                                // validator: (String value) {
                                                //   return validWarn(value);
                                                // },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Faiz input
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      interestInputLabelText,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                onSaved: (input) {
                                                  interest =
                                                      double.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                onTap: () {
                                                  _autoValidate = false;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                  timeOfRepaymentInMonths,
                                                  labelStyle: TextStyle(
                                                      color: Colors.black54),
                                                  errorStyle: TextStyle(
                                                      height: 0.04,
                                                      fontSize: 10),
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                  EdgeInsets.only(left: 10),
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                onSaved: (input) {
                                                  creditTermM =
                                                      int.parse(input);
                                                },
                                                validator: (String value) {
                                                  return validWarn(value);
                                                },
                                              ),
                                            ),
                                          ),

                                          // Vade input
                                          // Flexible(
                                          //   child: Container(
                                          //     height: MediaQuery.of(context)
                                          //         .size
                                          //         .height,
                                          //     width: MediaQuery.of(context)
                                          //         .size
                                          //         .width,
                                          //     margin: EdgeInsets.only(
                                          //       left: 10,
                                          //       right: 10,
                                          //     ),
                                          //     child:
                                          //         DropdownButtonHideUnderline(
                                          //       child: DropdownButtonFormField<
                                          //           int>(
                                          //         hint: Padding(
                                          //           padding: EdgeInsets.only(
                                          //               left: 10),
                                          //           child:
                                          //               Text(termDropDownText),
                                          //         ),
                                          //         value: creditTermY,
                                          //         elevation: 16,
                                          //         style: TextStyle(
                                          //             color: Colors.black),
                                          //         onChanged: (int newValue) {
                                          //           setState(() {
                                          //             creditTermY = newValue;
                                          //           });
                                          //         },
                                          //         items: creditTermYearly.map<
                                          //             DropdownMenuItem<
                                          //                 int>>((int value) {
                                          //           return DropdownMenuItem<
                                          //               int>(
                                          //             value: value,
                                          //             child: Padding(
                                          //               padding:
                                          //                   EdgeInsets.only(
                                          //                 left: 10,
                                          //               ),
                                          //               child: Text(
                                          //                   value.toString() +
                                          //                       monthText),
                                          //             ),
                                          //           );
                                          //         }).toList(),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Hesaplama Butonu
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: widget.buttonColor ??
                                                    Colors.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.5)),
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: FlatButton(
                                                child: Text(
                                                  firstCalculatorButtonText,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _formKey.currentState
                                                        .save();
                                                    calculators(creditTermM);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TablePage(
                                                                      creditTableList:
                                                                          creditModelList,
                                                                      totalAmount: totalAmount,
                                                                      creditLimitInterest:creditLimitInterest,
                                                                      creditRatio: creditRatio,
                                                                      anualPayment:anualPayment,
                                                                      totalInterest: totalInterest,
                                                                      creditAmount:
                                                                          creditAmount,
                                                                      creditTerm:
                                                                      creditTermM,
                                                                      interest:
                                                                          interest,
                                                                      // bsmv:
                                                                      //     bsmv,
                                                                      // kkdf:
                                                                      //     kkdf,
                                                                      installment:
                                                                          installment,
                                                                      themeColor:
                                                                          widget
                                                                              .tablePageThemeColor,
                                                                      labelColor:
                                                                          widget
                                                                              .tablePageLabelColor,
                                                                    )));
                                                  } else {
                                                    setState(() {
                                                      _autoValidate = true;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculators(int length) {

    if(creditCarTradeAmount != null){
      if(creditCarTradeAmount <= 9){
        setState(() {
          creditCarAmount = creditCarAmounts;
          creditCarTradeAmount = null;
        });
      }else{
        setState(() {
          creditCarAmount = creditCarAmounts - creditCarTradeAmount;
        });
      }
    }else{
      creditCarAmount = creditCarAmounts;
    }


    if(creditBalance == null){
      setState(() {
        creditAmount = creditCarAmount;
      });
    }else{
            if(creditPurchase != null){
              setState(() {
                creditAmount = creditBalance + creditPurchase;
                creditPurchase = null;

              });
            }else if(creditCarAmount != null){
              setState(() {
                creditAmount = creditCarAmount;
                  creditCarAmount = null;
              });
            }else{
              setState(() {
                creditAmount = creditBalance + creditPurchase;

              });
             }


    }


    taxInterest = (((interest / 100) / 12) % 10);
    temp1 = taxInterest;
    temp2 = (1 - pow((1 + taxInterest), -length));
    installment = creditAmount * temp1 / temp2;
    totalAmount = installment * length;
    totalInterest = totalAmount -creditAmount;
    creditRatio = creditAmount / totalAmount;
    anualPayment = installment * 12;

    creditLimitAmount == null ? null : result = creditLimitAmount - creditAmount;

    creditModelList.clear();
    for (int row = 0; row < length; row++) {
      creditTableModel = new CreditTableModel();
      if (row == 0) {
        creditTableModel.installment = installment;
       
        creditTableModel.interest =
            creditAmount * (((interest / 100) / 12) % 10);

        creditTableModel.mainCurrency = installment - creditTableModel.interest;

        mainRemainingMoney = creditAmount - creditTableModel.mainCurrency;

        creditTableModel.mainRemainingMoney = mainRemainingMoney;

        creditModelList.add(creditTableModel);
      } else {
        creditTableModel.installment = installment;

        creditTableModel.interest =
            mainRemainingMoney * (((interest / 100) / 12) % 10);

        // creditTableModel.kkdf = creditTableModel.interest * kkdf;

        // creditTableModel.bsmv = creditTableModel.interest * bsmv;

        creditTableModel.mainCurrency = installment - creditTableModel.interest;

        mainRemainingMoney = mainRemainingMoney - creditTableModel.mainCurrency;

        creditTableModel.mainRemainingMoney = mainRemainingMoney;

        creditModelList.add(creditTableModel);
      }
    }
  }

  String validWarn(String value) {
    if (value.isEmpty || value == null || value == "null") {
      return validatorWarning;
    } else if (double.parse(value) <= 0) {
      return validatorWarning2;
    } else {
      return null;
    }
  }
}
