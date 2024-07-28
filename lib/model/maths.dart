import 'dart:math';

class MathProblem {
  final int a;
  final int b;
  MathProblem(this.a, this.b);
  int get answer => a + b;

  factory MathProblem.generate() {
    final Random random = Random();
    int a = random.nextInt(90) + 10;
    int b = random.nextInt(90) + 10;

    return MathProblem(a, b);
  }

  @override
  String toString() {
    '$a + $b =?';
    return super.toString();
  }
}
