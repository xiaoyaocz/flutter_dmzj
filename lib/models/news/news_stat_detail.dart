import 'dart:convert' show json;

class NewsStatDetail {
  String _comment_amount="0";
  String get comment_amount => _comment_amount;
  set comment_amount(value)  {
   var v= int.tryParse(value,radix: 0);
    _comment_amount = v.toString();
  }

  int _mood_amount=0;
  int get mood_amount => _mood_amount;
  set mood_amount(value)  {
    _mood_amount = value;
  }

  String _row_pic_url;
  String get row_pic_url => _row_pic_url;
  set row_pic_url(value)  {
    _row_pic_url = value;
  }

  String _title;
  String get title => _title;
  set title(value)  {
    _title = value;
  }


    NewsStatDetail({
String comment_amount,
int mood_amount,
String row_pic_url,
String title,
}):_comment_amount=comment_amount,_mood_amount=mood_amount,_row_pic_url=row_pic_url,_title=title;
  factory NewsStatDetail.fromJson(jsonRes)=>jsonRes == null? null:NewsStatDetail(    comment_amount : jsonRes['comment_amount'],
    mood_amount : jsonRes['mood_amount'],
    row_pic_url : jsonRes['row_pic_url'],
    title : jsonRes['title'],
);
  Map<String, dynamic> toJson() => {
        'comment_amount': _comment_amount,
        'mood_amount': _mood_amount,
        'row_pic_url': _row_pic_url,
        'title': _title,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

