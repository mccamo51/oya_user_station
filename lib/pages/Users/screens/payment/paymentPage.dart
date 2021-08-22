import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/customLoading.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';
import 'widget/paymentWidget.dart';

class PaymentPage extends StatefulWidget {
  final String amount, slug;

  PaymentPage({
    @required this.amount,
    @required this.slug,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final accountNameController = TextEditingController();
  final networkController = TextEditingController();
  final phoneController = TextEditingController();
  FocusNode accountNamefocusNode, networkFocusNode, phonefocusNode;

  String network;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    accountNamefocusNode = new FocusNode();
    networkFocusNode = new FocusNode();
    phonefocusNode = new FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    accountNamefocusNode.dispose();
    networkFocusNode.dispose();
    phonefocusNode.dispose();
  }

  void _unFocusAllNode() {
    accountNamefocusNode.unfocus();
    networkFocusNode.unfocus();
    phonefocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text("Pay for Ticket"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.red,
            ),
            onPressed: () => iceAlert(
              context,
              "",
            ),
          ),
        ],
      ),
      body: Stack(children: [
        paymentWidget(
          accountNameController: accountNameController,
          accountNamefocusNode: accountNamefocusNode,
          formKey: _formKey,
          networkController: networkController,
          networkFocusNode: networkFocusNode,
          onNetwork: () => _onNetwork(),
          onPay: () => _onPay(),
          phoneController: phoneController,
          phonefocusNode: phonefocusNode,
          // referenceController: null,
          // referencefocusNode: null,
          amount: "GHS ${widget.amount}",
        ),
        if (_isLoading) customLoadingPage(),
      ]),
    );
  }

  Future<void> paymentDialog(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: Text(
              // 'Your ICE contact is needed for a variety of reasons.',
              '$msg',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Go Home', style: TextStyle(color: PRIMARYCOLOR)),
              onPressed: () {
                navigation(context: context, pageName: "home");
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPay() async {
    _unFocusAllNode();
    print("${widget.amount}");
    print("${accountNameController.text}");
    print("+${countryCode + phoneController.text}");
    print("$network");
    print("${widget.slug}");
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      try {
        final url = Uri.parse("$PAY_URL");
        Map<String, dynamic> body = {
          "amount": "${widget.amount}",
          "momo_name": "${accountNameController.text}",
          "momo_number": "+${countryCode + phoneController.text}",
          "payment_mode": "$network",
          "payment_type": "mobile_money",
          "reference": "${widget.slug}",
        };

        final response = await http
            .post(url,
                headers: {
                  "Authorization": "Bearer $accessToken",
                  'Content-Type': 'application/json'
                },
                body: json.encode(body))
            .timeout(Duration(seconds: 100));
        print(response.body);
        if (response.statusCode == 200) {
          Map<String, dynamic> decodeBody = json.decode(response.body);
          setState(() => _isLoading = false);
          if (decodeBody['status'] == 200) {
            paymentDialog(context, decodeBody["message"]);
          }
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          toastContainer(
            text: "Error occured. Please try again...",
            backgroundColor: RED,
          );
        }
      } on TimeoutException catch (_) {
        setState(() {
          _isLoading = false;
        });
        toastContainer(
          text: CONNECTIONTIMEOUT,
          backgroundColor: RED,
        );
      } on SocketException catch (s) {
        setState(() {
          _isLoading = false;
        });
        print(s);
        toastContainer(
          text: INTERNETCONNECTIONPROBLEM,
          backgroundColor: RED,
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e);
        toastContainer(
          text: "Error occured. Please try again...$e",
          backgroundColor: RED,
        );
      }
    }
  }

  void _onNetwork() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select network'),
        children: [
          ListTile(
            title: Text('AirtelTigo Money', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                networkController.text = 'AirtelTigo Money';
                network = "at";
              });
            },
          ),
          ListTile(
            title: Text('MTN Mobile Money', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                networkController.text = 'MTN Mobile Money';
                network = "mtn";
              });
            },
          ),
          ListTile(
            title: Text('Vodafone Cash', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                networkController.text = 'Vodafone Cash';
                network = "vfc";
              });
            },
          ),
        ],
      ),
    );
  }
}
