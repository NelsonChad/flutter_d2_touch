import 'package:dhis2_flutter/main.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool hasData = false;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HOME PAGE")),
      body: Container(
        color: Colors.amber,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                downloadPrograms();
              },
              child: const Text("Download programs"),
            ),
            TextButton(
              onPressed: () {
                getPrograms();
              },
              child: const Text("Get programs"),
            ),
          ],
        ),
      ),
    );
  }

  void getProfile() async {
    var user = await d2repository.userModule.user
        .withAuthorities()
        .withRoles()
        .getOne();
    bool isAuth = await d2repository.authModule.isAuthenticated();

    debugPrint("IsAuth:::::$isAuth");
    debugPrint("USER::${user?.toJson()}");
  }

  // See the response in console
  Future downloadPrograms() async {
    try {
      await d2repository.programModule.program.download(
        (progress, complete) {
          debugPrint("PROGRESS:: ${progress.message}");
        },
      );
    } catch (error) {
      debugPrint("$error");
    }
  }

  // See the response in console
  Future getPrograms() async {
    var programs = await d2repository.programModule.program.get();
    debugPrint("MY PROGRAMS:: ${programs.toString()}");
  }
}
