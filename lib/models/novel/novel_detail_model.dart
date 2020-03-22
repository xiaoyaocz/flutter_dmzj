import 'dart:convert' show json;

class NovelDetail {
  int _id;
  int get id => _id;
  String _name;
  String get name => _name;
  String _zone;
  String get zone => _zone;
  String _status;
  String get status => _status;
  String _last_update_volume_name;
  String get last_update_volume_name => _last_update_volume_name;
  String _last_update_chapter_name;
  String get last_update_chapter_name => _last_update_chapter_name;
  int _last_update_volume_id;
  int get last_update_volume_id => _last_update_volume_id;
  int _last_update_chapter_id;
  int get last_update_chapter_id => _last_update_chapter_id;
  int _last_update_time;
  int get last_update_time => _last_update_time;
  String _cover;
  String get cover => _cover;
  int _hot_hits;
  int get hot_hits => _hot_hits;
  String _introduction;
  String get introduction => _introduction;
  List<String> _types;
  List<String> get types => _types;
  String _authors;
  String get authors => _authors;
  String _first_letter;
  String get first_letter => _first_letter;
  int _subscribe_num;
  int get subscribe_num => _subscribe_num;
  int _redis_update_time;
  int get redis_update_time => _redis_update_time;
  List<NovelDetailVolumeItem> _volume;
  List<NovelDetailVolumeItem> get volume => _volume;

    NovelDetail({
int id,
String name,
String zone,
String status,
String last_update_volume_name,
String last_update_chapter_name,
int last_update_volume_id,
int last_update_chapter_id,
int last_update_time,
String cover,
int hot_hits,
String introduction,
List<String> types,
String authors,
String first_letter,
int subscribe_num,
int redis_update_time,
List<NovelDetailVolumeItem> volume,
}):_id=id,_name=name,_zone=zone,_status=status,_last_update_volume_name=last_update_volume_name,_last_update_chapter_name=last_update_chapter_name,_last_update_volume_id=last_update_volume_id,_last_update_chapter_id=last_update_chapter_id,_last_update_time=last_update_time,_cover=cover,_hot_hits=hot_hits,_introduction=introduction,_types=types,_authors=authors,_first_letter=first_letter,_subscribe_num=subscribe_num,_redis_update_time=redis_update_time,_volume=volume;
  factory NovelDetail.fromJson(jsonRes){ if(jsonRes == null) return null;
    List<String> types = jsonRes['types'] is List ? []: null; 
    if(types!=null) {
 for (var item in jsonRes['types']) { if (item != null) { types.add(item);  }
    }
    }


    List<NovelDetailVolumeItem> volume = jsonRes['volume'] is List ? []: null; 
    if(volume!=null) {
 for (var item in jsonRes['volume']) { if (item != null) { volume.add(NovelDetailVolumeItem.fromJson(item));  }
    }
    }


return NovelDetail(    id : jsonRes['id'],
    name : jsonRes['name'],
    zone : jsonRes['zone'],
    status : jsonRes['status'],
    last_update_volume_name : jsonRes['last_update_volume_name'],
    last_update_chapter_name : jsonRes['last_update_chapter_name'],
    last_update_volume_id : jsonRes['last_update_volume_id'],
    last_update_chapter_id : jsonRes['last_update_chapter_id'],
    last_update_time : jsonRes['last_update_time'],
    cover : jsonRes['cover'],
    hot_hits : jsonRes['hot_hits'],
    introduction : jsonRes['introduction'],
 types:types,
    authors : jsonRes['authors'],
    first_letter : jsonRes['first_letter'],
    subscribe_num : jsonRes['subscribe_num'],
    redis_update_time : jsonRes['redis_update_time'],
 volume:volume,
);}
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'zone': _zone,
        'status': _status,
        'last_update_volume_name': _last_update_volume_name,
        'last_update_chapter_name': _last_update_chapter_name,
        'last_update_volume_id': _last_update_volume_id,
        'last_update_chapter_id': _last_update_chapter_id,
        'last_update_time': _last_update_time,
        'cover': _cover,
        'hot_hits': _hot_hits,
        'introduction': _introduction,
        'types': _types,
        'authors': _authors,
        'first_letter': _first_letter,
        'subscribe_num': _subscribe_num,
        'redis_update_time': _redis_update_time,
        'volume': _volume,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class NovelDetailVolumeItem {
  int _id;
  int get id => _id;
  int _lnovel_id;
  int get lnovel_id => _lnovel_id;
  String _volume_name;
  String get volume_name => _volume_name;
  int _volume_order;
  int get volume_order => _volume_order;
  int _addtime;
  int get addtime => _addtime;
  int _sum_chapters;
  int get sum_chapters => _sum_chapters;

    NovelDetailVolumeItem({
int id,
int lnovel_id,
String volume_name,
int volume_order,
int addtime,
int sum_chapters,
}):_id=id,_lnovel_id=lnovel_id,_volume_name=volume_name,_volume_order=volume_order,_addtime=addtime,_sum_chapters=sum_chapters;
  factory NovelDetailVolumeItem.fromJson(jsonRes)=>jsonRes == null? null:NovelDetailVolumeItem(    id : jsonRes['id'],
    lnovel_id : jsonRes['lnovel_id'],
    volume_name : jsonRes['volume_name'],
    volume_order : jsonRes['volume_order'],
    addtime : jsonRes['addtime'],
    sum_chapters : jsonRes['sum_chapters'],
);
  Map<String, dynamic> toJson() => {
        'id': _id,
        'lnovel_id': _lnovel_id,
        'volume_name': _volume_name,
        'volume_order': _volume_order,
        'addtime': _addtime,
        'sum_chapters': _sum_chapters,
};

  @override
String  toString() {
    return json.encode(this);
  }
}


