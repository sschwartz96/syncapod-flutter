import 'package:flutter/material.dart';

class PlaybackButton extends StatefulWidget {
  PlaybackButton({this.icon, this.tooltip, this.size, this.onPressed});

  final IconData icon;
  final String tooltip;
  final double size;
  final void Function() onPressed;

  @override
  _PlaybackButtonState createState() => _PlaybackButtonState();
}

class _PlaybackButtonState extends State<PlaybackButton> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTapDown: (tapDetails) {
          setState(() {
            color = Colors.grey;
          });
        },
        onTapUp: (tapDetails) {
          setState(() {
            color = Colors.white;
          });
        },
        onTapCancel: () {
          setState(() {
            color = Colors.white;
          });
        },
        onTap: widget.onPressed,
        child: Container(
          child: Icon(
            widget.icon,
            size: widget.size,
            color: color,
          ),
        ),
      ),
    );
  }
}
