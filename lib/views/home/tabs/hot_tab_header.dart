import 'package:flutter/material.dart';

class HotTabHeader extends StatefulWidget {
  const HotTabHeader(this.text, this.onTap);

  final String text;
  final GestureTapCallback onTap;

  @override
  State<HotTabHeader> createState() => _HotTabHeaderState();
}

class _HotTabHeaderState extends State<HotTabHeader> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(left: 8)),
          Text(
            widget.text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w800,fontSize: 16),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
