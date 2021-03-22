import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

Widget addParcelWidget(
    {@required BuildContext context,
    @required TextEditingController itemController,
    @required TextEditingController descController,
    @required TextEditingController senderNameController,
    @required TextEditingController senderPhoneController,
    @required TextEditingController paymentTypeController,
    @required TextEditingController paymentModeController,
    @required TextEditingController reciepeintNameController,
    @required TextEditingController reciepeintPhoneController,
    @required TextEditingController priceController,
    @required TextEditingController stationController,
    @required Function onSend,
    @required Function onSelectPaymentMode,
    @required Function onSelectPaymentType,
    @required Function onSelectStationSelect,
    @required Function onCapture,
    @required bool showMomo = false,
    @required var img}) {
  return Scaffold(
    appBar: appBar(title: "Add Parcel"),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Item Name",
              controller: itemController,
              focusNode: null,
              labelText: "Item Name",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Description",
              controller: descController,
              focusNode: null,
              labelText: "Description",
              minLine: 4,
              maxLine: 4,
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Sender's Name",
              controller: senderNameController,
              focusNode: null,
              labelText: "Sender's Name",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Sender's Phone",
              controller: senderPhoneController,
              focusNode: null,
              labelText: "Sender's Phone",
              inputType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectPaymentType,
              child: textFormField(
                hintText: "Select Payment Type",
                controller: paymentTypeController,
                focusNode: null,
                enable: false,
                labelText: "Select Payment Type",
                icon: Icons.money,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: showMomo,
              child: GestureDetector(
                onTap: onSelectPaymentMode,
                child: textFormField(
                  hintText: "Select Payment Mode",
                  controller: paymentModeController,
                  focusNode: null,
                  enable: false,
                  labelText: "Select Payment Mode",
                  // icon: Icons.calendar_today,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Recipient Name",
              controller: reciepeintNameController,
              focusNode: null,
              labelText: "Recipient Name",
            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Recipient Phone",
              controller: reciepeintPhoneController,
              focusNode: null,
              labelText: "Recipient Phone",
              inputType: TextInputType.number,

            ),
            SizedBox(
              height: 10,
            ),
            textFormField(
              hintText: "Price",
              controller: priceController,
              focusNode: null,
              labelText: "Price",
              inputType: TextInputType.number,

            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onSelectStationSelect,
              child: textFormField(
                hintText: "Select Receiving Station",
                controller: stationController,
                focusNode: null,
                enable: false,
                labelText: "Select Receiving Station",
                // icon: Icons.calendar_today,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              color: PRIMARYCOLOR.withOpacity(0.4),
              width: double.infinity,
              child: IconButton(
                icon: img == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: 40,
                      )
                    : Image.file(img),
                onPressed: onCapture,
              ),
            )
          ],
        ),
      ),
    ),
    bottomNavigationBar: Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: PRIMARYCOLOR,
          child: Text("Send Parcel"),
          onPressed: onSend,
        ),
      ),
    ),
  );
}
