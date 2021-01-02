import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ccrs/table_model.dart';

class TablePage extends StatefulWidget {
  final List<CreditTableModel> creditTableList;
  final double creditAmount;
  final double creditBalance;
  final double anualPayment;
  final double totalInterest;
  final double creditLimitInterest;
  final int creditTerm;
  final double interest;
  final double creditRatio;
  final double totalAmount;
  final double bsmv;
  final double kkdf;
  final double installment;
  final Color themeColor;
  final Color labelColor;
  

  TablePage({
    this.creditBalance,
    this.creditLimitInterest,
    this.totalInterest,
    this.anualPayment,
    this.creditTableList,
    this.creditAmount,
    this.totalAmount,
    this.creditTerm,
    this.interest,
    this.creditRatio,
    this.bsmv,
    this.kkdf,
    this.installment,
    this.themeColor,
    this.labelColor,
  });

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  String tableAppBarTitle = "Pay chart";
  String creditAmountText = "Amount";
  String creditTotalAmountText = "Total Amount";
  String installmentText = "Monthly Payment";
  String creditTermText = "Term";
  String bsmvText = "BITT";
  String kkdfText = "KKDF";
  String creditInterestText = "Credit interest";
  String periodText = "Period";
  String mainMoneyText = "Principal";
  String interestText = "Interest";
  String remainingMainMoneyText = "Remaining";
  // String moneyType = " USD";
  String credtiRatioText = " Credit Ratio";

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
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 11,
              margin: EdgeInsets.all(11),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: dataBodyTitle(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
                alignment: Alignment.center,
                child: Text('Carrying a balance great than 35% may have a negative impact on your credit score.'),
            ),
            Card(
              elevation: 11,
              margin: EdgeInsets.all(11),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: dataBody(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataBodyTitle() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0,),
          widget.creditLimitInterest == null ? Container() : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Text('Remaining credit :',style: TextStyle(color: Colors.green),),),
              SizedBox(width: 10.0,),
              Container(child: Text(widget.creditLimitInterest.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),

            ],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(child: Text('Balance :'),),
            SizedBox(width: 10.0,),
            Container(child: Text(widget.creditAmount.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),
          ],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Container(child: Text('Monthly Payment :'),),
            SizedBox(width: 10.0,),
            Container(child: Text(widget.installment.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),
          ],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Text('Total Payment :'),),
              SizedBox(width: 10.0,),
              Container(child: Text(widget.totalAmount.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),
            ],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Text('Total Interest :'),),
              SizedBox(width: 10.0,),
              Container(child: Text(widget.totalInterest.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),
            ],),
          SizedBox(height: 10.0,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //   Container(child: Text('Interest rate :'),),
          //   SizedBox(width: 10.0,),
          //   Container(child: Text(widget.creditRatio.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),
          // ],),
          // SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Text('Time of Repayment :'),),
              SizedBox(width: 10.0,),
              Container(child: Text(widget.creditTerm.toString() +' Months',style: TextStyle(color: Colors.green),),),
            ],),
          // SizedBox(height: 10.0,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //   Container(child: Text('Annual Payment :'),),
          //   SizedBox(width: 10.0,),
          //   Container(child: Text(widget.anualPayment.toStringAsFixed(2),style: TextStyle(color: Colors.green),),),
          // ],),
        ],
      ),
    );
  }

  Widget dataBody() {
    return DataTable(
      columnSpacing: 5,
      columns: <DataColumn>[
        DataColumn(
            label: Text(
              periodText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              installmentText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              mainMoneyText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              interestText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
        DataColumn(
            label: Text(
              remainingMainMoneyText,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            numeric: false,
            tooltip: "",
            onSort: (i, b) {}),
      ],
      rows: widget.creditTableList
          .map((dataRow) => DataRow(cells: [
                DataCell(
                  Text(
                      (widget.creditTableList.indexOf(dataRow) + 1).toString()),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.installment.toStringAsFixed(2)),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.mainCurrency.toStringAsFixed(2)),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.interest.toStringAsFixed(2)),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(dataRow.mainRemainingMoney.toStringAsFixed(2)),
                  showEditIcon: false,
                  placeholder: false,
                ),
              ]))
          .toList(),
    );
  }
}
