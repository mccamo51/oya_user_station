import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/config/functions.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oya_porter/bloc/stationsBloc.dart';
import 'package:oya_porter/components/alerts.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/config/offlineData.dart';
import 'package:oya_porter/config/routes.dart';
import 'package:oya_porter/models/stationsModel.dart';
import 'package:oya_porter/pages/auth/login/login.dart';
import 'package:oya_porter/pages/porter/homePage/parcels/widgets/addParcelWidget.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/strings.dart';
import 'package:oya_porter/spec/styles.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

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
  String stID;
  final picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale.countryCode);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : addParcelWidget(
              context: context,
              locale: myLocale.countryCode,
              onSend: () => _onSave1(
                  descrip: descController.text,
                  name: itemController.text,
                  recName: reciepeintNameController.text,
                  recPhone: "+${countryCode + reciepeintPhoneController.text}",
                  recStation: stID,
                  station: stationId,
                  payMode: network,
                  payType: payType,
                  senderName: senderNameController.text,
                  senderPhone: "+${countryCode + senderPhoneController.text}",
                  // img: _image.path,
                  price: priceController.text,
                  context: context),
              descController: descController,
              itemController: itemController,
              onSelectPaymentMode: () => _onNetwork(context),
              onSelectPaymentType: () => _onPaymentType(context),
              onSelectStationSelect: () => androidSelectStation(
                  context: context, title: "Select Station"),
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
              img: _image),
    );
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

  _onPaymentType(BuildContext context) {
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

  void _onNetwork(BuildContext context) {
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

  Widget _mStation(StationsModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var data in model.data) ...[
          Platform.isIOS
              ? CupertinoActionSheetAction(
                  child: Text('${data.name}', style: TextStyle(color: BLACK)),
                  onPressed: () {
                    setState(() {
                      // _toCode = data.id;
                      stID = (data.id).toString();
                      stationController.text = data.name;
                    });

                    Navigator.pop(context);
                  },
                )
              : SimpleDialogOption(
                  onPressed: () {
                    stID = (data.id).toString();
                    stationController.text = data.name;
                    Navigator.pop(context);
                  },
                  child: Text("${data.name}", style: TextStyle(fontSize: 20)),
                ),
          Divider(),
        ]
      ],
    );
  }

  Widget allStations(BuildContext context) {
    // loadStationsOffline();
    stationsBloc.fetchAllStations(context);
    return StreamBuilder<Object>(
      stream: stationsBloc.stations,
      // initialData: stationsMapOffline == null
      //     ? null
      //     : StationsModel.fromJson(stationsMapOffline),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _mStation(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(child: CupertinoActivityIndicator(radius: 15));
      },
    );
  }

  Future<void> androidSelectStation(
      {String title, BuildContext context}) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('$title'),
            children: <Widget>[allStations(context)],
          );
        })) {
    }
  }

  _onSave(
      {@required String name,
      @required String descrip,
      @required String senderName,
      @required String senderPhone,
      @required String recName,
      @required String recPhone,
      @required String price,
      @required String payType,
      @required String payMode,
      @required String recStation,
      @required String station,
      @required BuildContext context}) async {
    print(payType);
    if (payType.isEmpty) {
      wrongPasswordToast(
          msg: "All this fields are required",
          title: "Required",
          context: context);
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        final url = Uri.parse("$BASE_URL/parcels");

        final response = await http.post(
          url,
          body: json.encode({
            'name': name,
            'description': descrip,
            'sender_name': senderName,
            'sender_phone': senderPhone,
            'payment_type': payType,
            'payment_mode': payMode,
            'price': price,
            'station_id': station,
            'receiving_station_id': recStation,
            'recipient_phone': recPhone,
            'recipient_name': recName
          }),
          headers: {
            "Authorization": "Bearer $accessToken",
            'Content-Type': 'application/json'
          },
        ).timeout(
          Duration(seconds: 50),
        );
        print(response.body);

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          print(responseData);
          setState(() {
            isLoading = false;
          });
          if (responseData['status'] == 200) {
            toastContainer(text: responseData['message']);
            Navigator.pop(context);
          } else {
            toastContainer(text: responseData['message']);
          }
        } else if (response.statusCode == 401) {
          sessionExpired(context);
        } else {
          toastContainer(text: "Error has occured");
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

  Future _onSave1(
      {@required String name,
      @required String descrip,
      @required String senderName,
      @required String senderPhone,
      @required String recName,
      @required String recPhone,
      @required String price,
      @required String payType,
      @required String payMode,
      @required String recStation,
      @required String station,
      @required BuildContext context}) async {
    if (_image == null || payType.isEmpty) {
      wrongPasswordToast(
          msg: "All this fields are required",
          title: "Required",
          context: context);
    } else {
      setState(() {
        isLoading = true;
      });
      var stream =
          new http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();

      var uri = Uri.parse("$BASE_URL/parcels");

      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(_image.path));

      Map<String, String> headers = {
        "Authorization": "Bearer $accessToken",
        // 'Content-Type': 'application/json'
      };
      request.headers.addAll(headers);

      request.fields['name'] = '$name';
      request.fields['description'] = '$descrip';
      request.fields['sender_name'] = '$senderName';
      request.fields['sender_phone'] = '$senderPhone';
      request.fields['payment_type'] = '$payType';
      payMode == null ? "" : request.fields['payment_mode'] = '$payMode';
      request.fields['price'] = '$price';
      request.fields['station_id'] = "$station";
      request.fields['receiving_station_id'] = "$recStation";
      request.fields['recipient_phone'] = "$recPhone";
      request.fields['recipient_name'] = "$recName";
      //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        response.stream.bytesToString().then((value) {
          setState(() {
            isLoading = false;
          });
          final data = json.decode(value);
          if (data['status'] == 200) {
            toastContainer(text: "Parcel Sent Successfully");
            Navigator.pop(context);
          } else {
            toastContainer(text: "Parcel Not Sent");
          }
          print(data);
        });
      } else if (response.statusCode == 401) {
        sessionExpired(context);
      } else {
        setState(() {
          isLoading = false;
        });
        print("Upload Failed");
      }
    }
  }
}
