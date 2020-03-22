import 'dart:convert' show json;

class SubscribeItem {
  String _name;
  String get name => _name;
  String _sub_update;
  String get sub_update => _sub_update;
  String _sub_img;
  String get sub_img => _sub_img;
  int _sub_uptime;
  int get sub_uptime => _sub_uptime;
  String _sub_first_letter;
  String get sub_first_letter => _sub_first_letter;
  int _sub_readed;
  int get sub_readed => _sub_readed;
  int _id;
  int get id => _id;
  String _status;
  String get status => _status;

    SubscribeItem({
String name,
String sub_update,
String sub_img,
int sub_uptime,
String sub_first_letter,
int sub_readed,
int id,
String status,
}):_name=name,_sub_update=sub_update,_sub_img=sub_img,_sub_uptime=sub_uptime,_sub_first_letter=sub_first_letter,_sub_readed=sub_readed,_id=id,_status=status;
  factory SubscribeItem.fromJson(jsonRes)=>jsonRes == null? null:SubscribeItem(    name : jsonRes['name'],
    sub_update : jsonRes['sub_update'],
    sub_img : jsonRes['sub_img'],
    sub_uptime : jsonRes['sub_uptime'],
    sub_first_letter : jsonRes['sub_first_letter'],
    sub_readed : jsonRes['sub_readed'],
    id : jsonRes['id'],
    status : jsonRes['status'],
);
  Map<String, dynamic> toJson() => {
        'name': _name,
        'sub_update': _sub_update,
        'sub_img': _sub_img,
        'sub_uptime': _sub_uptime,
        'sub_first_letter': _sub_first_letter,
        'sub_readed': _sub_readed,
        'id': _id,
        'status': _status,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

