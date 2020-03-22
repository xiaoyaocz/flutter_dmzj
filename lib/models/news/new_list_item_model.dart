import 'dart:convert' show json;

class NewsListItemModel {
  String title;
  String from_name;
  String from_url;
  int create_time;
  int is_foreign;
  String foreign_url;
  String intro;
  int author_id;
  int status;
  String row_pic_url;
  String col_pic_url;
  int article_id;
  String page_url;
  int comment_amount;
  int author_uid;
  String cover;
  String nickname;
  int mood_amount;
  get time=>DateTime.fromMillisecondsSinceEpoch(create_time*1000);
    NewsListItemModel({
this.title,
this.from_name,
this.from_url,
this.create_time,
this.is_foreign,
this.foreign_url,
this.intro,
this.author_id,
this.status,
this.row_pic_url,
this.col_pic_url,
this.article_id,
this.page_url,
this.comment_amount,
this.author_uid,
this.cover,
this.nickname,
this.mood_amount,
    });


  factory NewsListItemModel.fromJson(jsonRes)=>jsonRes == null? null:NewsListItemModel(    title : jsonRes['title'],
    from_name : jsonRes['from_name'],
    from_url : jsonRes['from_url'],
    create_time : jsonRes['create_time'],
    is_foreign : jsonRes['is_foreign'],
    foreign_url : jsonRes['foreign_url'],
    intro : jsonRes['intro'],
    author_id : jsonRes['author_id'],
    status : jsonRes['status'],
    row_pic_url : jsonRes['row_pic_url'],
    col_pic_url : jsonRes['col_pic_url'],
    article_id : jsonRes['article_id'],
    page_url : jsonRes['page_url'],
    //动漫之家后端，随机返回String或者Int，简直牛批，必须判断类型
    comment_amount : (jsonRes['comment_amount'] is String)?int.parse(jsonRes['comment_amount']):jsonRes['comment_amount'],
    author_uid : jsonRes['author_uid'],
    cover : jsonRes['cover'],
    nickname : jsonRes['nickname'],
    mood_amount : jsonRes['mood_amount'],
);
  Map<String, dynamic> toJson() => {
        'title': title,
        'from_name': from_name,
        'from_url': from_url,
        'create_time': create_time,
        'is_foreign': is_foreign,
        'foreign_url': foreign_url,
        'intro': intro,
        'author_id': author_id,
        'status': status,
        'row_pic_url': row_pic_url,
        'col_pic_url': col_pic_url,
        'article_id': article_id,
        'page_url': page_url,
        'comment_amount': comment_amount,
        'author_uid': author_uid,
        'cover': cover,
        'nickname': nickname,
        'mood_amount': mood_amount,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

