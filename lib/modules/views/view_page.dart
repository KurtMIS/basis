import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import '../../services/locator.dart';
import '../../utils/debouncer.dart';
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

  final emailCtrler = TextEditingController();
  final dateCtrler = TextEditingController();
  final isPaid$ = BehaviorSubject<bool>.seeded(false);
  final isDone$ = BehaviorSubject<bool>.seeded(false);
  final debouncer = Debouncer(delay: const Duration(milliseconds: 200));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      refresh();
    });
  }

  void refresh() {
    debouncer.run(() => view.getInfos(Info(
        isPaid: isPaid$.value,
        isDone: isDone$.value,
        email: emailCtrler.text,
        submissionDate: dateCtrler.text,
        position:
            (dateCtrler.text.trim().isEmpty || emailCtrler.text.isNotEmpty)
                ? 'searching'
                : '')));
  }

  selectPopupDate(
      BuildContext? context, TextEditingController dateCtrler) async {
    final selected = await showDatePicker(
      context: context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != DateTime.now()) {
      dateCtrler.text = DateFormat('dd/MM/yyyy').format(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: list());
  }

  Widget list() {
    return Column(
      children: [
        Container(
          color: Colors.blue.shade100,
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            // crossAxisAlignment: WrapCrossAlignment.start,
            // alignment: WrapAlignment.start,
            spacing: 25.0,
            runSpacing: 20.0,
            children: [
              TextFormField(
                controller: dateCtrler,
                onTap: () async {
                  await selectPopupDate(context, dateCtrler);
                  refresh();
                },
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        dateCtrler.clear();
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Submission Date',
                    constraints: const BoxConstraints(maxWidth: 200)),
              ),
              // const SizedBox(width: 20),
              TextFormField(
                controller: emailCtrler,
                onChanged: (_) {
                  if (_.trim().length > 2) {
                    refresh();
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        emailCtrler.clear();
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'email',
                    constraints: const BoxConstraints(maxWidth: 200)),
              ),
              // const SizedBox(width: 20),
              StreamBuilder<bool>(
                  stream: isPaid$,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    return FloatingActionButton.extended(
                      elevation: 0.0,
                      backgroundColor:
                          snapshot.data! ? Colors.blue : Colors.grey,
                      onPressed: () {
                        isPaid$.add(!snapshot.data!);
                        refresh();
                      },
                      label: const Text('Paid'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    );
                  }),
              // const SizedBox(width: 20),
              StreamBuilder<bool>(
                  stream: isDone$,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    return FloatingActionButton.extended(
                      elevation: 0.0,
                      backgroundColor:
                          snapshot.data! ? Colors.blue : Colors.grey,
                      onPressed: () {
                        isDone$.add(!snapshot.data!);
                        refresh();
                      },
                      label: const Text('Done'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    );
                  }),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Info>>(
              stream: view.infoList$,
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
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.firstName),
                            Row(children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: data.isPaid
                                        ? Colors.green
                                        : Colors.white),
                                onPressed: () {
                                  view.updateInfo(
                                      data, {'isPaid': !data.isPaid}, context);
                                },
                                child: Text(
                                    data.isPaid ? 'Paid' : 'Mark as paid',
                                    style: TextStyle(
                                        color: data.isPaid
                                            ? Colors.white
                                            : Colors.blue)),
                              ),
                              if (data.isPaid || data.isPaid)
                                const SizedBox(width: 15),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: data.isDone
                                        ? Colors.green
                                        : Colors.white),
                                onPressed: () {
                                  view.updateInfo(
                                      data, {'isDone': !data.isDone}, context);
                                },
                                child: Text(
                                    data.isDone ? 'Done' : 'Mark as done',
                                    style: TextStyle(
                                        color: data.isDone
                                            ? Colors.white
                                            : Colors.blue)),
                              )
                            ]),
                          ],
                        ),
                        subtitle: Text(data.dateOfBirth),
                      );
                    });
              }),
        ),
      ],
    );
  }
}
