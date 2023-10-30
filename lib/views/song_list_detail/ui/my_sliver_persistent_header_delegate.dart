
import 'dart:math';

import 'package:flutter/material.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  double minHeight; //最小高度
  double maxHeight; //最大高度
  Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // return maxHeight != oldDelegate.maxHeight ||
    //     minHeight != oldDelegate.minHeight ||
    //     child != oldDelegate.child;
    return true;
  }
  
  
}