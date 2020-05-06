import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final Color color;
  final Color inactiveColor;
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.inactiveColor,
    @required this.color,
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    // Somehow our position can be a hair larger than 0
    double max = widget.duration.inMilliseconds.toDouble();
    if (max < 0.0) max = 0;

    double value = (_dragValue ?? widget.position.inMilliseconds.toDouble());
    if (value > widget.duration.inMilliseconds.toDouble() || value < 0.0) {
      value = 0.0;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Slider(
              activeColor: widget.color,
              inactiveColor: widget.inactiveColor,
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: value,
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                _dragValue = null;

                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd(Duration(milliseconds: value.round()));
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 27, right: 27),
          child: Row(
            children: <Widget>[
              _posText(),
              Spacer(),
              Text('${_printDuration(widget.duration)}',
                  style: TextStyle(color: Colors.grey.shade300)),
            ],
          ),
        ),
      ],
    );
  }

  Text _posText() {
    Duration val = widget.position;
    if (_dragValue != null) val = Duration(milliseconds: _dragValue.round());
    return Text('${_printDuration(val)}',
        style: TextStyle(color: Colors.grey.shade300));
  }

  String _printDuration(Duration d) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
