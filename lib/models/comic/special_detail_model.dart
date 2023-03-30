import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicSpecialDetailModel {
  ComicSpecialDetailModel({
    required this.mobileHeaderPic,
    required this.title,
    required this.pageUrl,
    required this.description,
    required this.comics,
    required this.commentAmount,
  });

  factory ComicSpecialDetailModel.fromJson(Map<String, dynamic> json) {
    final List<ComicSpecialComicModel>? comics =
        json['comics'] is List ? <ComicSpecialComicModel>[] : null;
    if (comics != null) {
      for (final dynamic item in json['comics']!) {
        if (item != null) {
          comics.add(ComicSpecialComicModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicSpecialDetailModel(
      mobileHeaderPic: asT<String>(json['mobile_header_pic'])!,
      title: asT<String>(json['title'])!,
      pageUrl: asT<String>(json['page_url'])!,
      description: asT<String>(json['description'])!,
      comics: comics!,
      commentAmount: asT<int>(json['comment_amount'])!,
    );
  }

  String mobileHeaderPic;
  String title;
  String pageUrl;
  String description;
  List<ComicSpecialComicModel> comics;
  int commentAmount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'mobile_header_pic': mobileHeaderPic,
        'title': title,
        'page_url': pageUrl,
        'description': description,
        'comics': comics,
        'comment_amount': commentAmount,
      };
}

class ComicSpecialComicModel {
  ComicSpecialComicModel({
    required this.cover,
    required this.recommendBrief,
    required this.recommendReason,
    required this.id,
    required this.name,
    required this.aliasName,
  });

  factory ComicSpecialComicModel.fromJson(Map<String, dynamic> json) =>
      ComicSpecialComicModel(
        cover: asT<String?>(json['cover']) ?? "",
        recommendBrief: asT<String?>(json['recommend_brief']) ?? "",
        recommendReason: asT<String?>(json['recommend_reason']) ?? "",
        id: asT<int>(json['id'])!,
        name: asT<String?>(json['name']) ?? "",
        aliasName: asT<String?>(json['alias_name']) ?? "",
      );

  String cover;
  String recommendBrief;
  String recommendReason;
  int id;
  String name;
  String aliasName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cover': cover,
        'recommend_brief': recommendBrief,
        'recommend_reason': recommendReason,
        'id': id,
        'name': name,
        'alias_name': aliasName,
      };
}
