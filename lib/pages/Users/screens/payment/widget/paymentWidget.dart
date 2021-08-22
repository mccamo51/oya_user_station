import 'package:flutter/material.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';
import 'package:oya_porter/spec/styles.dart';

Widget paymentWidget({
  @required TextEditingController phoneController,
  @required TextEditingController networkController,
  @required TextEditingController accountNameController,
  // @required TextEditingController referenceController,
  // @required FocusNode referencefocusNode,
  @required FocusNode accountNamefocusNode,
  @required FocusNode phonefocusNode,
  @required FocusNode networkFocusNode,
  @required void Function() onPay,
  @required void Function() onNetwork,
  @required Key formKey,
  @required String amount,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Amount Due", style: h5Black),
            SizedBox(height: 10),
            Text("$amount", style: h2BLUE),
            SizedBox(height: 20),
            GestureDetector(
              onTap: onNetwork,
              child: textFormField(
                controller: networkController,
                focusNode: networkFocusNode,
                hintText: "Network",
                labelText: "Network",
                removeBorder: true,
                validateMsg: "Select network type",
                enable: false,
              ),
            ),
            SizedBox(height: 10),
            newCountrySelect(
              controller: phoneController,
              // focus: phonefocusNode,
              hintText: "Phone Number",
            ),

            // textFormField(
            //   controller: phoneController,
            //   focusNode: phonefocusNode,
            //   hintText: "Phone Number",
            //   labelText: "Phone Number",
            //   inputType: TextInputType.phone,
            //   validateMsg: "Enter phone number",
            // ),
            SizedBox(height: 10),
            textFormField(
              controller: accountNameController,
              focusNode: accountNamefocusNode,
              hintText: "Account Name",
              labelText: "Account Name",
              validateMsg: "Enter account name",
            ),
            // SizedBox(height: 10),
            // textFormField(
            //   controller: referenceController,
            //   focusNode: referencefocusNode,
            //   hintText: "Reference",
            //   labelText: "Reference",
            //   validateMsg: "Enter reference",
            //   enable: false,
            // ),
            SizedBox(height: 20),
            ButtonTheme(
              minWidth: 500,
              height: 40,
              child: FlatButton(
                color: PRIMARYCOLOR,
                onPressed: onPay,
                child: Text("Pay for Ticket", style: h4Button),
                textColor: WHITE,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
