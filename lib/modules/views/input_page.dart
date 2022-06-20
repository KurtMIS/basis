import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stronghold_ofw/modules/shared_widgets/textfield.dart';
import '../../constants/measure.dart';
import '../../services/locator.dart';
import '../../utils/date_convert.dart';
import '../logics/input.dart';
import '../models/dependent/dependent.dart';
import '../models/info/info.dart';
import '../shared_widgets/dialogs.dart';
import '../shared_widgets/popup_containers.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final input = locator.get<Input>();

  final CarouselController carouselCtrler = CarouselController();
  final _formKey = GlobalKey<FormState>();
  final _current$ = BehaviorSubject<int>.seeded(0);

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleName = TextEditingController();
  final presentAddress = TextEditingController();
  final provincialAddress = TextEditingController();
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
  final expiryDate = TextEditingController();
  final sssNumber = TextEditingController();
  final tinNumber = TextEditingController();
  final _dependents = BehaviorSubject<List<Dependent>>.seeded([]);
  final agent = TextEditingController()..text = 'Koronadal Branch';
  final employerName = TextEditingController();
  final employerAddress = TextEditingController();
  final termOfContract = TextEditingController();
  final position = TextEditingController();
  final effectiveDate = TextEditingController();
  final recruitmentAgency = TextEditingController()
    ..text = 'Direct Hire - Koronadal';
  final employmentContactNumber = TextEditingController();
  final natureOfBusiness = TextEditingController();
  final countryOfDeployment = TextEditingController();
  final employmentDate = TextEditingController();

  final nameDependent = TextEditingController();
  final relationshipDependent = TextEditingController();
  final dateOfBirthDependent = TextEditingController();
  final sharingDependent = TextEditingController();
  final revocableDependent = TextEditingController();
  String docIdFromCurrentDate() => DateTime.now().toIso8601String();

  void setInfo() async {
    final res =
        await showConfirmDialog(context, 'Are you sure you want to proceed');
    if (!res) {
      return;
    }
    input.setInfo(Info(
        id: docIdFromCurrentDate() +
            stringToDate(dateOfBirth.text).toIso8601String(),
        presentAddress: presentAddress.text,
        agent: agent.text,
        civilStatus: civilStatus.text,
        countryOfDeployment: countryOfDeployment.text,
        dateOfBirth: dateOfBirth.text,
        dateOfEmployment: employmentDate.text,
        dependents: _dependents.value.map((e) => e.toJson()).toList(),
        email: email.text,
        effectiveDate: effectiveDate.text,
        employer: employerName.text,
        employmentContactNumber: employmentContactNumber.text,
        expiryDate: expiryDate.text,
        firstName: firstName.text,
        gender: gender.text,
        lastName: lastName.text,
        middleName: middleName.text,
        mobileNumber: mobileNumber.text,
        nationality: nationality.text,
        natureOfBusiness: natureOfBusiness.text,
        passportNumber: passportNumber.text,
        placeOfBirth: placeOfBirth.text,
        position: position.text,
        address: employerAddress.text,
        provincialAddress: provincialAddress.text,
        recruitmentAgency: recruitmentAgency.text,
        religion: religion.text,
        sssNumber: sssNumber.text,
        telNumber: telNumber.text,
        termOfContract: termOfContract.text,
        tinNumber: tinNumber.text));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      presentAddress.text = 'presentAddress';
      agent.text = 'agent';
      civilStatus.text = 'civilStatus';
      countryOfDeployment.text = 'countryOfDeployment';
      dateOfBirth.text = '10/10/1988';
      employmentDate.text = '22/06/2021';
      email.text = 'email';
      effectiveDate.text = '22/07/2022';
      employerName.text = 'employerName';
      employmentContactNumber.text = 'employmentContactNumber';
      expiryDate.text = '10/05/2025';
      firstName.text = 'firstName';
      gender.text = 'male';
      lastName.text = 'lastname';
      middleName.text = 'middleNAME';
      mobileNumber.text = '12345678';
      nationality.text = 'nationality';
      natureOfBusiness.text = 'natureOfBusiness';
      passportNumber.text = '111111111111';
      placeOfBirth.text = 'placeofbirth';
      position.text = 'position';
      employerAddress.text = 'employerAddress';
      provincialAddress.text = 'provincialAddress';
      recruitmentAgency.text = 'recruitmentAgency';
      religion.text = 'religion';
      sssNumber.text = 'sssNumber';
      telNumber.text = 'telNumber';
      termOfContract.text = 'termOfContract';
      tinNumber.text = 'tinNumber';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isWeb(context)
          ? AppBar(
              title: const Text('Stronghold for OFW'),
            )
          : null,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SingleChildScrollView(
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

  List<Widget> imageSliders(BuildContext context) => imgList(context)
      .map((item) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 50),
              child: container(item),
            ),
          ))
      .toList();

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
              keyboardType: TextInputType.streetAddress,
            ),
            TextFieldShared(
                constraints: const BoxConstraints(maxWidth: 500),
                maxLines: 3,
                ctrler: provincialAddress,
                labelText: 'Provincial Address',
                keyboardType: TextInputType.streetAddress),
            textFieldDate(dateOfBirth, '*Date of Birth'),
            textField(
              placeOfBirth,
              '*Place of Birth',
            ),
            textField(nationality, '*Nationality', hintText: 'Filipino'),
            textField(gender, '*Gender', hintText: 'Male/Female'),
            textField(
              religion,
              '*Religion',
            ),
            textField(civilStatus, '*Civil Status', hintText: 'Single/Married'),
            textField(email, '*E-mail Address',
                hintText: 'delacruz@gmail.com',
                keyboardType: TextInputType.emailAddress),
            textField(mobileNumber, 'Mobile Number',
                keyboardType: TextInputType.phone),
            textField(telNumber, 'Telephone Number',
                keyboardType: TextInputType.phone),
            textField(passportNumber, '*Passport Number',
                keyboardType: TextInputType.number),
            textFieldDate(
              expiryDate,
              '*Expiry Date',
            ),
            textField(sssNumber, 'SSS Number',
                keyboardType: TextInputType.number),
            textField(tinNumber, 'TIN', keyboardType: TextInputType.number),
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
                                    textField(sharingDependent, 'Sharing ( % )',
                                        keyboardType: TextInputType.number),
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
        Column(
          children: [
            const Text(
              '*All fields are required*',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 25.0,
              runSpacing: 20.0,
              children: [
                textField(agent, 'Agent', readOnly: true),
                textField(recruitmentAgency, 'Recruitment Agency',
                    readOnly: true),
                textField(
                  employerName,
                  'Employer Name',
                ),
                textField(employmentContactNumber, 'Employer Contact No.',
                    keyboardType: TextInputType.phone),
                TextFieldShared(
                    constraints: const BoxConstraints(maxWidth: 500),
                    maxLines: 3,
                    ctrler: employerAddress,
                    labelText: 'Employer Address',
                    keyboardType: TextInputType.streetAddress),
                // textField(termOfContract, 'Term of Contract:'),
                textFieldChoice(termOfContract, 'Term Of Contract'),
                textField(countryOfDeployment, 'Country of Deployment'),
                textField(natureOfBusiness, 'Nature of Business:'),
                textField(position, 'Position'),
                textFieldDate(
                  employmentDate,
                  'Date Of Employment',
                ),
                textFieldDate(
                  effectiveDate,
                  'Departure/Effective Date',
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Personal Information')),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 0.0,
              runSpacing: 10.0,
              children: [
                text(lastName, 'Last Name: '),
                text(
                  firstName,
                  'First Name',
                ),
                text(
                  middleName,
                  'Middle Name',
                ),
                textLong(presentAddress, 'Present Address'),
                textLong(provincialAddress, 'Provincial Address'),
                text(dateOfBirth, '*Date of Birth'),
                text(
                  placeOfBirth,
                  '*Place of Birth',
                ),
                text(nationality, '*Nationality'),
                text(gender, '*Gender'),
                text(religion, '*Religion'),
                text(civilStatus, '*Civil Status'),
                text(email, '*E-mail Address'),
                text(mobileNumber, 'Mobile Number'),
                text(telNumber, 'Telephone Number'),
                text(passportNumber, '*Passport Number'),
                text(
                  expiryDate,
                  '*Expiry Date',
                ),
                text(sssNumber, 'SSS Number'),
                text(
                  tinNumber,
                  'TIN',
                ),
              ],
            ),
            const Divider(),
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Dependent Info')),
            const SizedBox(height: 20),
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
                                    onTap: null,
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
            const Divider(),
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Employment Information')),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 0.0,
              runSpacing: 10.0,
              children: [
                text(lastName, 'Last Name: '),
                text(
                  firstName,
                  'First Name',
                ),
                text(
                  middleName,
                  'Middle Name',
                ),
                textLong(presentAddress, 'Present Address'),
                textLong(provincialAddress, 'Provincial Address'),
                text(dateOfBirth, '*Date of Birth'),
                text(
                  placeOfBirth,
                  '*Place of Birth',
                ),
                text(nationality, '*Nationality'),
                text(gender, '*Gender'),
                text(religion, '*Religion'),
                text(civilStatus, '*Civil Status'),
                text(email, '*E-mail Address'),
                text(mobileNumber, 'Mobile Number'),
                text(telNumber, 'Telephone Number'),
                text(passportNumber, '*Passport Number'),
                text(
                  expiryDate,
                  '*Expiry Date',
                ),
                text(sssNumber, 'SSS Number'),
                text(
                  tinNumber,
                  'TIN',
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                  child: ElevatedButton(
                onPressed: () {
                  setInfo();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Proceed'),
                ),
              )),
            )
          ],
        )
      ];

  Widget text(TextEditingController ctrler, String labelText) {
    return TextField(
      controller: ctrler,
      readOnly: true,
      keyboardType: TextInputType.none,
      enabled: false,
      decoration: InputDecoration(
        labelText: labelText,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }

  Widget textLong(TextEditingController ctrler, String labelText) {
    return TextFormField(
      controller: ctrler,
      readOnly: true,
      enabled: false,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.none,
      validator: (str) => str,
      // constraints:
      maxLines: 3,
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxWidth: 500),
        labelText: labelText,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }

  Widget textField(TextEditingController ctrler, String labelText,
      {bool? readOnly, TextInputType? keyboardType, String? hintText}) {
    return TextFieldShared(
      constraints: isWeb(context) ? const BoxConstraints(maxWidth: 300) : null,
      ctrler: ctrler,
      labelText: labelText,
      hintText: hintText,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
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

  Widget textFieldDate(
    TextEditingController ctrler,
    String labelText,
  ) {
    return TextFieldShared(
      ctrler: ctrler,
      labelText: labelText,
      readOnly: true,
      constraints: const BoxConstraints(maxWidth: 300),
      keyboardType: TextInputType.none,
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
          height: MediaQuery.of(context).size.height - 50,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index, reason) {
            _current$.add(index);
          }),
    );
  }

  Widget textFieldChoice(TextEditingController ctrler, String labelText) {
    return TextFieldShared(
        labelText: labelText,
        ctrler: termOfContract,
        keyboardType: TextInputType.none,
        constraints:
            isWeb(context) ? const BoxConstraints(maxWidth: 300) : null,
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          final result = await showDialog(
              context: context,
              builder: (_) => dialogChoiceShared(context,
                  list: ['12 months', '24 months', '36months'],
                  title: labelText,
                  ctrler: ctrler));
          if (result == null) {
            return;
          }
          termOfContract.text = result;
        });
  }
}
