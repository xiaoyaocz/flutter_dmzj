import 'dart:convert' show json;

class ComicDownloadModel {
  List<int> _id;
  List<int> get id => _id;
  List<String> _coverUrl;
  List<String> get coverUrl => _coverUrl;
  List<String> _title;
  List<String> get title => _title;

  ComicDownloadModel(
      {List<int> id, List<String> coverUrl, List<String> title}) {
    this._id = id;
    this._coverUrl = coverUrl;
    this._title = title;
  }

  factory ComicDownloadModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<int> id = jsonRes['id'] is List ? [] : null;
    if (id != null) {
      for (var item in jsonRes['id']) {
        if (item != null) {
          id.add(int.parse(item));
        }
      }
    }

    List<String> coverUrl = jsonRes['coverUrl'] is List ? [] : null;
    if (coverUrl != null) {
      for (var item in jsonRes['coverUrl']) {
        if (item != null) {
          coverUrl.add(item);
        }
      }
    }

    List<String> title = jsonRes['title'] is List ? [] : null;
    if (title != null) {
      for (var item in jsonRes['title']) {
        if (item != null) {
          id.add(item);
        }
      }
    }

    return ComicDownloadModel(
      id: id,
      coverUrl: coverUrl,
      title: title,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'coverUrl': _coverUrl,
        'title': _title,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
