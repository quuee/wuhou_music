import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  late LoginController loginController;

  static const Color loginGradientStart = Colors.cyanAccent;
  static const Color loginGradientEnd = Colors.deepPurple;

  late TabController tabController;

  final _formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _seconds = 60;
  String verifyStr = '获取验证码';
  bool sendMessageEnable = true;

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer!.cancel();
  }

  _sendMessage() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        setState(() {
          _seconds = 60;
          verifyStr = '重新发送';
          sendMessageEnable = true;
        });
        return;
      }
      setState(() {
        _seconds--;
        verifyStr = '已发送$_seconds' + 's';
        sendMessageEnable = false;
      });
    });
  }

  @override
  void initState() {
    loginController = Get.find<LoginController>();
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool isPhoneLogin = false;

  _buildTitleAndSkip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 45, 0, 0),
          child: Text(
            '登录',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: R.fonts.puHuiTiX,
                color: Colors.white),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_timer != null) {
              _cancelTimer();
            }
            Get.offAllNamed(Routes.root,arguments: 0);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 45, 30, 0),
            child: Text(
              '跳过',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            decoration: BoxDecoration(
              color: Colors.white60,
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        )
      ],
    );
  }

  _buildChooseMenuBar() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: TabBar(
          // isScrollable: true,
          dividerColor: Colors.transparent,
          controller: tabController,
          tabs: [
            TextButton(
                onPressed: () {
                  tabController.index = 0;
                  setState(() {});
                },
                child: Text(
                  '账户登录',
                )),
            TextButton(
                onPressed: () {
                  tabController.index = 1;
                  setState(() {});
                },
                child: Text(
                  '手机登录',
                )),
          ],
        ));
  }

  _buildTabView() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 5, 12, 0),
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: TabBarView(controller: tabController, children: [
            _buildAccountLogin(),
            _buildPhoneLogin(),
          ]),
        ),
      ),
    );
  }

  /// 账户密码登录
  _buildAccountLogin() {
    ///输入框
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autofocus: false,
            controller: loginController.accountCtro,
            decoration: InputDecoration(
                labelText: "用户名",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "用户名或邮箱",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.person)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            height: 1,
            color: Colors.grey[600],
          ),
          TextFormField(
            controller: loginController.passwdCtro,
            decoration: InputDecoration(
                labelText: "密码",
                labelStyle: TextStyle(color: Colors.black54),
                hintText: "登录密码",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock)),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            height: 1,
            color: Colors.grey[600],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              // boxShadow: [
              //   BoxShadow(
              //       color: loginGradientStart,
              //       offset: Offset(1.0, 6.0),
              //       blurRadius: 20.0),
              //   BoxShadow(
              //       color: loginGradientEnd,
              //       offset: Offset(1.0, 6.0),
              //       blurRadius: 20.0),
              // ],
              gradient: LinearGradient(
                colors: [loginGradientStart, loginGradientEnd],
                begin: const FractionalOffset(0.2, 0.2),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: loginGradientEnd,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  '登录',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('登录成功')),
                  // );
                  // controller.accountLogin();
                  Fluttertoast.showToast(msg: '待实现');
                }
              },
            ),
          )
        ],
      ),
    );
  }

  /// 手机登录
  _buildPhoneLogin() {
    return Column(
      children: [
        TextFormField(
          inputFormatters: [LengthLimitingTextInputFormatter(11)],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          autofocus: false,
          controller: loginController.phonedCtro,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: '请输入手机号',
              labelStyle: TextStyle(color: Colors.black54),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
              prefixText: '+86',
              prefixIcon: Icon(Icons.phone_android)),
        ),
        Container(
          height: 1,
          color: Colors.grey[600],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              //大坑，row不能直接包括TextField控件，需要用Expanded包裹一下
              child: TextFormField(
                controller: loginController.validCodeCtro,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '验证码',
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (sendMessageEnable) {
                  _sendMessage();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                  ),
                ),
                child: Text(
                  verifyStr,
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          color: Colors.grey[600],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            // boxShadow: [
            //   BoxShadow(
            //       color: loginGradientStart,
            //       offset: Offset(1.0, 6.0),
            //       blurRadius: 20.0),
            //   BoxShadow(
            //       color: loginGradientEnd,
            //       offset: Offset(1.0, 6.0),
            //       blurRadius: 20.0),
            // ],
            gradient: LinearGradient(
              colors: [loginGradientStart, loginGradientEnd],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: loginGradientEnd,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                '登录',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  /// 第三方登录
  _buildOtherLogin() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              child: Text(
                '忘记密码',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
            ),
          ),

          /// 分割线
          Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [Colors.white10, Colors.white],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text('or',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        // fontFamily: 'WorkSansMedium',
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [Colors.white, Colors.white10],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),

          /// todo 微信 qq图标
          Row(
            children: [],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //解决键盘顶起页面
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [loginGradientStart, loginGradientEnd],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(flex: 4, child: _buildTitleAndSkip()),
              Expanded(
                flex: 2,
                child: _buildChooseMenuBar(),
              ),
              Expanded(
                flex: 7,
                child: _buildTabView(),
              ),
              Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(flex: 5, child: _buildOtherLogin()),
            ],
          ),
        ));
  }
}
