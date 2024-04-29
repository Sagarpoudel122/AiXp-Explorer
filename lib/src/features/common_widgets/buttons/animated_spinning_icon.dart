import 'package:flutter/cupertino.dart';

class AnimatedSpinningIcon extends StatefulWidget {
  const AnimatedSpinningIcon({super.key, this.duration = 5, required this.icon});

  final int duration;
  final Icon icon;

  @override
  State<StatefulWidget> createState() => _AnimatedSpinningIconState();
}

class _AnimatedSpinningIconState extends State<AnimatedSpinningIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: widget.duration), vsync: this)..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.icon,
    );
  }
}
