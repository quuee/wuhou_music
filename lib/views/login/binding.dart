import 'package:get/get.dart';
import 'package:wuhoumusic/views/login/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<LoginController>(() => LoginController());
  }


}