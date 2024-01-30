import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  final double width;
  final double height;

  const MyHomePage({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ["Item 1", "Item 2", "Item 3"];
  int selectedIndex = 0;

  void selectItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                items.length,
                    (index) => ElevatedButton(
                  onPressed: () {
                    selectItem(index);
                  },
                  child: Text(items[index]),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                items.length,
                    (index) => Container(
                  width: 30,
                  height: 30,
                  color: index == selectedIndex ? Colors.blue : Colors.grey,
                  child: Center(
                    child: Text(
                      items[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}
