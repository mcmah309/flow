import 'package:rivulet/rivulet.dart';

class HomeBrick extends Brick<int> {
  HomeBrick();

  @override
  Future<int> initState(SafeBuildContext context) async {
    return 1;
  }

  void add(int val) {
    handle((state) {
      return state + val;
    });
  }
}

final homeBrick = HomeBrick();