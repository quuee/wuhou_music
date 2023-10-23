import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  /// 搞一个动画
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

    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInQuart);

    Future.delayed(const Duration(milliseconds: 300),(){
      _animationController.forward();//启动动画
    });

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Future.delayed(const Duration(milliseconds: 300),(){
          /// 跳转到首页，不做强制登录
          Get.offAndToNamed(Routes.login);
        });
      }
    });
  }

  _permission() async {
    var permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {

    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
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
