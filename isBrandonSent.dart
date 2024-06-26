import './cell.dart';
import 'randomNumber.dart';
import 'setSimulation.dart';

/**
 * fonction isBrandonSent 
 * détermine si une case dans l'état chaud et brûlé envoie un brandon
 * @param cell la cellule dans l'état chaud et brûlé
 * @return un booléen
 */

bool isBrandonSent(Cell cell, Wind wind ) {
  // dépend uniquement de la force du vent : proba d'envoi d'un brandon = 0.005*(1+force du vent)
  // on a adapté l'énoncé par manque de temps

  switch (wind) {
    case Wind.none:
      return randomNumber(0, 100) <= 20;
    case Wind.moderate:
      return randomNumber(0, 100) <= 30;
    case Wind.strong:
      return randomNumber(0, 100) <= 50;
    case Wind.violent:
      return randomNumber(0, 100) <= 70;
    default:
      throw ArgumentError('Vent non valide');
  }
}