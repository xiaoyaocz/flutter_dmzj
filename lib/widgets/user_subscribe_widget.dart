import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/user/user_subscribe_item.dart';

class UserSubscribeWidget extends StatelessWidget {
  List<SubscribeItem> list;
  int type=0;
  UserSubscribeWidget(this.list,{this.type=0,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  list.length != 0
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    physics: ScrollPhysics(),
                    itemCount: list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 3 / 5.5),
                    itemBuilder: (context, i) => _getComicItemBuilder(
                      context,
                        list[i].id,
                        type + 1,
                        list[i].sub_img,
                        list[i].name,
                        '更新:' + list[i].sub_update,
                        list[i].status),
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        "什么都没有呢~",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
  }

  Widget _getComicItemBuilder(BuildContext context, int id, int type, String pic, String title,
      String last_upadate, String view) {
    return Card(
      child: InkWell(
          onTap: () => Utils.openPage(context, id, type, title: title),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Utils.createCacheImage(pic, 270, 360),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    last_upadate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                )),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      view,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }


}