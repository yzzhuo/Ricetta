import 'package:go_router/go_router.dart';
import 'package:Ricetta/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/screens/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
        body:
            user == null ? const LoginScreen() : const PorfileContentScreen());
  }
}

class PorfileContentScreen extends ConsumerStatefulWidget {
  const PorfileContentScreen({super.key});

  @override
  _PorfileContentScreen createState() => _PorfileContentScreen();
}

class _PorfileContentScreen extends ConsumerState<PorfileContentScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteRecipes = [];
    final myRecipes = [];

    return Scaffold(
        appBar: AppBar(
            title: const Text('Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                )),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  context.push('/settings');
                },
              )
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/recipe/edit');
          },
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).primaryColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TabBar(
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    text: 'Favourites',
                  ),
                  Tab(
                    text: 'My Recipes',
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                favouriteRecipes.isEmpty
                    ? const Center(
                        child:
                            Text("You don't have any favourites recipes yet."))
                    : ListView(
                        children: const [],
                      ),
                myRecipes.isEmpty
                    ? const Center(
                        child: Text("You don't have any recipes yet."))
                    : ListView(
                        children: const [],
                      ),
              ]))
            ])));
  }
}
