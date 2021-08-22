import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/components/emptyBox.dart';
import 'package:oya_porter/components/phoneNumberText.dart';
import 'package:oya_porter/components/toast.dart';
import 'package:oya_porter/pages/Users/model/busSeatsModel.dart';
import 'package:oya_porter/pages/Users/screens/homepage/homeMap/newHome.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/widgets/otherPassengerDialog.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/widgets/seatSelectionWidget.dart';
import 'package:oya_porter/spec/colors.dart';
import 'trip.dart';

List<Map<String, dynamic>> otherPassanger = new List<Map<String, dynamic>>();

List<int> seatSelectedId = new List<int>();
List<int> seatSelectedIdTemp = new List<int>();

class SeatSelection extends StatefulWidget {
  final String busId, station;
  final String totalSeat, busModel, price, tripDate, tripTime, route;

  SeatSelection({
    @required this.busId,
    @required this.totalSeat,
    @required this.busModel,
    @required this.price,
    @required this.tripTime,
    @required this.tripDate,
    @required this.route,
    @required this.station,
  });

  @override
  _SeatSelectionState createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  Future<String> busSeatFuture;
  List<int> seatSelectedId = new List<int>();
  String seatSelectedName;
  List<Map<String, dynamic>> otherPassanger = new List<Map<String, dynamic>>();

  initState() {
    super.initState();
    busSeatFuture = fetchBusSeatsModel(widget.busId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        title: Text("Seat Selection"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<String>(
          future: busSeatFuture,
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return emptyBox(context);
                break;
              case ConnectionState.waiting:
                return Center(child: CupertinoActivityIndicator(radius: 15));
                break;
              case ConnectionState.active:
                print("active connectionState");
                break;
              case ConnectionState.done:
                bool show = _checkData();
                return show ? _mainContent() : emptyBox(context);
                break;
            }
          }),
      bottomNavigationBar: seatSelectionButtonWidget(
        onPressed: () {
          if (seatSelectedId == null) {
            toastContainer(
              text: "Select seat to proceed",
              backgroundColor: RED,
            );
          } else {
            toastContainer(text: "${seatSelectedId}");

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Trip(
                  mySelf: true,
                  seatId: seatSelectedId,
                  busId: widget.busId,
                  price: widget.price,
                  seatsSelected: seatSelectedName,
                  selectedBusModel: widget.busModel,
                  tripDate: widget.tripDate,
                  tripTime: widget.tripTime,
                  route: widget.route,
                  station: widget.station,
                  otherPassanger: otherPassanger,
                ),
              ),
            );
          }
        },
        details: "${widget.busModel} (${widget.totalSeat[0]}) Seater",
        onAddOther: () {
          final GlobalKey<FormState> formKey = GlobalKey<FormState>();
          TextEditingController nameController = new TextEditingController();
          TextEditingController phoneController = new TextEditingController();
          TextEditingController primaryIceNumberController =
              new TextEditingController();
          FocusNode nameFocusNode = new FocusNode();
          FocusNode phoneFocusNode = new FocusNode();
          FocusNode primaryIceNumberFocusNode = new FocusNode();
          if (seatSelectedId.length > 0)
            showDialog(
              context: context,
              builder: (context) => otherPassengerFormDialog(
                key: formKey,
                nameController: nameController,
                nameFocusNode: nameFocusNode,
                onAdd: () {
                  nameFocusNode.unfocus();
                  phoneFocusNode.unfocus();
                  if (formKey.currentState.validate()) {
                    setState(() {
                      otherPassanger.add(
                        {
                          "name": "${nameController.text}",
                          "phone": "+${countryCode + phoneController.text}",
                          "seat_id": "${seatSelectedId[0]}",
                          "minor_count": 0,
                          "ice1_phone": primaryIceNumberController.text.isEmpty
                              ? ""
                              : "+${countryCode+primaryIceNumberController.text}"
                        },
                      );
                    });
                    toastContainer(
                      text: "Passenger added successfully...",
                      backgroundColor: PRIMARYCOLOR,
                    );
                    Navigator.of(context).pop();
                  }
                },
                phoneController: phoneController,
                phoneFocusNode: phoneFocusNode,
                primaryIceNumberController: primaryIceNumberController,
                primaryIceNumberFocusNode: primaryIceNumberFocusNode,
              ),
            );
          else
            toastContainer(
              text: "Select seat to continue",
              backgroundColor: RED,
            );
        },
        totalNumber: "${otherPassanger.length}",
      ),
    );
  }

  bool _checkData() {
    bool data = false;
    int len = busSeatsModelList.busSeatsModelList.length;
    print(len);
    if (len > 0) data = true;
    return data;
  }

  Widget _mainContent() {
    return Stack(
      children: [
        seatSelectionWidget(
          context: context,
          mainContent: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FeatherIcons.chrome),
                      Icon(FeatherIcons.speaker),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: BLACK),
                Wrap(
                  children: [
                    for (int x = 0;
                        x < busSeatsModelList.busSeatsModelList.length;
                        ++x) ...[
                      seatSelectionBusWidget(
                        text: busSeatsModelList.busSeatsModelList[x].number
                            .toString(),
                        color: busSeatsModelList.busSeatsModelList[x].status ==
                                1
                            ? LIGHTRED
                            : busSeatsModelList.busSeatsModelList[x].selected
                                ? PRIMARYCOLOR
                                : LIGHTGREEN,
                        context: context,
                        onTap:
                            busSeatsModelList.busSeatsModelList[x].status == 1
                                ? null
                                : () {
                                    toastContainer(
                                      text:
                                          "Seat ${busSeatsModelList.busSeatsModelList[x].number} selected",
                                      backgroundColor: PRIMARYCOLOR,
                                    );
                                    setState(() {
                                      if (buyTicketForOthers)
                                        seatSelectedId.clear();
                                      seatSelectedId.add(busSeatsModelList
                                          .busSeatsModelList[x].number);
                                      setSetSelection(seatSelectedId);
                                      seatSelectedName = busSeatsModelList
                                          .busSeatsModelList[x].number
                                          .toString();
                                    });
                                  },
                      ),
                      // if (x % 2 == 1) SizedBox(width: 15),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
