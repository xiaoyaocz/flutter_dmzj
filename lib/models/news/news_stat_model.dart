import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsStatModel {
  NewsStatModel({
    required this.commentAmount,
    required this.moodAmount,
    required this.rowPicUrl,
    required this.title,
  });

  factory NewsStatModel.fromJson(Map<String, dynamic> json) => NewsStatModel(
        /// DMZJ后端是真混乱... commentAmount是string，mood_amount是int
        commentAmount: int.tryParse(json['comment_amount'].toString()) ?? 0,
        moodAmount: int.tryParse(json['mood_amount'].toString()) ?? 0,
        rowPicUrl: asT<String>(json['row_pic_url'])!,
        title: asT<String>(json['title'])!,
      );

  int commentAmount;
  int moodAmount;
  String rowPicUrl;
  String title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comment_amount': commentAmount,
        'mood_amount': moodAmount,
        'row_pic_url': rowPicUrl,
        'title': title,
      };
}
