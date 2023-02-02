import 'package:flutter/material.dart';
import 'package:testapp/views/article.dart';
import 'package:testapp/views/home_view.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              // mbackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // floating: true,
              pinned: true,
            ),
          ];
        },
        body: _list());
  }
}

_list() {
  return ListView(children: [
    ListView.builder(
      clipBehavior: Clip.none,
      // scrollDirection: direction,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      // physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 8,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.grey,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Article();
              }));
            },
            child: Container(
              width: double.infinity,
              height: 180,
              // logic for bacground image

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
                        imageBox(const AssetImage('assets/background.jpg')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 15,
    ),
  ]);
}
