import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oya_porter/provider/busSeatsProvider.dart';

class BusSeatsModel {
  int id, status, number, fakeId;
  bool selected, tempSelected;

  BusSeatsModel({
    @required this.id,
    @required this.number,
    @required this.status,
    @required this.selected,
    @required this.fakeId,
    @required this.tempSelected,
  });
}

class BusSeatsModelList {
  List<BusSeatsModel> busSeatsModelList;
  BusSeatsModelList({@required this.busSeatsModelList});
}

BusSeatsModelList busSeatsModelList =
    new BusSeatsModelList(busSeatsModelList: []);

Future<String> fetchBusSeatsModel(String id, BuildContext context) async {
  String m;
  busSeatsModelList.busSeatsModelList.clear();
  try {
    await fetchBusSeats(id, context).then((Map<String, dynamic> snapshot) {
      for (int x = 0; x < snapshot["data"].length; ++x) {
        busSeatsModelList.busSeatsModelList.add(
          BusSeatsModel(
            id: snapshot["data"][x]["id"],
            number: snapshot["data"][x]["number"],
            status: snapshot["data"][x]["status"],
            selected: false,
            fakeId: x,
            tempSelected: false,
          ),
        );
      }
      m = "completed";
    });
  } catch (e) {
    m = "error";
  }
  return m;
}

void setSetSelection(List<int> ids) {
  for (int x = 0; x < busSeatsModelList.busSeatsModelList.length; ++x)
    busSeatsModelList.busSeatsModelList[x].selected = false;
  for (var id in ids) {
    busSeatsModelList.busSeatsModelList[id - 1].selected = true;
  }
}

void setSetSelectionTemp(List<int> ids) {
  for (var id in ids) {
    busSeatsModelList.busSeatsModelList[id - 1].tempSelected = true;
  }
}
