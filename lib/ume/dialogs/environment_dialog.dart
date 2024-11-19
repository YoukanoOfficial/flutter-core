import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_core/storage/local_storage.dart';
import '../../network/models/environment.dart';
import '../../pattern/core_global.dart';

class EnvironmentDialog extends StatefulWidget {
  const EnvironmentDialog({Key? key}) : super(key: key);

  @override
  State<EnvironmentDialog> createState() => _EnvironmentDialog();
}

class _EnvironmentDialog extends State<EnvironmentDialog> {
  final List<Environment> environment = CoreGlobal.environment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environment'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: environment.length,
                itemBuilder: (BuildContext context, int index) {
                  final String key = environment[index].key;
                  final String name = environment[index].name;
                  final String seleced = environment[index].seleced ?? '';
                  final String prodUrl = environment[index].prodUrl;
                  final String testUrl = environment[index].testUrl;
                  final String devUrl = environment[index].devUrl;
                  late Map<String, String> env = {};

                  env.addAll({'Production': prodUrl});
                  env.addAll({'Testing': testUrl});
                  env.addAll({'Development': devUrl});
                  env.addAll(environment[index].otherUrl ?? {});

                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 15,
                          ),
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: env.length,
                          itemBuilder: (BuildContext context, int indexEnv) {
                            final String nameEnv = env.keys.elementAt(indexEnv);
                            final String valueEnv =
                                env.values.elementAt(indexEnv);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  environment[index].seleced = valueEnv;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  nameEnv,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  valueEnv,
                                                  textAlign: TextAlign.end,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: seleced == valueEnv,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors
                              .grey; // Set the desired color for disabled state
                        }
                        return Theme.of(context).primaryColor;
                      },
                    ),
                  ),
                  onPressed: () {
                    if (environment.isEmpty) return;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Exit App"),
                          content: const Text(
                              "Are you sure, You want to exit the app?"),
                          actions: [
                            ElevatedButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: const Text("Confirm"),
                              onPressed: () async {
                                await CoreLocalStorage.removeAll();
                                Navigator.of(context).pop();
                                for (var i = 0; i < environment.length; i++) {
                                  await CoreLocalStorage.save(
                                      environment[i].key,
                                      environment[i].seleced);
                                  if (i == environment.length - 1) {
                                    await Future.delayed(
                                        Duration(milliseconds: 1000));
                                    exit(0);
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Update'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
