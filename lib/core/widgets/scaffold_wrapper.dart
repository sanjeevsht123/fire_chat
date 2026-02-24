import 'dart:ui' as ui; // For FragmentProgram and FragmentShader
import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool withFadeAnimation; // For smooth body fade

  const ScaffoldWrapper({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.withFadeAnimation = true,
  });

  @override
  State<ScaffoldWrapper> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ui.FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60), // Long duration for slow loop
    )..repeat(); // Animate smoothly forever (or forward() for one-time)

    // Load shader asynchronously
    _loadShader();
  }

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset('shaders/gradient_flow.frag');
    setState(() {
      _shader = program.fragmentShader();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget background;
    if (_shader == null) {
      // Fallback while loading (simple blue gradient)
      background = Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan.shade50, Colors.blue, Colors.black, Colors.blue, Colors.blueAccent],
          ),
        ),
      );
    } else {
      // Animated shader background
      background = AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _shader!
            ..setFloat(0, size.width)
            ..setFloat(1, size.height)
            ..setFloat(2, _controller.value * 60.0) // iTime (animated)
            ..setFloat(3, 0.0) ..setFloat(4, 1.0) ..setFloat(5, 1.0) // colorPrimary: cyan
            ..setFloat(6, 0.0) ..setFloat(7, 0.5) ..setFloat(8, 1.0) // colorSecondary: medium blue
            ..setFloat(9, 0.0) ..setFloat(10, 0.0) ..setFloat(11, 0.0) // colorAccent1: black-ish for middle
            ..setFloat(12, 0.0) ..setFloat(13, 0.2) ..setFloat(14, 0.8); // colorAccent2: dark blue

          return CustomPaint(
            painter: ShaderPainter(_shader!),
            child: child,
          );
        },
        child: const SizedBox.expand(),
      );
    }

    Widget wrappedBody = Stack(
      children: [
        background,
        SafeArea(
          child: widget.withFadeAnimation
              ? AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: widget.body,
          )
              : widget.body,
        ),
      ],
    );

    return Scaffold(
      appBar: widget.appBar,
      body: wrappedBody,
      bottomNavigationBar: widget.bottomNavigationBar,
      resizeToAvoidBottomInset: true,
    );
  }
}

// Custom painter to apply the shader
class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;

  ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; // Repaint for animation
}