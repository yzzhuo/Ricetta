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
                  const Expanded(child: SearchBar()),
                  const SizedBox(width: 8.0),
                  IconButton(
                      onPressed: () {
                        context.go('/profile');
                      },
                      icon: const Icon(Icons.account_circle,
                          color: kPrimaryLabelColor)),
                  const SizedBox(width: 4.0),
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

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _search() {
    final String searchText = _controller.text;
    context.push('/recipes?search=$searchText');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        margin: const EdgeInsets.all(0),
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
        child: Row(children: [
          Expanded(
              child: TextField(
            style: const TextStyle(fontSize: 15.0, height: 0.1),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Search for recepies",
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(
                  0, 10.0, 0, 10.0), // Adjust padding as needed
            ),
            controller: _controller,
          )),
          IconButton(
              onPressed: _search,
              icon: const Icon(Icons.search, color: kPrimaryLabelColor))
        ]));
  }
}
