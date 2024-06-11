part of 'rivulet.dart';

extension BuildContextExtension on BuildContext {
  State watch<State, T extends Brick<State>>([Object? key]) {
    final rivuletScope = dependOnInheritedWidgetOfExactType<RivuletScope>();
    if(rivuletScope == null){
      throw Exception();//todo
    }
    return rivuletScope.watch<State, T>(this);
  }

  State read<State, T extends Brick<State>>([Object? key]) {

  }

  void listen<State, T extends Brick<State>>(void Function(T) on, [Object? key]) {

  }
}

/// A [BuildContext] wrapper for safe
extension type SafeBuildContext._(BuildContext buildContext) implements BuildContext {
  SafeBuildContext(this.buildContext);

  T watch<T extends Brick>([Object? key]) {
    // todo register this to rebuild when
  }
}