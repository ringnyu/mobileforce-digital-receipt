import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/models/receipt.dart';

/// This code displays only the UI
class ReceiptHistory extends StatefulWidget {
  @override
  _ReceiptHistoryState createState() => _ReceiptHistoryState();
}

class _ReceiptHistoryState extends State<ReceiptHistory> {
  TextEditingController _controller = TextEditingController();
  String dropdownValue = "Receipt No";
  bool _showDialog = true;
  //instead of dummyReceiptList use the future data gotten
  static List<Receipt> receiptList =
      ReceiptUtil.sortReceiptByReceiptNo(dummyReceiptList);
  // the below is needed so as to create a copy of the list,
  //for sorting and searching functionalities
  List<Receipt> copyReceiptList = receiptList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        //backgroundColor: Color(0xff226EBE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Receipt History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
        //centerTitle: true,
        actions: <Widget>[],
      ),
      body: FutureBuilder<List<Receipt>>(
        future: null, // receipts from API
        builder: (context, snapshot) {
          // If the API returns nothing it means the user has to upgrade to premium
          // for now it doesn't validate if the user has upgraded to premium
          /// If the API returns nothing it shows the dialog box `JUST FOR TESTING`
          ///
          /// Uncomment the if statement
          // if (!snapshot.hasData) {
          //   return _showAlertDialog();
          // }
          // else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _showDialog
                ? _showAlertDialog()
                : Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _controller,
                          onChanged: (value) async {
                            await Future.delayed(Duration(milliseconds: 700));
                            setState(() {
                              receiptList = ReceiptUtil.filterReceipt(
                                  copyReceiptList, _controller.text);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Type a keyword",
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: IconButton(
                              icon: Icon(Icons.search),
                              color: Colors.grey,
                              onPressed: () {
                                setState(() {
                                  receiptList = ReceiptUtil.filterReceipt(
                                      copyReceiptList, _controller.text);
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFFC8C8C8),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFFC8C8C8),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Text("Sort By"),
                              ),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xff25CCB3),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: dropdownValue,
                                    underline: Divider(),
                                    items: <String>[
                                      "Receipt No",
                                      "Date issued",
                                      "WhatsApp",
                                      "Instagram",
                                      "Twitter",
                                    ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              value,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (String value) {
                                      setState(() {
                                        dropdownValue = value;
                                        switch (value) {
                                          case "Date issued":
                                            receiptList =
                                                ReceiptUtil.sortReceiptByDate(
                                                    copyReceiptList);
                                            break;
                                          case "WhatsApp":
                                            receiptList = ReceiptUtil
                                                .sortReceiptByCategory(
                                                    copyReceiptList,
                                                    byCategory: ReceiptCategory
                                                        .WHATSAPP);
                                            break;
                                          case "Instagram":
                                            receiptList = ReceiptUtil
                                                .sortReceiptByCategory(
                                                    copyReceiptList,
                                                    byCategory: ReceiptCategory
                                                        .INSTAGRAM);
                                            break;
                                          case "Twitter":
                                            receiptList = ReceiptUtil
                                                .sortReceiptByCategory(
                                                    copyReceiptList,
                                                    byCategory: ReceiptCategory
                                                        .TWITTER);
                                            break;
                                          default:
                                            receiptList = ReceiptUtil
                                                .sortReceiptByReceiptNo(
                                                    copyReceiptList);
                                            break;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(height: 20.0),
                        Flexible(
                          child: ListView.builder(
                            itemCount: receiptList.length,
                            itemBuilder: (context, index) {
                              // HardCoded Receipt details
                              return receiptCard(receiptList[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          }
          // }
        },
      ),
    );
  }

  Widget receiptCard(Receipt receipt) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff539C30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
              color: Color(0xffE8F1FB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Receipt No: ${receipt.receiptNo}",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
                      Text(
                        "${receipt.issuedDate}",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "${receipt.customerName}",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.03,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  child: Text(
                    "${receipt.description}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.03,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  // )
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Total: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                          TextSpan(
                            text: ' N${receipt.totalAmount} ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _showAlertDialog() {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Color(0xFFF2F8FF),
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Stack(
        children: <Widget>[
          // Flexible(
          //   child:
          Image.asset(
            "assets/BACKGROUND.jpg",
            // height: 350,
            width: 300,
            fit: BoxFit.cover,
          ),
          // ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                    top: 130.0,
                  ),
                  child: Text(
                    "Oops, i'm sure you really",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "needed that?",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Upgrade to premium",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "now to enjoy amazing",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "features",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    color: Color(0xFF0B57A7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      setState(() {
                        _showDialog = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Upgrade",
                        style: TextStyle(
                          color: Color(0xffE5E5E5),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        // color: Color(0xffE5E5E5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
