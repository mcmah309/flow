
part of 'rivulet.dart';

enum BrickConcurrency {
  sequential,
  concurrent,
  droppable,
}

sealed class _BrickConcurrency<State> {
  /// Applies the [func] based on the concurrency setting.
  Future<State?> execute(Future<State> Function() func);
}

/// Process invocations sequentially.
class _BrickConcurrencySequential<State> implements _BrickConcurrency<State> {
  List<(Future<State> Function(), Completer<State>)> _waitList = [];

  @override
  Future<State> execute(Future<State> Function() func) async {
    final Completer<State> completer = Completer();
    _waitList.add((func, completer));
    if(_waitList.length == 1){
      while(_waitList.isNotEmpty){
        final first = _waitList.removeAt(0);
        final result = first.$1();
        first.$2.complete(result);
      }
    }
    return await completer.future;
  }
}

/// Process invocations Concurrently.
class _BrickConcurrencyConcurrent<State> implements _BrickConcurrency<State> {

  const _BrickConcurrencyConcurrent();

  @override
  Future<State> execute(Future<State> Function() func) async {
    return func();
  }
}

/// Ignore any events added while an event is processing.
class _BrickConcurrencyDroppable<State> implements _BrickConcurrency<State> {
  Future<State>? _current;

  _BrickConcurrencyDroppable();

  @override
  Future<State?> execute(Future<State> Function() func) async {
    if(_current != null){
      return null;
    }
    _current = func();
    final result = await _current;
    _current = null;
    return result;
  }
}