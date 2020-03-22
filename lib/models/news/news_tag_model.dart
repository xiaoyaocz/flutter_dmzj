import 'dart:convert' show json;

class NewsTagItemModel {
  int tag_id;
  String tag_name;

    NewsTagItemModel({
this.tag_id,
this.tag_name,
    });


  factory NewsTagItemModel.fromJson(jsonRes)=>jsonRes == null? null:NewsTagItemModel(    tag_id : jsonRes['tag_id'],
    tag_name : jsonRes['tag_name'],
);
  Map<String, dynamic> toJson() => {
        'tag_id': tag_id,
        'tag_name': tag_name,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

