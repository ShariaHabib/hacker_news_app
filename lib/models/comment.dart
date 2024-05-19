class Comment {
  String? by;
  int? id;
  List<int>? kids;
  int? parent;
  String? text;
  int? time;
  String? type;
  bool? deleted;

  Comment({
    this.by,
    this.id,
    this.kids,
    this.parent,
    this.text,
    this.time,
    this.type,
    this.deleted,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    id = json['id'];
    kids = json['kids'].cast<int>();
    parent = json['parent'];
    text = json['text'];
    time = json['time'];
    type = json['type'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['id'] = this.id;
    data['kids'] = this.kids;
    data['parent'] = this.parent;
    data['text'] = this.text;
    data['time'] = this.time;
    data['type'] = this.type;
    data['deleted'] = this.deleted;
    return data;
  }
}
