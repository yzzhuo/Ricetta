import 'package:Ricetta/providers/user_provider.dart';
import 'package:Ricetta/utils/breakpoint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:go_router/go_router.dart';

class Layout extends ConsumerStatefulWidget {
  Widget child;
  Layout({super.key, required this.child});

  @override
  _LayoutState createState() => _LayoutState();
}

class NavigateOption {
  final String name;
  final IconData icon;
  final String path;
  NavigateOption({required this.name, required this.icon, required this.path});
}

class _LayoutState extends ConsumerState<Layout> {
  int _selectedIndex = 0;
  final options = [
    NavigateOption(name: 'Home', icon: Icons.home, path: '/'),
    NavigateOption(name: 'Recipes', icon: Icons.bookmark, path: '/recipes'),
    NavigateOption(name: 'Profile', icon: Icons.person, path: '/profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.push(options[index].path);
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    final canGoBack = goRouter.canPop();
    final user = ref.watch(userProvider);

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
                  user == null
                      ? TextButton(
                          onPressed: () {
                            context.push('/profile');
                          },
                          child: const Text('Login',
                              style: TextStyle(
                                color: kPrimaryLabelColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      : IconButton(
                          onPressed: () {
                            context.push('/profile');
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
              items: options
                  .map((option) => BottomNavigationBarItem(
                      icon: Icon(option.icon), label: option.name))
                  .toList(),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            )),
        body: Center(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: MAX_WIDTH,
          ),
          child: widget.child,
        )));
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
            onSubmitted: (String value) {
              _search(); // Assuming _search is a method that handles the search logic
            },
          )),
          IconButton(
              onPressed: _search,
              icon: const Icon(Icons.search, color: kPrimaryLabelColor))
        ]));
  }
}
