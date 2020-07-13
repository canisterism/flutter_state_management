import 'dart:async';
import 'dart:math';

class FlashNumberBloc {
  final _calculateController = StreamController<int>();
  final _outputController = StreamController<String>();
  final _startController = StreamController<Null>();
  final _buttonController = StreamController<bool>();

  // for input
  StreamSink<void> get start => _startController.sink;

  // for output
  Stream<String> get onAdd => _outputController.stream;
  Stream<bool> get onToggle => _buttonController.stream;

  static const _repeat = 20;
  int _sum;
  Timer _timer;

  FlashNumberBloc() {
    _startController.stream.listen((_) => _start());
    _calculateController.stream.listen((count) => _calculate(count));
    _buttonController.sink.add(true);
  }

  void _start() {
    _sum = 0;
    _outputController.sink.add('');
    _buttonController.sink.add(false);

    _timer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      _calculateController.sink.add(timer.tick);
    });
  }

  void _calculate(int count) {
    if (count < _repeat + 1) {
      final number = Random().nextInt(99) + 1;
      _outputController.sink.add('$number');
      _sum += number;
    } else {
      _timer.cancel();
      _outputController.sink.add('The sum is $_sum');
      _buttonController.sink.add(true);
    }
  }

  void dispose() {
    _calculateController.close();
    _outputController.close();
    _startController.close();
    _buttonController.close();
  }
}
