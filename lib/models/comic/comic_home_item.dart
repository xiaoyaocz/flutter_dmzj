import 'dart:convert' show json;

class ComicHomeItem<T> {
  int category_id;
  String title;
  int sort;
  List<T> data;

    ComicHomeItem({
this.category_id,
this.title,
this.sort,
this.data,
    });


  factory ComicHomeItem.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<T> data = jsonRes['data'] is List ? []: null; 
    if(data!=null) {
 for (var item in jsonRes['data']) { if (item != null) { data.add(item);  }
    }
    }


return ComicHomeItem(    category_id : jsonRes['category_id'],
    title : jsonRes['title'],
    sort : jsonRes['sort'],
 data:data,
);}
  Map<String, dynamic> toJson() => {
        'category_id': category_id,
        'title': title,
        'sort': sort,
        'data': data,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

