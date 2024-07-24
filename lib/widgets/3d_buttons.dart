import 'package:flutter/material.dart';

enum GradientOrientation { vertical, horizontal }

class Button3d extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final Color borderColor;
  final Color progressColor;
  final double progressSize;
  final GradientOrientation gradientOrientation;
  final double borderThickness;
  final double height;
  final double borderRadius;
  final bool stretch;
  final double width;
  final bool progress;
  final bool disabled;
  final Function onTap;
  final Widget child;

  Button3d({
    Key? key,
    required this.onTap,
    required this.child,
    this.startColor = const Color(0xFF2ec8ff),
    this.endColor = const Color(0xFF529fff),
    this.borderColor = const Color(0xFF3489e9),
    this.progressColor = Colors.white,
    this.progressSize = 20,
    this.borderRadius = 20,
    this.borderThickness = 5,
    this.height = 60,
    this.width = 200,
    this.gradientOrientation = GradientOrientation.vertical,
    this.stretch = true,
    this.progress = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  _Button3dState createState() => _Button3dState();
}

class _Button3dState extends State<Button3d> with TickerProviderStateMixin {
  late double _borderThickness;
  double _moveMargin = 0.0;
  double _progressWidth = 0.0;
  bool _showProgress = false;
  bool _tapped = false;
  bool _processing = false;
  int _progressBarMillis = 2500;

  @override
  void initState() {
    super.initState();
    _borderThickness = widget.borderThickness;
  }

  Widget _buildBackLayout() {
    return Container(
      padding: EdgeInsets.only(top: _borderThickness),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: widget.borderColor,
      ),
    );
  }

  Widget _buildFrontLayout() {
    return AnimatedContainer(
      onEnd: _resetState,
      margin: EdgeInsets.only(top: _moveMargin),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        gradient: LinearGradient(
          begin: widget.gradientOrientation == GradientOrientation.vertical
              ? Alignment.topCenter
              : Alignment.centerLeft,
          end: widget.gradientOrientation == GradientOrientation.vertical
              ? Alignment.bottomCenter
              : Alignment.centerRight,
          colors: [widget.startColor, widget.endColor],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Stack(
          children: [
            _buildProgressBar(),
            if (_showProgress) _buildProgressCircle(),
            if (!_showProgress) _buildUserChild(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return AnimatedSize(
      duration: Duration(milliseconds: _progressBarMillis),
      curve: Curves.fastOutSlowIn,
      child: Container(
        width: _progressWidth,
        height: double.infinity,
        color: const Color.fromARGB(60, 255, 255, 255),
      ),
    );
  }

  Widget _buildProgressCircle() {
    return Center(
      child: SizedBox(
        width: widget.progressSize,
        height: widget.progressSize,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
        ),
      ),
    );
  }

  Widget _buildUserChild() {
    return Center(child: widget.child);
  }

  void _resetState() {
    setState(() {
      _moveMargin = 0;
      if (widget.progress && !_showProgress && _tapped) {
        _showProgress = true;
        _progressWidth = double.infinity;
        _processing = true;
        _progressBarMillis = 2500;
      }
      _tapped = false;
    });
  }

  void _onTap() {
    setState(() {
      _moveMargin = _borderThickness;
      _tapped = true;
    });
    widget.onTap(_finish);
  }

  void _finish() {
    setState(() {
      _showProgress = false;
      _progressWidth = 0;
      _processing = false;
      _progressBarMillis = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disabled || _processing ? null : _onTap,
      child: SizedBox(
        width: widget.stretch ? double.infinity : widget.width,
        height: widget.height,
        child: Stack(
          children: [
            _buildBackLayout(),
            _buildFrontLayout(),
          ],
        ),
      ),
    );
  }
}
