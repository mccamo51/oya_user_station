import 'package:oya_porter/models/busModel.dart';
import 'package:oya_porter/models/stuffModel.dart';
import 'package:oya_porter/provider/provider.dart';

class Repository {
  OyaProvider _myProvider = OyaProvider();

  Future<BussModel> fetchBusses(String busId) =>
      _myProvider.fetchBusses(busId);

  Future<StaffModel> fetchAllStaff(String staffId) =>
      _myProvider.fetchAllStaffs(staffId);
}
