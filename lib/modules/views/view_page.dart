import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import '../../constants/measure.dart';
import '../../services1/locator.dart';
import '../../utils/debouncer.dart';
import '../logics/input.dart';
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
  final input = locator.get<Input>();
  final emailCtrler = TextEditingController();
  final dateCtrler = TextEditingController();
  final paidDropDown$ = BehaviorSubject<int>.seeded(0);
  final doneDropDown$ = BehaviorSubject<int>.seeded(0);
  final debouncer = Debouncer(delay: const Duration(milliseconds: 1000));

  void refresh({bool? cancel}) {
    if (cancel == null) view.cancelSubscription();
    debouncer.run(() => view.getInfos(Info(
        firstName: '${paidDropDown$.value}',
        lastName: '${doneDropDown$.value}',
        email: emailCtrler.text,
        submissionDate: dateCtrler.text,
        position:
            (dateCtrler.text.trim().isEmpty || emailCtrler.text.isNotEmpty)
                ? 'searching'
                : '')));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      refresh(cancel: true);
      locator.get<Input>().isAdmin = true;
    });
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
                        refresh();
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Submission Date',
                    constraints: const BoxConstraints(maxWidth: 200)),
              ),
              TextFormField(
                controller: emailCtrler,
                onChanged: (_) {
                  // if (_.trim().length > 2) {
                  debouncer.run(() async {
                    refresh();
                  });

                  // }
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        emailCtrler.clear();
                        refresh();
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'email',
                    constraints: const BoxConstraints(maxWidth: 200)),
              ),
              dropDown(['All', 'Paid', 'Not Paid'], paidDropDown$, () {
                refresh();
              }),
              // const SizedBox(width: 5),
              dropDown(['All', 'Emailed', 'Not Emailed'], doneDropDown$, () {
                refresh();
              })
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
                final summary = view.summary;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Text('Paid:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)),
                                  const SizedBox(width: 10),
                                  Text('${summary['paid']}'),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  const Text('Emailed:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  const SizedBox(width: 10),
                                  Text('${summary['done']}'),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  const Text('Total:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  Text('${summary['total']}'),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              input.info = Info();
                              Navigator.pushNamed(context, 'input');
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.add),
                                const SizedBox(width: 10),
                                isWeb(context)
                                    ? const Text('Add New')
                                    : const Text('New')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListItemsBuilder<Info>(
                          divided: true,
                          snapshot: snapshot,
                          itemBuilder: (context, data) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    input.info = data;
                                    Navigator.pushNamed(context, 'input');
                                  },
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${data.lastName}, ${data.firstName}  ${(isWeb(context) ? data.lastName : '')}'),
                                      Row(children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: data.isPaid
                                                  ? Colors.blue
                                                  : Colors.white),
                                          onPressed: () {
                                            view.updateInfo(
                                                data,
                                                {'isPaid': !data.isPaid},
                                                context);
                                          },
                                          child: Text(
                                              data.isPaid ? 'Paid' : 'Not paid',
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
                                                data,
                                                {'isDone': !data.isDone},
                                                context);
                                          },
                                          child: Text(
                                              data.isDone
                                                  ? 'Emailed'
                                                  : 'Not emailed',
                                              style: TextStyle(
                                                  color: data.isDone
                                                      ? Colors.white
                                                      : Colors.green)),
                                        )
                                      ]),
                                    ],
                                  ),
                                  subtitle: Text(
                                      'Email: ${data.email}   ${(isWeb(context) ? 'Birthday: ${data.dateOfBirth}' : '')}'),
                                ),
                                const Divider(
                                  height: 3,
                                  thickness: 2,
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget dropDown(
      List<String> servers, BehaviorSubject<int> idx, dynamic func) {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxWidth: 150),
      child: StreamBuilder<int>(
          stream: idx,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const SizedBox();
            }
            final data = snapshot.data;
            return PopupMenuButton(
              constraints: const BoxConstraints(maxWidth: 150),
              // initialValue: 2,
              onSelected: (_) async {
                // await schedProv.removeLocalCredential();
                // Navigator.pushReplacementNamed(context, 'login');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(servers.elementAt(data!), style: const TextStyle()),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ],
              ),
              itemBuilder: (context) {
                return List.generate(3, (index) {
                  return PopupMenuItem(
                    onTap: () {
                      idx.add(index);
                      func();
                    },
                    value: index,
                    child: Text(
                      servers.elementAt(index),
                    ),
                  );
                });
              },
            );
          }),
    );
  }
}
