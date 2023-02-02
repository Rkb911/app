import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              tooltip: 'Open shopping cart',
              onPressed: () {
                // handle the press
              },
            ),
          ],
        ),
        body: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                // color: Colors.black,
                image: DecorationImage(
                    opacity: 0.7,
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.fitWidth),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Chip(
                              label: Text('fdsfdsg'),
                            ),
                            Chip(
                              label: Text('fdsfdsg'),
                            ),
                          ],
                        ),
                        const Text(
                          'sdgyufdsigsdlgsdsbsduigbsg\nfyusfgs',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SlidingUpPanel(
                panelSnapping: false,
                padding: const EdgeInsets.all(10.0),
                header: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Chip(
                        label: Text('fdsfdsg'),
                      ),
                      Chip(
                        label: Text('fdsfdsg'),
                      ),
                    ],
                  ),
                ),
                minHeight: MediaQuery.of(context).size.height * 0.6,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                panelBuilder: (ScrollController sc) => _scrollingList(sc),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
            ],
          ),
        ]));
    //
  }
}

Widget _scrollingList(ScrollController sc) {
  return ListView.builder(
    controller: sc,
    itemCount: 50,
    itemBuilder: (BuildContext context, int i) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Text("$i"),
      );
    },
  );
}
