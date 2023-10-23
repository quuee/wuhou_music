
import 'package:get/get.dart';
import 'package:wuhoumusic/api/user_api.dart';

class HotTabController extends GetxController{

  getList(){
    UserApi.getUserInfo();
  }

}