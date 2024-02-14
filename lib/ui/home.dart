import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter/main.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool hasData = false;

  List<Program> programs = [];

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOME PAGE - (${programs.length}) programs")),
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    downloadPrograms();
                    //downloadProgram('yIbORstm9tF');
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
          Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    downloadTEIS();
                    //downloadProgram('yIbORstm9tF');
                  },
                  child: const Text("Download Trackers"),
                ),
                TextButton(
                  onPressed: () {
                    getPrograms();
                  },
                  child: const Text("Get Trackers"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              itemCount: programs.length,
              itemBuilder: (BuildContext context, int index) {
                Program program = programs[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(program.name!),
                      leading: Container(
                        height: double.infinity,
                        width: 5,
                        color: Colors.blue,
                      ),
                      horizontalTitleGap: 5.0,

                      // Add onTap if you want to handle tap events on each item
                      // onTap: () {
                      //   // Handle onTap event
                      // },
                    ),
                    const Divider(color: Colors.grey,height: 2),
                    const SizedBox(height: 5)
                  ],
                );
              },
            ),
          ),
        ],
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
    await d2repository.programModule.program.download(
      (progress, complete) {
        debugPrint("PROGRESS:: ${progress.message}");
      },
    );
  }

  // See the response in console
  Future downloadTEIS() async {
    await d2repository.trackerModule.trackedEntityInstance
        .byOrgUnit('LJX5GuypkKy')
        .byProgram("yIbORstm9tF")
        .download(
      (progress, complete) {
        debugPrint("PROGRESSTEI:: ${progress.message}");
      },
    );
  }

  Future downloadProgram(String id) async {
    try {
      await d2repository.programModule.program.byIds([id]).download(
        (progress, complete) {
          debugPrint("PROGRESS:: ${progress.message}");
        },
      );
    } catch (error) {
      debugPrint("$error");
    }
  }

  // See the response in console
  Future<void> getPrograms() async {
    try {
      List<Program> fetchedPrograms = await d2repository.programModule.program.get();
      setState(() {
        programs = fetchedPrograms;
      });
      debugPrint("MY PROGRAMS:: ${programs.length}");
    } catch (error) {
      debugPrint("$error");
    }
  }
}
