import 'package:flutter/cupertino.dart';

class ImageButton extends StatelessWidget {

  final GestureTapDownCallback? onTapDown;
  final String imagePath;
  final double size;

  const ImageButton(this.imagePath, {super.key, this.onTapDown, this.size = 75});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: SizedBox(
        height: size,
        child: Image.asset(imagePath),
      ),
    );
  }
}
