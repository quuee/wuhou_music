
import 'package:flutter/material.dart';

class HotTab extends StatelessWidget {
  const HotTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(child: Text("refresh"), onPressed: () {

        }),
      ],
    );
  }
}
