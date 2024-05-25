import 'dart:math';

/**
 * function randomNumber
 * retourne un nombre aléatoire entre nim et max
 * @param min le nombre minimum choisi
 * @param max le nombre maximum choisi
 * @return un entier
 */
int randomNumber(int min, int max) {
    return min + Random().nextInt(max - min);
}