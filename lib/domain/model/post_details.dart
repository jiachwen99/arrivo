class PostDetails {
  int userId;
  int id;
  String title;
  String body;

  PostDetails({this.userId = 0, this.id = 0, this.title = "", this.body = ""});

  PostDetails.fromJson(Map<String, dynamic> json) :
    userId = json['userId'] ?? 0,
    id = json['id'] ?? 0,
    title = json['title'] ?? "",
    body = json['body'] ?? "";
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
