import 'package:flutter/material.dart';

class SidebarDpad extends StatefulWidget {
  const SidebarDpad({
    Key key,
    this.onTap,
    this.onFocus,
    this.child,
    this.onLongPress,
  }) : super(key: key);
  final Widget child;
  final Function onTap;
  final Function onFocus;
  final Function onLongPress;
  @override
  _SidebarDpadState createState() => _SidebarDpadState();
}

class _SidebarDpadState extends State<SidebarDpad>
    with SingleTickerProviderStateMixin {
  FocusNode node;
  AnimationController controller;
  Animation<double> animation;
  int focusAlpha = 100;

  Widget image;

  @override
  void initState() {
    node = FocusNode();

    node.addListener(onFocusChange);
    controller = AnimationController(
         duration: const Duration(milliseconds: 10),
        vsync: this,
        lowerBound: 0.9,
        upperBound: 1);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  void onFocusChange() {
    if (node.hasFocus) {
      controller.forward();
      setState(() => _ami = !_ami);

      if (widget.onFocus != null) {
        widget.onFocus();
      }
    } else {
      controller.reverse();
      setState(() => _ami = false);
    }
  }

  bool _ami = false;

  void onTap() {
    node.requestFocus();
    if (widget.onTap != null) {
      widget.onTap();
    }
  }

  void onLongPress() {
    node.requestFocus();
    if (widget.onLongPress != null) {
      widget.onLongPress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      hoverColor: Colors.black,
      onLongPress: onLongPress,
      onPressed: onTap,
      focusNode: node,
      focusColor: Colors.transparent,
      focusElevation: 0,
      child: buildCover(context),
    );
  }

  Widget buildCover(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            height: 56,
            width: 132,
            child: Container(
              decoration: _ami
                  ? BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.redAccent[700],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)))
                  : BoxDecoration(
                      border: Border.all(width: 0, color: Colors.transparent),
                    ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

//!//!//!//!//!//!
