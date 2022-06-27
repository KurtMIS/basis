import 'package:flutter/material.dart';

import '../../services/locator.dart';
import '../logics/view.dart';
import '../models/info/info.dart';
import '../shared_widgets/lists.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final view = locator.get<View>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: list());
  }

  Widget list() {
    return StreamBuilder<List<Info>>(
        stream: view.getInfos(Info()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListItemsBuilder<Info>(
              divided: true,
              snapshot: snapshot,
              itemBuilder: (context, data) {
                return ListTile(
                  // onTap: () async => await view
                  // .setInfo(data.copyWith(isPaid: true, isDone: true)),
                  title: Text(data.firstName),
                  subtitle: Text(data.dateOfBirth),
                );
              });
        });
  }
}
