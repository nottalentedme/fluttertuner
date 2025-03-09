//Описание событий, таких как выбор нового строя или изменение частоты.
abstract class GuitarTuningEvent {}

class ChangeTuningEvents extends GuitarTuningEvent {
  final int index;
  ChangeTuningEvents(this.index);
}
