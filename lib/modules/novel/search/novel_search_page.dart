import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/novel/search_model.dart';
import 'package:flutter_dmzj/modules/novel/search/novel_search_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:get/get.dart';

class NovelSearchPage extends StatelessWidget {
  final String keyword;
  final NovelSearchController controller;
  NovelSearchPage({this.keyword = "", super.key})
      : controller = Get.put(NovelSearchController(keyword));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 8,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: controller.searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "搜索轻小说",
              contentPadding: AppStyle.edgeInsetsH12,
              border: const OutlineInputBorder(),
              prefixIcon: SizedBox(
                width: 48,
                child: IconButton(
                  onPressed: () {
                    AppNavigator.closePage();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              suffixIcon: SizedBox(
                width: 48,
                child: IconButton(
                  onPressed: controller.submit,
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            onSubmitted: (e) {
              controller.submit();
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          PageListView(
            pageController: controller,
            firstRefresh: false,
            showPageLoadding: true,
            separatorBuilder: (context, i) => Divider(
              endIndent: 12,
              indent: 12,
              color: Colors.grey.withOpacity(.2),
              height: 1,
            ),
            itemBuilder: (context, i) {
              var item = controller.list[i];
              return buildItem(item);
            },
          ),
          Positioned.fill(
            child: Obx(
              () => Offstage(
                offstage: !controller.showHotWord.value,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text("热门搜索"),
                      ),
                      Padding(
                        padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.hotWords.keys
                              .map(
                                (e) => OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    AppNavigator.toNovelDetail(e);
                                  },
                                  child: Text(controller.hotWords[e] ?? ""),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(NovelSearchModel item) {
    return InkWell(
      onTap: () {
        AppNavigator.toNovelDetail(item.id);
      },
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NetImage(
              item.cover,
              width: 80,
              height: 110,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                          text: item.authors,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  AppStyle.vGap4,
                  Text(item.types,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  AppStyle.vGap4,
                  Text(item.lastName,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
