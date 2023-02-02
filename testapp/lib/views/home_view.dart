import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:testapp/views/article.dart';

import 'package:testapp/views/view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var tabTextIndexSelected = 0;
  final List<String> tabs = <String>[
    "For you",
    "Categories",
  ];
  @override
  Widget build(BuildContext context) {
    return MainView(
        tabBarController: widget.tabController,
        expandedHeightRatio: 0.25,
        // scrollController: _scrollController,
        backgroundColor: Colors.transparent,
        largeTitleTextStyle: const TextStyle(),
        title: const Text('Home'),
        largeTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Monday, 28th December',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Welcome back,\nxD',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.language),
            label: const Text('ENG'),
          ),
          // Badge(
          //     position: BadgePosition.topEnd(top: 15, end: 15),
          //     child: IconButton(
          //         onPressed: () {}, icon: const Icon(Icons.notifications))),
        ],
        bottom: FlutterToggleTab(
// width in percent
          width: 90,
          borderRadius: 30,
          height: 36, marginSelected: const EdgeInsets.all(5),
          selectedIndex: tabTextIndexSelected,
          selectedBackgroundColors: const [Colors.white],
          selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
          unSelectedTextStyle:
              const TextStyle(color: Colors.black87, fontSize: 14),
          labels: tabs,
          selectedLabelIndex: (int index) {
            setState(() {
              tabTextIndexSelected = index == 0 ? 0 : 1;
              widget.tabController.index = index == 0 ? 0 : 1;
            });
          },
          isScroll: false,
        ),
        slivers: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomScrollView(clipBehavior: Clip.none, slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: _listItems(10, Axis.horizontal, double.infinity,
                            320, Colors.grey),
                      ),
                    ),
                    _listItems(10, Axis.vertical, 200, double.infinity,
                        Colors.purpleAccent.shade200),
                  ],
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: CustomScrollView(clipBehavior: Clip.none, slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: _listItems(10, Axis.horizontal, double.infinity,
                            320, Colors.grey),
                      ),
                    ),
                    _listItems(10, Axis.vertical, 200, double.infinity,
                        Colors.purpleAccent.shade200),
                  ],
                ),
              ),
            ]),
          ),
        ]);
  }
}

Widget _listItems(int itemCount, Axis direction, double height, double width,
    Color backgroundColor) {
  return ListView.builder(
    clipBehavior: Clip.none,
    scrollDirection: direction,
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    primary: false,
    // physics: const ScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return articleCard(backgroundColor, context, width, height, direction,
          const AssetImage('assets/background.jpg'));
    },
    itemCount: itemCount,
  );
}

Card articleCard(Color backgroundColor, BuildContext context, double width,
    double height, Axis direction, AssetImage image) {
  return Card(
    elevation: 8,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: backgroundColor,
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Article();
        }));
      },
      child: Container(
        width: width,
        height: height,
        // logic for bacground image
        decoration: direction == Axis.horizontal
            ? BoxDecoration(
                image: DecorationImage(image: image, fit: BoxFit.cover))
            : null,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Chip(
                label: Text('fdsfdsg'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'afdgdsgsd',
                    softWrap: true,
                    style: TextStyle(color: Colors.white),
                  ),
                  if (direction == Axis.vertical) imageBox(image),
                ],
              ),
              if (direction == Axis.vertical)
                Row(
                  children: const [
                    Text(
                      'afdgdsgsd',
                      softWrap: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'afdgdsgsd',
                      softWrap: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'afdgdsgsd',
                      softWrap: true,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget imageBox(AssetImage image) {
  return ClipRRect(
    // clipBehavior: Clip.none,
    borderRadius: BorderRadius.circular(20),
    child: Image(
      image: image,
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
  );
}
