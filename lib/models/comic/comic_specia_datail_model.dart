import 'dart:convert' show json;

class ComicSpecia {
  String _mobile_header_pic;
  String get mobile_header_pic => _mobile_header_pic;
  String _title;
  String get title => _title;
  String _page_url;
  String get page_url => _page_url;
  String _description;
  String get description => _description;
  List<ComicSpeciaItem> _comics;
  List<ComicSpeciaItem> get comics => _comics;
  int _comment_amount;
  int get comment_amount => _comment_amount;

    ComicSpecia({
String mobile_header_pic,
String title,
String page_url,
String description,
List<ComicSpeciaItem> comics,
int comment_amount,
}):_mobile_header_pic=mobile_header_pic,_title=title,_page_url=page_url,_description=description,_comics=comics,_comment_amount=comment_amount;
  factory ComicSpecia.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<ComicSpeciaItem> comics = jsonRes['comics'] is List ? []: null; 
    if(comics!=null) {
 for (var item in jsonRes['comics']) { if (item != null) { comics.add(ComicSpeciaItem.fromJson(item));  }
    }
    }


return ComicSpecia(    mobile_header_pic : jsonRes['mobile_header_pic'],
    title : jsonRes['title'],
    page_url : jsonRes['page_url'],
    description : jsonRes['description'],
 comics:comics,
    comment_amount : jsonRes['comment_amount'],
);}
  Map<String, dynamic> toJson() => {
        'mobile_header_pic': _mobile_header_pic,
        'title': _title,
        'page_url': _page_url,
        'description': _description,
        'comics': _comics,
        'comment_amount': _comment_amount,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class ComicSpeciaItem {
  String _cover;
  String get cover => _cover;
  String _recommend_brief;
  String get recommend_brief => _recommend_brief;
  String _recommend_reason;
  String get recommend_reason => _recommend_reason;
  int _id;
  int get id => _id;
  String _name;
  String get name => _name;
  String _alias_name;
  String get alias_name => _alias_name;

    ComicSpeciaItem({
String cover,
String recommend_brief,
String recommend_reason,
int id,
String name,
String alias_name,
}):_cover=cover,_recommend_brief=recommend_brief,_recommend_reason=recommend_reason,_id=id,_name=name,_alias_name=alias_name;
  factory ComicSpeciaItem.fromJson(jsonRes)=>jsonRes == null? null:ComicSpeciaItem(    cover : jsonRes['cover'],
    recommend_brief : jsonRes['recommend_brief'],
    recommend_reason : jsonRes['recommend_reason'],
    id : jsonRes['id'],
    name : jsonRes['name'],
    alias_name : jsonRes['alias_name'],
);
  Map<String, dynamic> toJson() => {
        'cover': _cover,
        'recommend_brief': _recommend_brief,
        'recommend_reason': _recommend_reason,
        'id': _id,
        'name': _name,
        'alias_name': _alias_name,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


