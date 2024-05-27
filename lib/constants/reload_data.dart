import 'dart:async';

class DataReloader {
  late Timer _timer;
  late final Function _reloadFunction;
  late Duration _interval;

  DataReloader(this._reloadFunction,
      {Duration interval = const Duration(seconds: 60)}) {
    _interval = interval;
      startReloafing();
  }
  void startReloafing() {
    _timer = Timer.periodic(_interval, (timer) {
      _reloadFunction();
    });
  }

  void stopReloading() {
    _timer.cancel();
  }
}
