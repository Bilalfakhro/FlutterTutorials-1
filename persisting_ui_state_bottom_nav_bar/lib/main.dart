import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PersistingState',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentTab = 0;

  PageOne one;
  PageTwo two;
  List<Widget> pages;
  Widget currentPage;

  List<Data> dataList;

  final PageStorageBucket bucket = PageStorageBucket();

  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');

  @override
  void initState() {
    dataList = [
      Data(1, false, "Example-1"),
      Data(2, false, "Example-2"),
      Data(3, false, "Example-3"),
      Data(4, false, "Example-4"),
      Data(5, false, "Example-5"),
      Data(6, false, "Example-6"),
      Data(7, false, "Example-7"),
      Data(8, false, "Example-8"),
      Data(9, false, "Example-9"),
      Data(10, false, "Example-10"),
    ];

    one = PageOne(
      key: keyOne,
      dataList: dataList,
    );
    two = PageTwo(
      key: keyTwo,
    );

    pages = [one, two];
    currentPage = one;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('BottomNavBar demo')),
        body: PageStorage(child: currentPage, bucket: bucket),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Settings'))
          ],
          onTap: (int index) => setState(() {
                currentTab = index;
                currentPage = pages[currentTab];
              }),
          currentIndex: currentTab,
        ));
  }
}

class PageOne extends StatefulWidget {
  final List<Data> dataList;
  PageOne({Key key, this.dataList}) : super(key: key);
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dataList.length,
      itemBuilder: (context, index) => ExpansionTile(
            // key: PageStorageKey('expansionTile'),
            key: PageStorageKey('${widget.dataList[index].id}'),
            title: Text(widget.dataList[index].title),
            // onExpansionChanged: (b) => setState(() {
            //       widget.dataList[index].expanded = b;
            //       // PageStorage.of(context).writeState(context, b,
            //       //     identifier: ValueKey('${widget.dataList[index].id}'));
            //     }),
            // initiallyExpanded: widget.dataList[index].expanded,
            // // PageStorage.of(context).readState(
            // //       context,
            // //       identifier: ValueKey('${widget.dataList[index].id}'),
            // //     ) ??
            // //     false,
            children: <Widget>[
              Container(
                color: index % 2 == 0 ? Colors.orange : Colors.limeAccent,
                height: 100.0,
              )
            ],
          ),
    );
  }
}

class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);

  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 140.0,
      itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(10.0),
          child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
              child: Center(
                child: Text(
                  index.toString(),
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ))),
    );
  }
}

class Data {
  final int id;
  bool expanded;
  final String title;
  Data(this.id, this.expanded, this.title);
}
