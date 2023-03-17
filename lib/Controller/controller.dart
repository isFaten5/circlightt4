import 'package:get/get.dart';

import '../Pages/Pick_up.dart';

class PickupController extends GetxController {
  var data = "".obs;
  updateDataHome(val) {
    data.value = val;
    update();
  }

  List<Personclass> selectedname = [];
  var personList = <Personclass>[].obs;

  var categoryIndex = (-1).obs;
  updateCategoryIndex(val) {
    categoryIndex.value = val;
    update();
  }
}
