import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:untitled/widges/community/follow_list.dart';
import 'package:untitled/widges/community/follow_list_data_test.dart';
import 'package:untitled/widges/community/tweets_community.dart';
import 'package:untitled/widges/community/tweets_list_data_test.dart';

class CommunityRoute extends StatefulWidget {
  const CommunityRoute({super.key, required this.topPadding, required this.MediaWidth, required this.MediaHeight});

  final double topPadding;
  final double MediaWidth;
  final double MediaHeight;

  @override
  _CommunityRouteState createState() => _CommunityRouteState();

}


class _CommunityRouteState extends State<CommunityRoute> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final ThemeData themeData = ThemeData(
      //     useMaterial3: true,
      //     brightness: isDark ? Brightness.dark : Brightness.light);

    final topPadding = widget.topPadding;
    final double sharedMediaWidth = widget.MediaWidth;
    final double sharedMediaHeight = widget.MediaHeight;

    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                        child: Column(
                            children: [
                              Container(
                                width: sharedMediaWidth*0.99,
                                height: sharedMediaHeight*0.07,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: sharedMediaWidth * 0.05),
                                  child: SearchAnchor(
                                      builder: (BuildContext context, SearchController controller) {
                                        return SearchBar(
                                          controller: controller,
                                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                                              EdgeInsets.symmetric(horizontal: 16.0)),
                                          onTap: () {
                                            controller.openView();
                                          },
                                          onChanged: (_) {
                                            controller.openView();
                                          },
                                          leading: const Icon(Icons.search),
                                          trailing: <Widget>[
                                            Tooltip(
                                              message: 'Change brightness mode',
                                              child: IconButton(
                                                isSelected: isDark,
                                                onPressed: () {
                                                  setState(() {
                                                    isDark = !isDark;
                                                  });
                                                },
                                                icon: const Icon(Icons.wb_sunny_outlined),
                                                selectedIcon: const Icon(Icons.brightness_2_outlined),
                                              ),
                                            )
                                          ],
                                        );
                                      }, suggestionsBuilder:
                                      (BuildContext context, SearchController controller) {
                                    return List<ListTile>.generate(5, (int index) {
                                      final String item = 'item $index';
                                      return ListTile(
                                        title: Text(item),
                                        onTap: () {
                                          setState(() {
                                            controller.closeView(item);
                                          });
                                        },
                                      );
                                    });
                                  }),
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                                height: sharedMediaHeight * 0.025,
                              ),
                              HorizontalFollowList(
                                section_width: sharedMediaWidth*0.97,
                                section_height: sharedMediaHeight * 0.15,
                                avatarFiles: generateAvatarFiles(),
                              ),
                              Divider(
                                color: Colors.transparent,
                                height: sharedMediaHeight * 0.03,
                              ),
                            ]
                        ))
                    ;
                  },
              childCount: 1, // 第一个列表的项数
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: FixedHeaderDelegate(
              child: Container(
                height: 200,
                child: Tweets(
                  section_width: sharedMediaWidth*0.97,
                  section_height: sharedMediaHeight * 0.17,
                  sectionTitles: generateSectionFiles(),
                  onTapHandlers: buildOnTapHandlers(),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return ListTile(
                  title: Text('Second List Item $index'),
                );
              },
              childCount: 50, // 第二个列表的项数
            ),
          ),
        ],
      ),
    );

  }
  //


}
class FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  FixedHeaderDelegate({required this.child});

  @override
  double get minExtent => 150.0;

  @override
  double get maxExtent => 150.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(FixedHeaderDelegate oldDelegate) {
    return false;
  }
}
