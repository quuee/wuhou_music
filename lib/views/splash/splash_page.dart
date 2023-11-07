import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // 搞一个动画
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();

    _permission();

    _tween = Tween(begin: 0, end: 1);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..drive(_tween);

    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInQuart);

    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward(); //启动动画
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          // 判断是否登录
          bool checkLogin = _checkLogin();
          // 跳转到首页，不做强制登录
          if(!checkLogin){
            Get.offAndToNamed(Routes.login);
          }else{
            Get.offAndToNamed(Routes.root);
          }

        });
      }
    });
  }

  _permission() async {
    // 有些权限Android ios 不同需要单独申请
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.photos].request();

    PermissionStatus tempStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted) {
        tempStatus = value;
        return;
      }
    });
    if (tempStatus != PermissionStatus.granted) {
      await openAppSettings();
    }
  }

  bool _checkLogin(){
    bool loginFlag = false;
    AnyEntity? anyEntity =IsarHelper.instance.isarInstance
        .anyEntitys.filter().keyNameEqualTo(Keys.token).findFirstSync();
    if(anyEntity !=null ){
      // TODO 发送token到服务器校验，过期跳转到登录页
      return true;
    }
    return loginFlag;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// logo
              _buildLogo(),

              /// 标题
              _buildTitle(),

              /// 描述
              _buildDesc(),
            ],
          ),
        ),
      ),
    );
  }

  _buildLogo() {
    return ScaleTransition(
      scale: _animation,
      child: Image.asset(
        R.images.logo,
      ),
    );
  }

  _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Text(
        '午后音乐app',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: R.fonts.fuHuiTi,
        ),
      ),
    );
  }

  _buildDesc() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        '您的flutter音乐管家',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontFamily: R.fonts.guFengLiShu,
        ),
      ),
    );
  }
}
