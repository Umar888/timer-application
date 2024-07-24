
import 'package:flutter/material.dart';

class TimerColumn extends StatelessWidget {
  const TimerColumn({
    super.key,
    required this.value,
    this.timeTextStyle,
    this.descriptionTextStyle,
    this.enableDescriptions = true,
    this.description,
  }) : assert(enableDescriptions != true || description != null,
  'description must not be null when enableDescriptions is true');
  final String value;
  final TextStyle? timeTextStyle;
  final String? description;
  final TextStyle? descriptionTextStyle;
  final bool enableDescriptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: timeTextStyle,
        ),
        if (enableDescriptions)
          Text(
            "$description",
            style: descriptionTextStyle,
          ),
      ],
    );
  }
}