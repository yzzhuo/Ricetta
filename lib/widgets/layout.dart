import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatefulWidget {
  Widget child;
  Layout({super.key, required this.child});

  @override
  State<Layout> createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    final canGoBack = goRouter.canPop();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(67.0), // Default AppBar height
            child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(children: [
                  canGoBack
                      ? IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        )
                      : const SizedBox(width: 2.0),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: const Text('Ricetta',
                            style: TextStyle(
                              color: Color(0xFFFFD60A),
                              fontSize: 28,
                              fontFamily: 'Arial Black',
                              fontWeight: FontWeight.w900,
                              height: 0,
                            )),
                      )),
                  const SizedBox(width: 24.0),
                  const Expanded(child: SearchBar())
                ]))),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  spreadRadius: 2,
                  blurRadius: 16,
                  offset: Offset(0, -1), // changes position of shadow
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
          child: widget.child,
        ));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            offset: Offset(0, 2),
            blurRadius: 16.0,
          )
        ],
      ),
      child: TextField(
        style: const TextStyle(fontSize: 15.0),
        cursorColor: kPrimaryLabelColor,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: kPrimaryLabelColor),
          border: InputBorder.none,
          hintText: "Search for recepies",
        ),
        onChanged: (newText) {
          print(newText);
        },
      ),
    );
  }
}
