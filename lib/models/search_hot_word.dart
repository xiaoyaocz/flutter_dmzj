import 'dart:convert' show json;

class SearchHotWord {
  int _id;
  int get id => _id;
  String _name;
  String get name => _name;

    SearchHotWord({
int id,
String name,
}):_id=id,_name=name;
  factory SearchHotWord.fromJson(jsonRes)=>jsonRes == null? null:SearchHotWord(    id : jsonRes['id'],
    name : jsonRes['name'],
);
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
