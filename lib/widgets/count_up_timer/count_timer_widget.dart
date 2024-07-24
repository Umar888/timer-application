import 'package:flutter/material.dart';

import 'count_timer.dart';
import 'timer_column.dart';

class CountTimer extends StatefulWidget {
  final CountTimerFormat format;
  final VoidCallback? onEnd;
  final bool enableDescriptions;
  final TextStyle? timeTextStyle;
  final TextStyle? colonsTextStyle;
  final TextStyle? descriptionTextStyle;
  final String daysDescription;
  final String hoursDescription;
  final String minutesDescription;
  final String secondsDescription;
  final double spacerWidth;
  final CountTimerController controller;

  const CountTimer({
    super.key,
    this.format = CountTimerFormat.daysHoursMinutesSeconds,
    this.onEnd,
    this.enableDescriptions = true,
    this.timeTextStyle,
    this.colonsTextStyle,
    this.descriptionTextStyle,
    this.daysDescription = "Days",
    this.hoursDescription = "Hours",
    this.minutesDescription = "Minutes",
    this.secondsDescription = "Seconds",
    this.spacerWidth = 10,
    required this.controller,
  });

  @override
  State<CountTimer> createState() => _CountTimerState();
}

class _CountTimerState extends State<CountTimer> {
  late String countdownDays;
  late String countdownHours;
  late String countdownMinutes;
  late String countdownSeconds;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    widget.controller.addListener(_updateCountdown);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateCountdown);
    super.dispose();
  }

  void _updateCountdown() {
    if (mounted) {
      setState(() {
        final difference = widget.controller.duration;
        countdownDays = _formatTime(difference.inDays, "days");
        countdownHours = _formatTime(difference.inHours.remainder(24), "hours");
        countdownMinutes = _formatTime(difference.inMinutes.remainder(60), "minutes");
        countdownSeconds = _formatTime(difference.inSeconds.remainder(60), "seconds");
      });

      if (widget.controller.isEnd) {
        widget.onEnd?.call();
      }
    }
  }

  String _formatTime(int value, String unitType) {
    final needsIncrement = widget.format == CountTimerFormat.daysHoursMinutes && unitType == "minutes" ||
        widget.format == CountTimerFormat.hoursMinutes && unitType == "hours";

    if (needsIncrement && widget.controller.duration > Duration.zero) {
      value++;
    }

    return value.toString().padLeft(2, '0');
  }

  Widget _colon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.spacerWidth),
      child: TimerColumn(
        value: ':',
        timeTextStyle: widget.colonsTextStyle,
        description: '',
        descriptionTextStyle: widget.descriptionTextStyle,
        enableDescriptions: widget.enableDescriptions,
      ),
    );
  }

  Widget _timeColumn(String value, String description) => TimerColumn(
    value: value,
    description: description,
    descriptionTextStyle: widget.descriptionTextStyle,
    timeTextStyle: widget.timeTextStyle,
    enableDescriptions: widget.enableDescriptions,
  );

  @override
  Widget build(BuildContext context) {
    return _buildTimerFormat();
  }

  Widget _buildTimerFormat() {
    switch (widget.format) {
      case CountTimerFormat.daysHoursMinutesSeconds:
        return _buildRow([countdownDays, countdownHours, countdownMinutes, countdownSeconds], [
          widget.daysDescription,
          widget.hoursDescription,
          widget.minutesDescription,
          widget.secondsDescription
        ]);
      case CountTimerFormat.daysHoursMinutes:
        return _buildRow([countdownDays, countdownHours, countdownMinutes], [
          widget.daysDescription,
          widget.hoursDescription,
          widget.minutesDescription
        ]);
      case CountTimerFormat.daysHours:
        return _buildRow([countdownDays, countdownHours], [widget.daysDescription, widget.hoursDescription]);
      case CountTimerFormat.daysOnly:
        return _buildRow([countdownDays], [widget.daysDescription]);
      case CountTimerFormat.hoursMinutesSeconds:
        return _buildRow([countdownHours, countdownMinutes, countdownSeconds], [
          widget.hoursDescription,
          widget.minutesDescription,
          widget.secondsDescription
        ]);
      case CountTimerFormat.hoursMinutes:
        return _buildRow([countdownHours, countdownMinutes], [widget.hoursDescription, widget.minutesDescription]);
      case CountTimerFormat.hoursOnly:
        return _buildRow([countdownHours], [widget.hoursDescription]);
      case CountTimerFormat.minutesSeconds:
        return _buildRow([countdownMinutes, countdownSeconds], [widget.minutesDescription, widget.secondsDescription]);
      case CountTimerFormat.minutesOnly:
        return _buildRow([countdownMinutes], [widget.minutesDescription]);
      case CountTimerFormat.secondsOnly:
        return _buildRow([countdownSeconds], [widget.secondsDescription]);
    }
  }

  Widget _buildRow(List<String> values, List<String> descriptions) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(values.length * 2 - 1, (index) {
        return index.isEven
            ? _timeColumn(values[index ~/ 2], descriptions[index ~/ 2])
            : _colon();
      }),
    );
  }
}
