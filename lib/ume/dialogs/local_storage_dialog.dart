import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class LocalStorageDialog extends StatelessWidget {
  const LocalStorageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = CoreLocalStorage.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Storage'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: storage.entries.length,
          itemBuilder: (BuildContext context, int index) {
            var entry = storage.entries.elementAt(index);
            return InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value.toString(),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
        ),
      ),
    );
  }
}
