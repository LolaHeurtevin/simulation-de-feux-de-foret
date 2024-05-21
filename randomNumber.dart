import 'dart:math';

int randomNumber(int min, int max) {
    return min + Random().nextInt(max - min);
}