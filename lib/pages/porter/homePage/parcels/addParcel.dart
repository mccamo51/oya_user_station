import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/widgets/addParcelWidget.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;

class AddParcel extends StatefulWidget {
  @override
  _AddParcelState createState() => _AddParcelState();
}

class _AddParcelState extends State<AddParcel> {
  TextEditingController itemController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController paymentModeController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController reciepeintNameController = TextEditingController();
  TextEditingController reciepeintPhoneController = TextEditingController();
  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderPhoneController = TextEditingController();
  TextEditingController stationController = TextEditingController();
  String network, payType;
  bool _showMomo = true;
  bool isLoading = false;
  final picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    return addParcelWidget(
        context: context,
        onSend: () => _onSave(
              descrip: descController.text,
              name: itemController.text,
              recName: reciepeintNameController.text,
              recPhone: reciepeintPhoneController.text,
              recStation: null,
              station: stationController.text,
              payMode: network,
              payType: payType,
              senderName: senderNameController.text,
              senderPhone: senderPhoneController.text,
              // img: _image.path,
              price: priceController.text,
            ),
        descController: descController,
        itemController: itemController,
        onSelectPaymentMode: () => _onNetwork(),
        onSelectPaymentType: () => _onPaymentType(),
        onSelectStationSelect: () {},
        paymentModeController: paymentModeController,
        paymentTypeController: paymentTypeController,
        priceController: priceController,
        reciepeintNameController: reciepeintNameController,
        reciepeintPhoneController: reciepeintPhoneController,
        senderNameController: senderNameController,
        senderPhoneController: senderPhoneController,
        stationController: stationController,
        showMomo: _showMomo,
        onCapture: () => getImage(),
        img: _image);
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _onPaymentType() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Payment Type'),
        children: [
          ListTile(
            title: Text('Cash', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentTypeController.text = 'Cash';
                payType = "cash";
                _showMomo = false;
              });
            },
          ),
          ListTile(
            title: Text('Momo', style: h3Black),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                paymentModeController.text = 'Momo';
                payType = "momo";
                _showMomo = true;
              });
            },
          ),
        ],
      ),
    );
  }

  _onStationSelect() {}

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
                paymentModeController.text = 'AirtelTigo Money';
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
                paymentModeController.text = 'MTN Mobile Money';
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
                paymentModeController.text = 'Vodafone Cash';
                network = "vfc";
              });
            },
          ),
        ],
      ),
    );
  }

  _onSave({
    @required String name,
    @required String descrip,
    @required String senderName,
    @required String senderPhone,
    @required String recName,
    @required String recPhone,
    @required String price,
    @required String payType,
    @required String payMode,
    @required String recStation,
    @required String img,
    @required String station,
  }) async {
    if (img == null || payType.isEmpty || payMode.isEmpty) {
      print(img);
      wrongPasswordToast(
          msg: "All this fields are required",
          title: "Required",
          context: context);
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        // print("$driverId");
        final response = await http.post(
          "$BASE_URL/buses",
          body: {
            'name': name,
            'description': descrip,
            'sender_name': senderName,
            'sender_phone': senderPhone,
            'payment_type': payType,
            'payment_mode': payMode,
            'image': img,
            'price': price,
            'station_id': station,
            'receiving_station_id': recStation,
            'recipient_phone': recPhone,
            'recipient_name': recName
          },
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ).timeout(
          Duration(seconds: 50),
        );
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            isLoading = false;
          });
          if (responseData['status'] == 200) {
            toastContainer(text: responseData['message']);
            Navigator.pop(context);
          } else {
            toastContainer(text: responseData['message']);
          }
        }
      } on TimeoutException catch (_) {
        setState(() {
          isLoading = false;
        });
        toastContainer(text: CONNECTIONTIMEOUT);
      } on SocketException catch (_) {
        setState(() {
          isLoading = false;
        });
        toastContainer(text: INTERNETCONNECTIONPROBLEM);
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
