import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stronghold_ofw/modules/shared_widgets/textfield.dart';

import '../../contants/measure.dart';
import '../models/dependent/dependent.dart';
import '../shared_widgets/dialogs.dart';
import '../shared_widgets/popup_containers.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final CarouselController carouselCtrler = CarouselController();
  final _formKey = GlobalKey<FormState>();
  final _current$ = BehaviorSubject<int>.seeded(0);

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleName = TextEditingController();
  final presentAddress = TextEditingController();
  final provincialAddress = TextEditingController();
  // var dateOfBirth = DateTime.now();
  final dateOfBirth = TextEditingController();
  final placeOfBirth = TextEditingController();
  final nationality = TextEditingController();
  final gender = TextEditingController();
  final civilStatus = TextEditingController();
  final religion = TextEditingController();
  final email = TextEditingController();
  final mobileNumber = TextEditingController();
  final telNumber = TextEditingController();
  final passportNumber = TextEditingController();
  // var expiryDate = DateTime.now();
  final expiryDate = TextEditingController();
  final sssNumber = TextEditingController();
  final tinNumber = TextEditingController();
  final _dependents = BehaviorSubject<List<Dependent>>.seeded([]);
  final agent = TextEditingController();
  final employerName = TextEditingController();
  final employerAddress = TextEditingController();
  final termOfContract = TextEditingController();
  final position = TextEditingController();
  // var effectiveDate = DateTime.now();
  final effectiveDate = TextEditingController();
  final recruitmentAgency = TextEditingController();
  final employmentContactNumber = TextEditingController();
  final natureOfBusiness = TextEditingController();
  final countryOfDeployment = TextEditingController();
  // var employmentDate = DateTime.now();
  final employmentDate = TextEditingController();

  final nameDependent = TextEditingController();
  final relationshipDependent = TextEditingController();
  final dateOfBirthDependent = TextEditingController();
  final sharingDependent = TextEditingController();
  final revocableDependent = TextEditingController();

  //     @Default('') String id,
//     @Default('') String lastName,
//     @Default('') String firstName,
//     @Default('') String middleName,
//     @Default('') String presentAddress,
//     @Default('') String provincialAddress,
//     DateTime? dateOfBirth,
//     @Default('') String placeOfBirth,
//     @Default('') String nationality,
//     @Default('') String gender,
//     @Default('') String religion,
//     @Default('') String civilStatus,
//     @Default('') String email,
//     @Default('') String mobileNumber,
//     @Default('') String telNumber,
//     @Default('') String passportNumber,
//     DateTime? expiryDate,
//     @Default('') String sssNumber,
//     @Default('') String tinNumber,
//     @Default([]) List<Dependent> dependents,
//     @Default('') String agent,
//     @Default('') String employer,
//     @Default('') String address,
//     @Default('') String termOfContract,
//     @Default('') String position,
//     DateTime? effectiveDate,
//     @Default('') String recruitmentAgency,
//     @Default('') String employmentContactNumber,
//     @Default('') String natureOfBusiness,
//     @Default('') String countryOfDeployment,
//     @Default('') String dateOfEmployment,
//     @Default('') String occupation,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 65.0),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    previousButton(),
                    StreamBuilder<int>(
                        stream: _current$,
                        builder: (context, snapshot) {
                          final val = snapshot.hasData ? snapshot.data : 0;
                          return Column(
                            children: [
                              Text(
                                pageTitles(val!),
                                style: TextStyle(color: Colors.blue),
                              ),
                              pageIndicator(val),
                            ],
                          );
                        }),
                    nextButton(),
                  ],
                ),
                const Divider(
                  height: 1,
                ),
                pagesContainer(),
              ]),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   left: 0,
          //   child: Container(
          //     color: Colors.white,
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         cancelButton(),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         saveButton()
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget previousButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        carouselCtrler.previousPage();
      },
    );
  }

  Widget nextButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_forward_ios),
      onPressed: () {
        carouselCtrler.nextPage();
      },
    );
  }

  String pageTitles(int current) {
    if (current == 0) {
      return 'Personal Info';
    }
    if (current == 1) {
      return 'Dependent';
    }
    if (current == 2) {
      return 'Employment';
    } else {
      return 'Summary';
    }
  }

  Widget pageIndicator(int val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList(context).asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => carouselCtrler.animateToPage(entry.key),
          child: Container(
            width: 7.0,
            height: 7.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(val == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  List<Widget> imgList(BuildContext context) => [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          spacing: 25.0,
          runSpacing: 20.0,
          children: [
            textField(
              lastName,
              '*Last Name',
            ),
            textField(
              firstName,
              '*First Name',
            ),
            textField(
              middleName,
              'Middle Name',
            ),
            TextFieldShared(
              constraints: const BoxConstraints(maxWidth: 500),
              maxLines: 3,
              ctrler: presentAddress,
              labelText: '*Present Address',
            ),
            TextFieldShared(
              constraints: const BoxConstraints(maxWidth: 500),
              maxLines: 3,
              ctrler: provincialAddress,
              labelText: 'Provincial Address',
            ),
            textFieldDate(dateOfBirth, '*Date of Birth'),
            textField(
              placeOfBirth,
              '*Place of Birth',
            ),
            textField(nationality, '*Nationality'),
            textField(gender, '*Gender'),
            textField(religion, '*Religion'),
            textField(civilStatus, '*Civil Status'),
            textField(email, '*E-mail Address'),
            textField(mobileNumber, 'Mobile Number'),
            textField(telNumber, 'Telephone Number'),
            textField(passportNumber, '*Passport Number'),
            textFieldDate(
              expiryDate,
              '*Expiry Date',
            ),
            textField(sssNumber, 'SSS Number'),
            textField(
              tinNumber,
              'TIN',
            ),
          ],
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<List<Dependent>>(
                  stream: _dependents,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox();
                    }
                    if (snapshot.data!.isEmpty) {
                      return const SizedBox();
                    }

                    final data = snapshot.data;

                    return Column(
                      children: [
                        ...data!
                            .map((x) => Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(x.name),
                                          Text(x.relationshipToInsured)
                                        ],
                                      ),
                                      onTap: () {},
                                      contentPadding: const EdgeInsets.all(5),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (x.dateOfBirth != null)
                                                Text(DateFormat('dd/MM/yyyy')
                                                    .format(x.dateOfBirth!)),
                                              Text('Share ${x.sharing}%'),
                                              Text(x.revocability)
                                            ]),
                                      ),
                                    ),
                                    const Divider(
                                      height: 2,
                                    )
                                  ],
                                ))
                            .toList()
                      ],
                    );
                  }),
              const SizedBox(height: 25),
              FloatingActionButton.extended(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialogShared(
                        context,
                        Container(
                          constraints: const BoxConstraints(maxHeight: 500),
                          // height: 220,
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Dependent Information',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    textField(nameDependent, 'Full Name'),
                                    const SizedBox(height: 20),
                                    textField(relationshipDependent,
                                        'Relationship to this person'),
                                    const SizedBox(height: 20),
                                    textFieldDate(
                                        dateOfBirthDependent, 'Date of Birth'),
                                    const SizedBox(height: 20),
                                    textField(
                                        sharingDependent, 'Sharing ( % )'),
                                    const SizedBox(height: 20),
                                    textField(revocableDependent, 'Revocable?'),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: ElevatedButton(
                                    child: const Text('Add Dependent'),
                                    onPressed: () async {
                                      final date =
                                          dateOfBirthDependent.text.split('/');
                                      final dependent = Dependent(
                                          name: nameDependent.text,
                                          relationshipToInsured:
                                              relationshipDependent.text,
                                          dateOfBirth: DateTime.parse(
                                              '${date[2]}-${date[1]}-${date[0]}'),
                                          revocability: revocableDependent.text,
                                          sharing: sharingDependent.text);
                                      if (_dependents.value.isEmpty) {
                                        _dependents.add([dependent]);
                                      } else {
                                        _dependents.add(
                                            [..._dependents.value, dependent]);
                                      }
                                      Navigator.pop(context);
                                    }),
                              ),
                            ],
                          ),
                        ));
                  },
                  label: const Text('Add dependent'))
            ]),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        ),
      ];

  Widget textField(TextEditingController ctrler, String labelText) {
    return TextFieldShared(
      constraints: isWeb(context) ? const BoxConstraints(maxWidth: 300) : null,
      ctrler: ctrler,
      labelText: labelText,
    );
  }

  Card container(Widget child) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(isWeb(context) ? 30.0 : 20),
        child: child,
      ),
    );
  }

  Widget textFieldDate(TextEditingController ctrler, String labelText) {
    return TextFieldShared(
      ctrler: ctrler,
      labelText: labelText,
      readOnly: true,
      constraints: const BoxConstraints(maxWidth: 300),
      onTap: () {
        print('onTap');
        selectPopupDate(context, ctrler);
      },
    );
  }

  Widget pagesContainer() {
    return CarouselSlider(
      items: imageSliders(context),
      carouselController: carouselCtrler,
      options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          height: MediaQuery.of(context).size.height * .80,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            _current$.add(index);
          }),
    );
  }

  List<Widget> imageSliders(BuildContext context) => imgList(context)
      .map((item) => Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(child: container(item)),
          ))
      .toList();
}
