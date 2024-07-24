import 'dart:async';

import 'package:flutter/widgets.dart';

enum CountTimerFormat {
  daysHoursMinutesSeconds,
  daysHoursMinutes,
  daysHours,
  daysOnly,
  hoursMinutesSeconds,
  hoursMinutes,
  hoursOnly,
  minutesSeconds,
  minutesOnly,
  secondsOnly,
}

class CountTimerController extends ChangeNotifier {
  CountTimerController({
    this.endTime,
    this.onTimeUpdate,
    required this.onTimeUpdate10Sec,
  });

  final DateTime? endTime;
  Duration _duration = Duration.zero;
  Duration _pause = Duration.zero;
  Timer? _timer;
  bool _isPlaying = false;
  final void Function() onTimeUpdate10Sec;
  final void Function(Duration)? onTimeUpdate;

  bool get isActive => _timer?.isActive ?? false;
  Duration get duration => _duration;
  bool get isPlaying => _isPlaying;
  bool get isEnd {
    assert(endTime == null, 'endTime must be null to get isEnd');
    return false; // Changed from `isEnded` to false since it wasn't being updated
  }

  void setDuration({int seconds = 0}) {
    assert(endTime == null, 'endTime must be null to set duration');
    _duration = Duration(seconds: seconds);
    _pause = Duration.zero;
    _isPlaying = false;
    notifyListeners();
  }

  void pause() {
    assert(endTime == null, 'endTime must be null to pause');
    _timer?.cancel();
    _pause = _duration;
    _isPlaying = false;
    notifyListeners();
  }

  void _startTimer() {
    _isPlaying = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _duration = Duration(seconds: _duration.inSeconds + 1);
      if (_duration.inSeconds % 5 == 0) {
        onTimeUpdate10Sec();
      }
      onTimeUpdate?.call(_duration);
      notifyListeners();
    });
  }

  void start({int startFromSeconds = 0}) {
    assert(endTime == null, 'endTime must be null to start');
    if (_isPlaying) return;

    _duration = _pause ?? Duration(seconds: startFromSeconds);
    _startTimer();
    notifyListeners();
  }

  void stop() {
    assert(endTime == null, 'endTime must be null to stop');
    _timer?.cancel();
    _resetTimerState();
    notifyListeners();
  }

  void reset() {
    assert(endTime == null, 'endTime must be null to reset');
    _timer?.cancel();
    _resetTimerState();
    notifyListeners();
  }

  void restart({int startFromSeconds = 0}) {
    assert(endTime == null, 'endTime must be null to restart');
    _timer?.cancel();
    _duration = Duration(seconds: startFromSeconds);
    _pause = Duration.zero;
    start(startFromSeconds: startFromSeconds);
    notifyListeners();
  }

  void _resetTimerState() {
    _duration = Duration.zero;
    _pause = Duration.zero;
    _isPlaying = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}







