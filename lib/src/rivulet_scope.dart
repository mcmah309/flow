part of 'rivulet.dart';

class RivuletScope extends InheritedWidget {

  /// If null, all encountered [Brick]s are restricted to this scope.
  final RivuletScopeBehavior? scopeBehavior;

  RivuletScope({super.key, this.scopeBehavior, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  State watch<State, T extends Brick<State>>(BuildContext context){
    brick
  }

  State read<State, T extends Brick<State>>([Object? key]) {

  }

  void listen<State, T extends Brick<State>>(void Function(T) on, [Object? key]) {

  }
}


sealed class RivuletScopeBehavior {

  bool useThisScope(Type brick);
}

/// Only the listed [Brick] types will be allowed to pass through to an ancestor [RivuletScope].
/// All other [Brick]s will be created in this scope. If the attached [RivuletScope] is the only one in the tree,
/// this essentially has no effect.
/// Use this when you have multiple [RivuletScope]s and want to have all [Brick]s created in this scope besides a select few.
class WhiteListScopeBehavior implements RivuletScopeBehavior {
final Set<Type> _whiteList;

  WhiteListScopeBehavior(this._whiteList);
  
  @override
  bool useThisScope(Type brickType) {
    return !_whiteList.contains(brickType);
  }
}

/// All [Brick]s, besides the ones listed, will be allowed to pass through to an ancestor [RivuletScope].
/// Only the listed [Brick]s will be created in this scope. If the attached [RivuletScope] is the only one in the tree,
/// this essentially has no effect.
/// Use this when you have multiple [RivuletScope]s and want to have all [Brick]s created in an ancestor scope besides a select few.
class BlackListScopeBehavior implements RivuletScopeBehavior {
  final Set<Type> _blackList;

  BlackListScopeBehavior(this._blackList);

  @override
  bool useThisScope(Type brickType) {
    return _blackList.contains(brickType);
  }
}
