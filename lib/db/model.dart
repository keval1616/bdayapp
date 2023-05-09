class BirthDayModel {
  int? id;
  String? name;
  String? date;
  String? time;
  String? image;

  BirthDayModel({
    this.id,
    this.date,
    this.time,
    this.name,
    this.image,
  });

  BirthDayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    time = json['time'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
