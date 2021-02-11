import 'package:flutter/material.dart';
import 'package:oya_porter/components/appBar.dart';
import 'package:oya_porter/components/buttons.dart';
import 'package:oya_porter/components/textField.dart';

class Schedules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: ("Schedules"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              textFormField(
                hintText: "Select Route",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Select Bus",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Select Driver",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Select Conductor",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Select Porter",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Departure Date/Time",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Estimate Arrival Date/Time",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              textFormField(
                hintText: "Ticket Price",
                controller: null,
                focusNode: null,
                icon: Icons.arrow_drop_down,
                enable: false,
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Is this a Priority BUS?"),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: true,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("Yes")
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: false,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("No")
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("A low ticket sales?"),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: true,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("Yes")
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: false,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("No")
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("A low mid route boarding?"),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: true,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("Yes")
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: false,
                              onChanged: ((val) {
                                print(val);
                              })),
                          Text("No")
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: primaryButton(title: "Save", onFunction: () {})),
              )
            ],
          ),
        ),
      ),
    );
  }
}
