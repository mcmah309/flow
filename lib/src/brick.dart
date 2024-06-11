part of 'rivulet.dart';


abstract class Brick<State> {
  late State _state;
  late final _BrickConcurrency<State> _brickConcurrency;
  Set<Element> _listeners = {};

  Brick() {
    _brickConcurrency = switch (concurrency) {
      BrickConcurrency.sequential => _BrickConcurrencySequential<State>(),
      BrickConcurrency.concurrent => _BrickConcurrencyConcurrent<State>(),
      BrickConcurrency.droppable => _BrickConcurrencyDroppable<State>(),
    };
  }

  /// If false, this bloc will only dispose if when the associated [RivuletScope] is disposed. If true, this bloc will also
  /// dispose when there are zero watchers of this bloc.
  @visibleForOverriding
  bool get autoDispose => true;

  /// Creates the initial state of this [Brick]
  @visibleForOverriding
  Future<State> initState(SafeBuildContext context);

  @visibleForOverriding
  BrickConcurrency get concurrency => BrickConcurrency.sequential;

  /// Called when this [Brick] is disposed.
  @visibleForOverriding
  void dispose() {}

  @protected
  void handle(FutureOr<State> Function(State) handler) async {
    final state = await _brickConcurrency.execute(() async => handler(_state));
    
  }

  void _registerListener(Element element){
    _listeners.add(element);
  }
}