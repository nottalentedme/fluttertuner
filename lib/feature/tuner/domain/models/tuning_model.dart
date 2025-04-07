enum TuningModel {
  standart(["E2", "А2", "D3", "G3", "B3", "E4"]),
  dropD(["D2", "А2", "D3", "G3", "B3", "E4"]),
  openG(["D2", "G2", "D3", "G3", "B3", "E4"]),
  dadgad(["D2", "А2", "D3", "G3", "A3", "D4"]);

  final List<String> notes;
  const TuningModel(this.notes);
}
