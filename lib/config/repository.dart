

import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/provider/provider.dart';

class Repository {
  OyaProvider _myProvider = OyaProvider();
  
  Future<BussModel> fetchPickupPoint(String busId) =>
      _myProvider.fetchBusses(busId);
}
