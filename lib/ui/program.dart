import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter/main.dart';
import 'package:flutter/material.dart';

class ProgramScreeen extends StatefulWidget {
  final Program program;
  const ProgramScreeen({super.key, required this.program});

  @override
  State<ProgramScreeen> createState() => _ProgramScreeenState();
}

class _ProgramScreeenState extends State<ProgramScreeen> {
  Program get program => widget.program;
  List<TrackedEntityInstance> teis = [];

  @override
  void initState() {
    getTEIs(program.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Program: ${program.name}"),
            Text("Description: ${program.description}"),
            Text("Created: ${program.created}"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                downloadTEIS();
              },
              child: const Text("Sync tracked Entity Instances"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tracked Entity Instances list",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              //color: Colors.amber,
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                itemCount: teis.length,
                itemBuilder: (BuildContext context, int index) {
                  TrackedEntityInstance tei = teis[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(tei.name!),
                        horizontalTitleGap: 5.0,
                        onTap: () {},
                      ),
                      const Divider(color: Colors.grey, height: 2),
                      const SizedBox(height: 5)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // See the response in console
  Future downloadTEIS() async {
    await d2repository.trackerModule.trackedEntityInstance
        .byOrgUnit('LJX5GuypkKy')
        .byProgram(program.id!)
        .download(
      (progress, complete) {
        debugPrint("PROGRESS_TEI:: ${progress.message}");
        if (complete) getTEIs(program.id!);
      },
    );
  }

  Future<void> getTEIs(program) async {
    try {
      List<TrackedEntityInstance> fetchedTeis = await d2repository
          .trackerModule.trackedEntityInstance
          .byProgram(program)
          .get();
      setState(() {
        teis = fetchedTeis;
      });
      debugPrint("MY TEIS:: ${teis.length}");
    } catch (error) {
      debugPrint("$error");
    }
  }
}
