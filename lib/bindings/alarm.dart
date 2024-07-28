import 'package:get/get.dart';
import 'package:last/controller/alarm.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AlarmController());
  }
}
