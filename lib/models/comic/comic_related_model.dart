import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicRelatedModel {
  ComicRelatedModel({
    required this.authorComics,
    required this.themeComics,
    required this.novels,
  });

  factory ComicRelatedModel.fromJson(Map<String, dynamic> json) {
    final List<ComicRelatedAuthorModel>? authorComics =
        json['author_comics'] is List ? <ComicRelatedAuthorModel>[] : null;
    if (authorComics != null) {
      for (final dynamic item in json['author_comics']!) {
        if (item != null) {
          authorComics.add(ComicRelatedAuthorModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<ComicRelatedItemModel>? themeComics =
        json['theme_comics'] is List ? <ComicRelatedItemModel>[] : null;
    if (themeComics != null) {
      for (final dynamic item in json['theme_comics']!) {
        if (item != null) {
          themeComics.add(
              ComicRelatedItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<ComicRelatedItemModel>? novels =
        json['novels'] is List ? <ComicRelatedItemModel>[] : null;
    if (novels != null) {
      for (final dynamic item in json['novels']!) {
        if (item != null) {
          novels.add(
              ComicRelatedItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicRelatedModel(
      authorComics: authorComics!,
      themeComics: themeComics!,
      novels: novels!,
    );
  }

  List<ComicRelatedAuthorModel> authorComics;
  List<ComicRelatedItemModel> themeComics;
  List<ComicRelatedItemModel> novels;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'author_comics': authorComics,
        'theme_comics': themeComics,
        'novels': novels,
      };
}

class ComicRelatedAuthorModel {
  ComicRelatedAuthorModel({
    required this.authorName,
    required this.authorId,
    required this.data,
  });

  factory ComicRelatedAuthorModel.fromJson(Map<String, dynamic> json) {
    final List<ComicRelatedItemModel>? data =
        json['data'] is List ? <ComicRelatedItemModel>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(
              ComicRelatedItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicRelatedAuthorModel(
      authorName: asT<String>(json['author_name'])!,
      authorId: asT<int>(json['author_id'])!,
      data: data!,
    );
  }

  String authorName;
  int authorId;
  List<ComicRelatedItemModel> data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'author_name': authorName,
        'author_id': authorId,
        'data': data,
      };
}

class ComicRelatedItemModel {
  ComicRelatedItemModel({
    required this.id,
    required this.name,
    required this.cover,
    required this.status,
  });

  factory ComicRelatedItemModel.fromJson(Map<String, dynamic> json) =>
      ComicRelatedItemModel(
        id: asT<int>(json['id'])!,
        name: asT<String>(json['name'])!,
        cover: asT<String>(json['cover'])!,
        status: asT<String>(json['status'])!,
      );

  int id;
  String name;
  String cover;
  String status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'cover': cover,
        'status': status,
      };
}
