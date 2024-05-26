import 'package:test/test.dart';
import '../setSimulation.dart';

bool willInflammeAfterReceivingBrandon_test(Climat climat, int random) {
  switch (climat) {
    case Climat.humid:
      return random <= 10;
    case Climat.normal:
      return random <= 30;
    case Climat.dry:
      return random <= 60;
    case Climat.veryDry:
      return random <= 90;
    default:
      throw ArgumentError('Climat non valide');
  }
}

void main() {
  test('willInflammeAfterReceivingBrandon retourne un résultat cohérent avec l\'énoncé', () {
    int random = 42;
    expect(willInflammeAfterReceivingBrandon_test(Climat.humid, random), equals(false));
    expect(willInflammeAfterReceivingBrandon_test(Climat.normal, random), equals(true));
    expect(willInflammeAfterReceivingBrandon_test(Climat.dry, random), equals(true));
    expect(willInflammeAfterReceivingBrandon_test(Climat.veryDry, random), equals(true));
  });
}
