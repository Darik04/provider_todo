class Todo{
  final String docId;
  final String title;
  final String descriptions;
  final int status;
  final String author;

  Todo({this.docId, this.title, this.descriptions, this.status, this.author});

 factory Todo.fromJson(Map<String,dynamic> json){
    return Todo(
        title:  json['user_id'],
        descriptions: json['name'],
        status: json['email'],
        author: json['author']
    );
  }
}