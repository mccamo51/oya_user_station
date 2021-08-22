import 'package:flutter/material.dart';
import 'package:oya_porter/config/button.dart';
import 'package:oya_porter/pages/Users/screens/homepage/ticket/widgets/busSelectionWidget.dart';
import 'package:oya_porter/spec/colors.dart';
import 'seatSelection.dart';

String insurancePolicy;

class BusSelection extends StatefulWidget {
  final Map<String, dynamic> buses;

  BusSelection({@required this.buses});

  @override
  _BusSelectionState createState() => _BusSelectionState();
}

class _BusSelectionState extends State<BusSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(3),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 10),
                    child: customBack(context, "Bus Selection"),
                  ),
                  for (var data in widget.buses["data"])
                    busSelectionLayoutWidget(
                      context: context,
                      regNo: data['bus']['reg_number'],
                      onTap: () {
                        // insurancePolicy =
                        //     "${data['bus']['driver']['station']['insurance_policy_id']}";

                        print(data['bus']['reg_number']);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SeatSelection(
                              busId: data["id"].toString(),
                              totalSeat: data["bus"]["bus_type"]["max_capacity"]
                                  .toString(),
                              busModel: data["bus"]["model"],
                              price: data["price"].toString(),
                              tripDate: data["departure_date"],
                              tripTime: data["departure_time"],
                              route:
                                  "${data["route"]["from"]["name"]} - ${data["route"]["to"]["name"]}",
                              station: data["bus"]["driver"]["station"]["name"],
                            ),
                          ),
                        );
                      },
                      busModel: data["bus"]["model"],
                      price: data["price"].toString(),
                      stationName: data["bus"]["driver"]["station"]["name"],
                      seatsNo:
                          data["bus"]["bus_type"]["max_capacity"].toString(),
                      time:
                          "${data["departure_date"]}\n${data["departure_time"]}",
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
