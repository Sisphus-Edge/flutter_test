import 'package:flutter/material.dart';


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

      child: Container(
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
    );
  }


}

