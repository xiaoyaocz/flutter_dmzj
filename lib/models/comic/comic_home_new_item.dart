import 'dart:convert' show json;

class ComicHomeNewItem {
  int id;
  String title;
  String authors;
  String status;
  String cover;
  int get type => 1;
  String get url => "";
  ComicHomeNewItem({
    this.id,
    this.title,
    this.authors,
    this.status,
    this.cover,
  });

  factory ComicHomeNewItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicHomeNewItem(
          id: jsonRes['id'],
          title: jsonRes['title'],
          authors: jsonRes['authors'],
          status: jsonRes['status'],
          cover: jsonRes['cover'],
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'authors': authors,
        'status': status,
        'cover': cover,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
