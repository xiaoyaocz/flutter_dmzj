import 'dart:convert' show json;

class ComicHomeBannerItem {
  String cover;
  String title;
  String sub_title;
  int type;
  String url;
  int obj_id;
  String status;

  int get id => obj_id;

  ComicHomeBannerItem({
    this.cover,
    this.title,
    this.sub_title,
    this.type,
    this.url,
    this.obj_id,
    this.status,
  });

  factory ComicHomeBannerItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicHomeBannerItem(
          cover: jsonRes['cover'],
          title: jsonRes['title'],
          sub_title: jsonRes['sub_title'],
          type: jsonRes['type'],
          url: jsonRes['url'],
          obj_id: jsonRes['obj_id'],
          status: jsonRes['status'],
        );
  Map<String, dynamic> toJson() => {
        'cover': cover,
        'title': title,
        'sub_title': sub_title,
        'type': type,
        'url': url,
        'obj_id': obj_id,
        'status': status,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
