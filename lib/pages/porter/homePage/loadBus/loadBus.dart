import 'package:flutter/material.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/styles.dart';

class LoadBuses extends StatefulWidget {
  @override
  _LoadBusesState createState() => _LoadBusesState();
}

class _LoadBusesState extends State<LoadBuses> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? textFormField2(
                hintText: "Search",
                controller: null,
                focusNode: null,
              )
            : Text("Load Bus"),
        elevation: 0.3,
        centerTitle: true,
        actions: [
          IconButton(
              icon: isSearch ? Icon(Icons.close) : Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Bus Details",
                  style: h2Black,
                ),
                Text(
                  "G.P.R.T.U KANESHIE CAPE & TARDI (GR-1234 21)",
                  style: h3Black,
                ),
                Text(
                  "From: Kaneshie - Takoradi",
                  style: h4Black,
                ),
                Text(
                  "G.P.R.T.U KANESHIE CAPE & TARDI",
                  style: h3Black,
                ),
                Text(
                  "41 Passengers onboard",
                  style: h5ASH,
                ),
                Text(
                  "2 Minors",
                  style: h5ASH,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: true,
                            onChanged: ((val) {}),
                            groupValue: false,
                          ),
                          Text("General")
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: true,
                            onChanged: ((val) {}),
                            groupValue: false,
                          ),
                          Text("No Phone")
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: true,
                            onChanged: ((val) {}),
                            groupValue: false,
                          ),
                          Text("No Phone, No ICE Phone")
                        ],
                      )
                    ],
                  ),
                ),
                textFormField(
                  hintText: "Enter Ticket Number",
                  controller: null,
                  focusNode: null,
                  labelText: "Ticket Number",
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Are you a minor?"),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: true,
                              onChanged: ((val) {}),
                              groupValue: false,
                            ),
                            Text("Yes")
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: true,
                              onChanged: ((val) {}),
                              groupValue: false,
                            ),
                            Text("No")
                          ],
                        )
                      ],
                    ),
                    textFormField(
                      hintText: "Enter Full Name",
                      controller: null,
                      focusNode: null,
                      labelText: "Full name",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textFormField(
                      hintText: "Enter Primary Emergency phone (ICE)",
                      controller: null,
                      focusNode: null,
                      labelText: " Primary Emergency phone (ICE)",
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: primaryButton(
                      onFunction: () {}, title: "Enroll Passenger"),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: primaryButton(
                      onFunction: () {},
                      title: "Away Bus (Done Loading)",
                      color: Colors.red),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
