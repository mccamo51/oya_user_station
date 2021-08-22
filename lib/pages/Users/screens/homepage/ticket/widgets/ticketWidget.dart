import 'package:flutter/material.dart';
import 'package:oya_porter/components/textField.dart';

Widget ticketContactWidget({
  @required BuildContext context,
  @required TextEditingController fromController,
  @required TextEditingController toController,
  @required TextEditingController dateController,
  @required Function onCreate,
  @required Function onDate,
  @required void Function() fromTap,
  @required void Function() toTap,
  @required Key formKey,
}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Stack(
      children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.7,
            //   child: Text(
            //     "Journey Details",
            //     style: TextStyle(
            //       fontSize: 15,
            //       color: Color(0xff363635),
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            SizedBox(height: 0),
            Form(
              key: formKey,
              child: Column(children: [
                GestureDetector(
                  onTap: fromTap,
                  child: textFormField(
                    removeBorder: true,
                    controller: fromController,
                    focusNode: null,
                    hintText: "Where are you travelling from?",
                    labelText: "Where are you travelling from?",
                    enable: false,
                    validateMsg: "Select where you are travelling from",
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: toTap,
                  child: textFormField(
                    removeBorder: true,
                    controller: toController,
                    focusNode: null,
                    hintText: "Where are you travelling to?",
                    labelText: "Where are you travelling to?",
                    enable: false,
                    validateMsg: "Select where you are travelling to",
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: onDate,
                  child: textFormField(
                    removeBorder: true,
                    controller: dateController,
                    focusNode: null,
                    hintText: "Date",
                    labelText: "Date",
                    enable: false,
                    validateMsg: "Select date",
                  ),
                ),
                SizedBox(height: 0),
              ]),
            )
          ]),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: SizedBox(
        //     height: 45,
        //     width: double.infinity,
        //     child: OutlineButton(
        //       onPressed: onCreate,
        //       child: Text("Buy Ticket"),
        //       borderSide: BorderSide(color: PRIMARYCOLOR),
        //     ),
        //   ),
        // )
      ],
    ),
  );
}
