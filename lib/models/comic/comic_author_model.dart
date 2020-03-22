import 'dart:convert' show json;

class ComicAuthor {
  String _nickname;
  String get nickname => _nickname;
  String _description;
  String get description => _description;
  String _cover;
  String get cover => _cover;
  List<ComicAuthorItem> _data;
  List<ComicAuthorItem> get data => _data;

    ComicAuthor({
String nickname,
String description,
String cover,
List<ComicAuthorItem> data,
}):_nickname=nickname,_description=description,_cover=cover,_data=data;
  factory ComicAuthor.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<ComicAuthorItem> data = jsonRes['data'] is List ? []: null; 
    if(data!=null) {
 for (var item in jsonRes['data']) { if (item != null) { data.add(ComicAuthorItem.fromJson(item));  }
    }
    }


return ComicAuthor(    nickname : jsonRes['nickname'],
    description : jsonRes['description'],
    cover : jsonRes['cover'],
 data:data,
);}
  Map<String, dynamic> toJson() => {
        'nickname': _nickname,
        'description': _description,
        'cover': _cover,
        'data': _data,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class ComicAuthorItem {
  int _id;
  int get id => _id;
  String _name;
  String get name => _name;
  String _cover;
  String get cover => _cover;
  String _status;
  String get status => _status;

    ComicAuthorItem({
int id,
String name,
String cover,
String status,
}):_id=id,_name=name,_cover=cover,_status=status;
  factory ComicAuthorItem.fromJson(jsonRes)=>jsonRes == null? null:ComicAuthorItem(    id : jsonRes['id'],
    name : jsonRes['name'],
    cover : jsonRes['cover'],
    status : jsonRes['status'],
);
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'cover': _cover,
        'status': _status,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


