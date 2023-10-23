import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wuhoumusic/views/root/root_controller.dart';

class RootPage extends GetView<RootController> {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.bodyPage[controller.bottomBarIndex.value]),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: controller.barList,
          currentIndex: controller.bottomBarIndex.value,
          onTap: (index) => {controller.changeBottomBarIndex(index)},
        );
      }),
    );
  }
}
