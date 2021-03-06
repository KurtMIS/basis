import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stronghold_ofw/modules/shared_widgets/textfield.dart';
import '../../constants/measure.dart';
import '../../services/locator.dart';
import '../../utils/future_image.dart';
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
  final inputBloc = locator.get<Input>();

  final CarouselController carouselCtrler = CarouselController();
  // final _formKey = GlobalKey<FormState>();
  final _current$ = BehaviorSubject<int>.seeded(0);
  final _selectedPayment$ = BehaviorSubject<int>.seeded(0);

  final ScrollController scrollCtrler = ScrollController();

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
  final paymentMethod = '';
  var passportImagePath = '';
  var receiptImagePath = '';
  var id = '';
  String docIdFromCurrentDate() => DateTime.now().toIso8601String();

  void setInfo() async {
    final res =
        await showConfirmDialog(context, 'Are you sure you want to proceed');
    if (!res) {
      return;
    }
    await inputBloc.setInfo(
        Info(
            id: id,
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
            // expiryDate: expiryDate.text,
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
            tinNumber: tinNumber.text,
            isDone: false,
            isPaid: false,
            passportImagePath: passportImagePath,
            paymentMethod: _selectedPayment$.value.toString(),
            submissionDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            receiptImagePath: receiptImagePath),
        context);
    //done
    Navigator.pushReplacementNamed(context, 'view');
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final info = inputBloc.info;
      if (info.id != '') {
        id = info.id;
        presentAddress.text = info.presentAddress;
        agent.text = info.agent;
        civilStatus.text = info.civilStatus;
        countryOfDeployment.text = info.countryOfDeployment;
        dateOfBirth.text = info.dateOfBirth;
        employmentDate.text = info.dateOfEmployment;
        email.text = info.email;
        effectiveDate.text = info.effectiveDate;
        employerName.text = info.employer;
        employmentContactNumber.text = info.employmentContactNumber;
        // expiryDate.text = info.expiryDate;
        firstName.text = info.firstName;
        gender.text = info.gender;
        lastName.text = info.lastName;
        middleName.text = info.middleName;
        mobileNumber.text = info.mobileNumber;
        nationality.text = info.nationality;
        natureOfBusiness.text = info.natureOfBusiness;
        // passportNumber.text = info.pass;
        placeOfBirth.text = info.placeOfBirth;
        position.text = info.position;
        employerAddress.text = info.address;
        provincialAddress.text = info.provincialAddress;
        recruitmentAgency.text = info.recruitmentAgency;
        religion.text = info.religion;
        sssNumber.text = info.sssNumber;
        telNumber.text = info.telNumber;
        termOfContract.text = info.termOfContract;
        tinNumber.text = info.tinNumber;
        inputBloc.passportImage$.add(info.passportImagePath);
        inputBloc.receiptImage$.add(info.receiptImagePath);

        Future.delayed(const Duration(milliseconds: 200), () {
          _current$.add(3);
          carouselCtrler.jumpToPage(3);
          _selectedPayment$.add(int.parse(info.paymentMethod));
        });
      } else {
        inputBloc.passportImage$.add('');
        inputBloc.receiptImage$.add('');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          // appBar: isWeb(context)
          // ?
          AppBar(
        title: const Text('Stronghold for OFW'),
      ),
      // : null,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollCtrler.animateTo(
              scrollCtrler.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          },
          child: const Icon(Icons.arrow_downward)),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
                                style: const TextStyle(color: Colors.blue),
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
            controller: scrollCtrler,
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
                keyboardType: TextInputType.emailAddress,
                onChanged: 'test'),
            textField(mobileNumber, 'Mobile Number',
                keyboardType: TextInputType.phone),
            textField(telNumber, 'Telephone Number',
                keyboardType: TextInputType.phone),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Passport',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const SizedBox(height: 15),
                          const Text('Attach image:'),
                          Align(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    if (email.text.isEmpty) {
                                      showToast('Email is required');
                                      return;
                                    }
                                    passportImagePath =
                                        await inputBloc.pickImage(
                                            false,
                                            id,
                                            'passport',
                                            inputBloc.passportImage$);
                                  },
                                  splashRadius: 30,
                                  iconSize: 40,
                                  padding: const EdgeInsets.all(30),
                                  icon: const Icon(
                                    Icons.image_outlined,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (email.text.isEmpty) {
                                      showToast('Email is required');
                                      return;
                                    }
                                    await inputBloc.pickImage(true, id,
                                        'passport', inputBloc.passportImage$);
                                  },
                                  splashRadius: 30,
                                  iconSize: 40,
                                  padding: const EdgeInsets.all(30),
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: StreamBuilder<String>(
                                stream: inputBloc.passportImage$,
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const SizedBox();
                                  }
                                  if (snapshot.data == '') {
                                    return const Center(
                                        child: Text('No image'));
                                  }
                                  final complete = Completer();
                                  complete.complete(snapshot.data);
                                  return GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (_) => imageDialog(
                                              tag: snapshot.data!,
                                              context: context));
                                    },
                                    child: ImageWithState(
                                        height: 50,
                                        width: 50,
                                        futureUrl: complete.future.then((t) {
                                          return t.toString();
                                        })),
                                  );
                                }),
                          ),
                          const Text(
                            '*Image must be clear',
                            style: TextStyle(
                                fontStyle: FontStyle.italic, color: Colors.red),
                          )
                        ]),
                  ),
                )),
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
                                    textField(revocableDependent, 'Revocable?',
                                        hintText: 'Yes or No only'),
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
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Payment Options')),
            StreamBuilder<int>(
                stream: _selectedPayment$,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox();
                  }
                  final data = snapshot.data;
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          if (data == 1) {
                            _selectedPayment$.add(0);
                            return;
                          }
                          _selectedPayment$.add(1);
                        },
                        title: const Text('Pay to agent'),
                        leading: data == 1
                            ? const Icon(Icons.circle_rounded,
                                color: Colors.green)
                            : const Icon(Icons.circle_outlined),
                        // subtitle: Text('09207433898'),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          if (data == 2) {
                            _selectedPayment$.add(0);
                            return;
                          }
                          _selectedPayment$.add(2);
                        },
                        title: const Text('GCASH'),
                        subtitle: const Text('09207433898'),
                        leading: data == 2
                            ? const Icon(Icons.circle_rounded,
                                color: Colors.green)
                            : const Icon(Icons.circle_outlined),
                      ),
                      const Divider(),
                      ListTile(
                        // trailing: Icon(Icons.),
                        onTap: () {
                          if (data == 3) {
                            _selectedPayment$.add(0);
                            return;
                          }
                          _selectedPayment$.add(3);
                        },
                        title: const Text('Bank Transfer'),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Account:   Jet Estacion'),
                            const Text('Account #: 8885-5555-5555'),
                            if (data == 3)
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Transaction Receipt'),
                                            const SizedBox(height: 15),
                                            const SizedBox(height: 15),
                                            const Text('Attach image:'),
                                            Align(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      receiptImagePath =
                                                          await inputBloc.pickImage(
                                                              false,
                                                              id,
                                                              'bank_receipt',
                                                              inputBloc
                                                                  .receiptImage$);
                                                    },
                                                    splashRadius: 25,
                                                    iconSize: 30,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    icon: const Icon(
                                                      Icons.image_outlined,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      receiptImagePath =
                                                          await inputBloc.pickImage(
                                                              true,
                                                              id,
                                                              'bank_receipt',
                                                              inputBloc
                                                                  .receiptImage$);
                                                    },
                                                    splashRadius: 25,
                                                    iconSize: 30,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    icon: const Icon(
                                                      Icons.camera_alt_outlined,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: StreamBuilder<String>(
                                                  stream:
                                                      inputBloc.receiptImage$,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.data == null) {
                                                      return const SizedBox();
                                                    }
                                                    if (snapshot.data == '') {
                                                      return const Center(
                                                          child:
                                                              Text('No image'));
                                                    }
                                                    final complete =
                                                        Completer();
                                                    complete.complete(
                                                        snapshot.data);
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        await showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                imageDialog(
                                                                    tag: snapshot
                                                                        .data!,
                                                                    context:
                                                                        context));
                                                      },
                                                      child: ImageWithState(
                                                          height: 30,
                                                          width: 30,
                                                          futureUrl: complete
                                                              .future
                                                              .then((t) => t
                                                                  .toString())),
                                                    );
                                                  }),
                                            ),
                                            const Text(
                                              '*Image must be clear',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.red),
                                            )
                                          ]),
                                    ),
                                  )),
                          ],
                        ),

                        leading: data == 3
                            ? const Icon(Icons.circle_rounded,
                                color: Colors.green)
                            : const Icon(Icons.circle_outlined),
                      ),
                      const Divider(),
                      const SizedBox(height: 30),
                    ],
                  );
                }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '*Process payment first before you send form',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(
                      child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(15)),
                    onPressed: () {
                      if (_selectedPayment$.value == 0) {
                        showToast('No payment option selected');
                        return;
                      }
                      setInfo();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Send Form', style: TextStyle(fontSize: 15)),
                    ),
                  )),
                ),
              ],
            )
          ],
        )
      ];

  Widget text(TextEditingController ctrler, String labelText) {
    return TextField(
      controller: ctrler,
      readOnly: true,
      keyboardType: TextInputType.none,
      enabled: true,
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
      {bool? readOnly,
      TextInputType? keyboardType,
      String? hintText,
      String? onChanged}) {
    return TextFieldShared(
      constraints: isWeb(context) ? const BoxConstraints(maxWidth: 300) : null,
      ctrler: ctrler,
      labelText: labelText,
      hintText: hintText,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      onChanged: (str) {
        if (onChanged != null) {
          id = email.text;
        }
      },
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

  showToast(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
  }

  Widget textFieldChoice(TextEditingController ctrler, String labelText) {
    return TextFieldShared(
        labelText: labelText,
        readOnly: true,
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

  Widget imageDialog(
      {required String tag,
      // required Widget widget,
      required BuildContext context}) {
    return Dialog(
      child: Stack(children: [
        PhotoView(
          tightMode: true,
          imageProvider: NetworkImage(tag),
        ),
        Positioned(
          right: 0,
          top: 0,
          // width: 100,
          // height: 100,
          child: IconButton(
            // focusColor: Colors.black,
            hoverColor: Colors.black,
            color: Colors.black,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ),
      ]),
    );
  }
}
