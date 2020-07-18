import 'package:event_bus/event_bus.dart';
import 'package:flutter_dmzj/sql/comic_down.dart';
// 章节ID
// 漫画ID
// 漫画名称
// 当前页数
// 总页数
// 下载状态 是否下载完成
// 文件夹

// 队列
// List<DownloadInfo>
// 当前下载
// List<DownloadInfo> Downloading 

// Status：
// 等待下载
// 下载中
// 暂停中
// 下载失败


// 保存至数据库
// 加入队列
// 下载队列获取信息
// 开始下载
// 下载封面
// 获取图片信息
// 开始下载图片
// 更新数据库


class ComicDownloadHelper{
  static EventBus downloadEvent=EventBus();
  static List<ComicDownloadSqlItem> dwonloadQueues=[];
  static ComicDownloadSqlItem currentDownload;
  static bool downloading;
  static void addDownload(ComicDownloadSqlItem info) async{
    //保存数据库
    var item=await ComicDownloadProvider.getItem(info.chapterID);
    if(item==null){
      await ComicDownloadProvider.insert(info);
    }
    //加入队列
    dwonloadQueues.add(info);


  }

}


