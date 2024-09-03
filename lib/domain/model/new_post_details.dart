class NewPostDetails {
  int userId;
  String title;
  String body;

  NewPostDetails({this.userId = 0, this.title = "", this.body = ""});

  NewPostDetails.fromJson(Map<String, dynamic> json) :
    userId = json['userId'] ?? 0,
    title = json['title'] ?? "",
    body = json['body'] ?? "";
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
