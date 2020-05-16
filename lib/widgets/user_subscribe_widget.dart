import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/user/user_subscribe_item.dart';

class UserSubscribeWidget extends StatefulWidget {
   List<SubscribeItem> list;
  int type=0;
  UserSubscribeWidget(this.list,{this.type=0,Key key}) : super(key: key);

  @override
  _UserSubscribeWidgetState createState() => _UserSubscribeWidgetState();
}

class _UserSubscribeWidgetState extends State<UserSubscribeWidget> {

  double getWidth() {
    var count=MediaQuery.of(context).size.width~/160;
    if(count<3)count=3;
    return (MediaQuery.of(context).size.width - count*8) / count - 8;
  }

  @override
  Widget build(BuildContext context) {
    return  widget.list.length != 0
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    physics: ScrollPhysics(),
                    itemCount: widget.list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width~/160<3?3:MediaQuery.of(context).size.width~/160,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: getWidth() / ((getWidth() * (360 / 270)) + 64)),
                    itemBuilder: (context, i) => _getComicItemBuilder(
                      context,
                        widget.list[i].id,
                        widget.type + 1,
                        widget.list[i].sub_img,
                        widget.list[i].name,
                        '更新:' + widget.list[i].sub_update,
                        widget.list[i].status),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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