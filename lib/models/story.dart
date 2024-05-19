class Story {
  String? by;
  int? descendants;
  int? id;
  List<dynamic>? kids;
  int? score;
  int? time;
  String? title;
  String? type;
  String? url;
  String? text;
  Story(
      {this.by,
      this.descendants,
      this.id,
      this.kids,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url,
      this.text});

  Story.fromJson(Map<String, dynamic> json) {
    by = json['by'] ?? "";
    descendants = json['descendants'] ?? 0;
    id = json['id'] ?? 0;
    kids = json['kids'] ?? [];
    score = json['score'] ?? 0;
    time = json['time'] ?? 0;
    title = json['title'] ?? "";
    type = json['type'] ?? "";
    url = json['url'] ?? "";
    text = json['text'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['kids'] = this.kids;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}
