import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

systemUi(context) {
  MediaQuery.of(context).platformBrightness == Brightness.dark
      ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.grey.shade900,
          statusBarIconBrightness: Brightness.light))
      : SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));
}

class ShowUp extends StatefulWidget {
  final Widget? child;
  final int? delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController? _animController;
  Animation<Offset>? _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController!);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController!.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        if (mounted) {
          _animController!.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset!,
        child: widget.child,
      ),
      opacity: _animController!,
    );
  }
}
