import 'package:flutter/material.dart';

class PinchToZoom extends StatefulWidget {
  final Widget child;
  final VoidCallback? onZoomStart;
  final VoidCallback? onZoomEnd;

  const PinchToZoom({
    super.key,
    required this.child,
    this.onZoomStart,
    this.onZoomEnd,
  });

  @override
  State<PinchToZoom> createState() => _PinchToZoomState();
}

class _PinchToZoomState extends State<PinchToZoom> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  
  Matrix4 _matrix = Matrix4.identity();
  Offset _translation = Offset.zero;
  double _scale = 1.0;
  bool _isZooming = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        if (_animation != null) {
          setState(() {
            _matrix = _animation!.value;
          });
          _overlayEntry?.markNeedsBuild();
        }
      });
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final double currentScale = _matrix.getMaxScaleOnAxis();
        final double opacity = ((currentScale - 1.0) / 2.0).clamp(0.0, 0.7);
        
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              IgnorePointer(
                child: Container(color: Colors.black.withOpacity(opacity)),
              ),
              Positioned(
                left: offset.dx,
                top: offset.dy,
                width: size.width,
                height: size.height,
                child: IgnorePointer(
                  child: Transform(
                    transform: _matrix,
                    alignment: Alignment.center,
                    child: widget.child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onScaleStart: (details) {
        if (details.pointerCount >= 2) {
          setState(() {
            _isZooming = true;
            _scale = 1.0;
            _translation = Offset.zero;
            _matrix = Matrix4.identity();
          });
          widget.onZoomStart?.call();
          _showOverlay();
        }
      },
      onScaleUpdate: (details) {
        if (!_isZooming) return;
        setState(() {
          _scale = details.scale;
          _translation += details.focalPointDelta;
          
          _matrix = Matrix4.identity()
            ..translate(_translation.dx, _translation.dy)
            ..scale(_scale);
        });
        _overlayEntry?.markNeedsBuild();
      },
      onScaleEnd: (details) {
        if (!_isZooming) return;
        
        _animation = Matrix4Tween(
          begin: _matrix,
          end: Matrix4.identity(),
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

        _animationController.forward(from: 0).then((_) {
          _removeOverlay();
          if (mounted) {
            setState(() {
              _isZooming = false;
              _matrix = Matrix4.identity();
              _scale = 1.0;
              _translation = Offset.zero;
            });
          }
          widget.onZoomEnd?.call();
        });
      },
      child: Opacity(
        opacity: _isZooming ? 0 : 1,
        child: widget.child,
      ),
    );
  }
}
