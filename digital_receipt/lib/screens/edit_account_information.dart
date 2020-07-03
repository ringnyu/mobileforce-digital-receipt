
import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/screens/account_page.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EditAccountInfoScreen extends StatefulWidget {
  EditAccountInfoScreen({Key key}) : super(key: key);

  @override
  _EditAccountInfoScreenState createState() => _EditAccountInfoScreenState();
}

final ApiService _apiService = ApiService();

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void submitOrder(){
   print('submitted');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Account Information',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
        // backgroundColor: Color(0xFF0B57A7),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
             child: Column(
      children: [
        SizedBox(height: 30),
        Text(
          'Tell us about your business. This information will show up in the receipt',
          style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 14,
              fontFamily: 'Montserrat',
              height: 1.43),

            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: EditAccountInfoForm(),
          ),

        ),
        Container(
      padding: EdgeInsets.only(top: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Bussiness name'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(17),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Color(0xFFC8C8C8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(),
              errorStyle: TextStyle(height: 0.5),
            ),
          ),
        ],
      ),

    ),
      Container(

    );
  }
}

class EditAccountInfoForm extends StatefulWidget {
  const EditAccountInfoForm({Key key}) : super(key: key);

  @override
  _EditAccountInfoFormState createState() => _EditAccountInfoFormState();
}

class _EditAccountInfoFormState extends State<EditAccountInfoForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String name;
  String address;
  String slogan;
  String logo;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Container _buildInputField(
      {String label,
      TextInputType keyboardType,
      Function onSaved,
      String initialValue}) {
    return Container(

      padding: EdgeInsets.only(top: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Phone number'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),

            keyboardType: TextInputType.phone,

            initialValue: initialValue,
            onSaved: onSaved,
            validator: (value) {
              /*  if (value.isEmpty $$ la) {
                return 'Invalid New Password';
              } */

              switch (label) {
                case 'Business name':
                  if (value.isEmpty) {
                    return 'Invalid business name';
                  }
                  break;
                case 'Phone number':
                  if (value.isEmpty) {
                    return 'Invalid phone number';
                  }
                  break;
                case 'Address':
                  if (value.isEmpty) {
                    return 'Invalid address';
                  }
                  break;
                case 'Business slogan (optional)':
                  if (value.isEmpty) {
                    return 'Invalid business slogan';
                  }
                  break;
                default:
              }
            },
            keyboardType: keyboardType,

            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(17),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Color(0xFFC8C8C8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(),
              errorStyle: TextStyle(height: 0.5),
            ),
          ),
        ],
      ),

    ),
      Container(
      padding: EdgeInsets.only(top: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Addresss'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(17),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Color(0xFFC8C8C8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(),
              errorStyle: TextStyle(height: 0.5),
            ),
          ),
        ],
      ),
    ),
      Container(
      padding: EdgeInsets.only(top: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Bussiness slogan(optional)'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(17),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Color(0xFFC8C8C8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(),
              errorStyle: TextStyle(height: 0.5),
            ),
          ),
        ],
      ),
    ),
     
        SizedBox(height: 100),
        MaterialButton(
          height: 45,
          minWidth: double.infinity,
          onPressed: () => submitOrder(),
          color: Theme.of(context).primaryColor,
          child: Text(
            'Update',

    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      //autovalidate: true,
      child: Column(
        children: [
          // SizedBox(height: 30),
          Text(
            'Tell us about your business. This information will show up in the receipt',

            style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 14,
                fontFamily: 'Montserrat',
                height: 1.43),
          ),
          _buildInputField(
            label: 'Business name',
            onSaved: (String value) => name = value,
          ),
          _buildInputField(
            label: 'Phone number',
            keyboardType: TextInputType.phone,
            onSaved: (String value) => phoneNumber = value,
          ),
          _buildInputField(
            label: 'Address',
            onSaved: (String value) => address = value,
          ),
          _buildInputField(
            label: 'Business slogan (optional)',
            onSaved: (String value) => slogan = value,
          ),

        )
      ],
    )
            ),
          ),
        ),

          SizedBox(height: 100),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: FlatButton(
              onPressed: () async {
                // if (_formKey.currentState.validate()) {
                setState(() {
                  loading = true;
                });
                _formKey.currentState.save();
                // }
                print("""name: $name,
                number: $phoneNumber,
                address: $address,
                slogan: $slogan""");
                var res = await _apiService.updateBusinessInfo(
                  phoneNumber: phoneNumber,
                  name: name,
                  address: address,
                  slogan: slogan,
                );
                if (res == true) {
                  setState(() {
                    loading = false;
                  });
                  Fluttertoast.showToast(
                    msg: "Account updated successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              color: Theme.of(context).primaryColor,
              child: loading
                  ? ButtonLoadingIndicator(
                      color: Colors.white, height: 20, width: 20)
                  : Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.30),
                    ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
            ),
          )
        ],

      ),
    );
  }
}

