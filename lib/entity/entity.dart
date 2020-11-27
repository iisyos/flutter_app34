class Cards {
  int id;
  String card_name;
  String en_card_name;
  bool blue;
  bool red;
  bool flagg;
  bool is_done;
  bool refresh;
  bool purple;
  bool orange;

  Cards({this.id, this.card_name,this.en_card_name,
    this.is_done = false,this.red=false,this.orange=false,this.purple=false,this.blue=false,this.flagg=false,this.refresh=false});

  factory Cards.fromDatabaseJson(Map<String, dynamic> data) => Cards(
    id: data['id'],
    card_name: data['card_name'],
    en_card_name:data["en_card_name"],
    is_done: data['is_done'] == 1 ? true : false,
    blue: data["blue"]==1? true :false,
    red: data["red"]==1? true :false,
    flagg: data["flagg"]==1? true :false,
    purple: data["purple"]==1? true :false,
    orange: data["orange"]==1? true :false,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "card_name": this.card_name,
    "en_card_name":this.en_card_name,
    "is_done": this.is_done ? 1 : 0,
    "blue": this.blue ? 1 : 0,
    "red": this.red ? 1 : 0,
    "purple": this.purple ? 1 : 0,
    "orange": this.orange ? 1 : 0,
    "flagg": this.flagg ? 1 : 0,
  };
}