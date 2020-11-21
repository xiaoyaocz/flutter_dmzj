import 'dart:convert' show json;

class NewsBannerModel {
  int code;
  String msg;
  List<NewsBannerItemModel> data;

  NewsBannerModel({
    this.code,
    this.msg,
    this.data,
  });

  factory NewsBannerModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<NewsBannerItemModel> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          data.add(NewsBannerItemModel.fromJson(item));
        }
      }
    }

    return NewsBannerModel(
      code: jsonRes['code'],
      msg: jsonRes['msg'],
      data: data,
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class NewsBannerItemModel {
  int id;
  String title;
  String pic_url;
  int object_id;
  String object_url;

  NewsBannerItemModel({
    this.id,
    this.title,
    this.pic_url,
    this.object_id,
    this.object_url,
  });

  factory NewsBannerItemModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : NewsBannerItemModel(
          id: jsonRes['id'],
          title: jsonRes['title'],
          pic_url: jsonRes['pic_url'],
          object_id: jsonRes['object_id'],
          object_url: jsonRes['object_url'],
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'pic_url': pic_url,
        'object_id': object_id,
        'object_url': object_url,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
