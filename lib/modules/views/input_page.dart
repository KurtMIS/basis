import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stronghold_ofw/modules/shared_widgets/textfield.dart';
import '../../constants/measure.dart';
import '../../services1/locator.dart';
import '../../utils/date_convert.dart';
import '../../utils/future_image.dart';
import '../logics/input.dart';
import '../models/dependent/dependent.dart';
import '../models/info/info.dart';
import '../shared_widgets/dialogs.dart';
import '../shared_widgets/popup_containers.dart';
import 'dart:html';
import 'dart:ui' as ui;

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final inputBloc = locator.get<Input>();

  final CarouselController carouselCtrler = CarouselController();
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

  final annualPremium = TextEditingController();
  final agentName = TextEditingController();
  final paymentMethod = '';
  var passportImagePath = '';
  var receiptImagePath = '';
  var id = '';
  var isUpdating = false;
  String docIdFromCurrentDate() => DateTime.now().toIso8601String();

  void setInfo() async {
    final res = await showConfirmDialog(
        context,
        isUpdating
            ? 'Are you sure you want to update form?'
            : 'Are you sure you want to send form?');
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
            telNumber: telNumber.text,
            termOfContract: termOfContract.text,
            isDone: false,
            isPaid: false,
            passportImagePath: passportImagePath,
            paymentMethod: _selectedPayment$.value.toString(),
            submissionDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            receiptImagePath: receiptImagePath,
            annualPremium: annualPremium.text,
            processedDate: ''),
        context);
    //done
    showToastSuccess(
      'Transaction Successful!',
    );
    if (locator.get<Input>().isAdmin) {
      Navigator.pushReplacementNamed(context, 'view');
    } else {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  void clearDependents() {
    dateOfBirthDependent.clear();
    nameDependent.clear();
    relationshipDependent.clear();
    revocableDependent.clear();
    sharingDependent.clear();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final info = inputBloc.info;

      if (info.id != '') {
        isUpdating = true;
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
        telNumber.text = info.telNumber;
        termOfContract.text = info.termOfContract;
        inputBloc.passportImage$.add(info.passportImagePath);
        inputBloc.receiptImage$.add(info.receiptImagePath);
        annualPremium.text = info.annualPremium;
        receiptImagePath = info.receiptImagePath;
        passportImagePath = info.passportImagePath;

        var list = <Dependent>[];
        for (var element in info.dependents) {
          list.add(Dependent.fromJson(element));
        }
        _dependents.add(list);
        Future.delayed(const Duration(milliseconds: 200), () {
          _current$.add(3);
          carouselCtrler.jumpToPage(3);
          _selectedPayment$.add(int.parse(info.paymentMethod));
        });
      } else {
        isUpdating = false;
        passportImagePath = '';
        passportImagePath = '';
        inputBloc.passportImage$.add('');

        inputBloc.receiptImage$.add('');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                StreamBuilder<int>(
                    stream: _current$,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const SizedBox();
                      }
                      final val = snapshot.hasData ? snapshot.data : 0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          previousButton(),
                          Column(
                            children: [
                              Text(
                                pageTitles(val!),
                                style: const TextStyle(color: Colors.blue),
                              ),
                              pageIndicator(val),
                            ],
                          ),
                          nextButton(snapshot.data!),
                        ],
                      );
                    }),
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

  Widget nextButton(int current) {
    return IconButton(
      icon: const Icon(Icons.arrow_forward_ios),
      onPressed: () {
        if (current == 0 && !personalInfoCheck()) {
          showToast('Fields with asterisk(*) are required');
          return;
        }
        if (current == 2 && !employmentInfoCheck()) {
          showToast('All Fields in employment screen are required');
          return;
        }
        carouselCtrler.nextPage();
      },
    );
  }

  bool personalInfoCheck() => (c(lastName) &&
      c(firstName) &&
      c(presentAddress) &&
      c(dateOfBirth) &&
      c(placeOfBirth) &&
      c(nationality) &&
      c(gender) &&
      c(religion) &&
      c(civilStatus) &&
      c(email) &&
      c(mobileNumber) &&
      passportImagePath.trim().isNotEmpty);

  bool employmentInfoCheck() => (c(employerName) &&
      c(employmentContactNumber) &&
      c(employerAddress) &&
      c(termOfContract) &&
      c(countryOfDeployment) &&
      c(natureOfBusiness) &&
      c(position) &&
      c(employmentDate) &&
      c(effectiveDate));

  bool summaryInfoCheck() => (c(annualPremium));

  bool c(TextEditingController text) => text.text.trim().isNotEmpty;

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
            textField(nationality, '*Nationality', hintText: 'Ex. Filipino...'),
            textField(gender, '*Gender', hintText: 'Ex. Male/Female...'),
            textField(
              religion,
              '*Religion',
            ),
            textField(civilStatus, '*Civil Status',
                hintText: 'Ex. Single or Married...'),
            textField(email, '*E-mail Address',
                hintText: 'Ex. delacruz@gmail.com...',
                keyboardType: TextInputType.emailAddress,
                onChanged: 'true'),
            textField(mobileNumber, '*Mobile Number',
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
                          const Text('*Passport',
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
                                    passportImagePath =
                                        await inputBloc.pickImage(
                                            true,
                                            id,
                                            'passport',
                                            inputBloc.passportImage$);
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
                                  if (snapshot.data == 'z') {
                                    return Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text('Uploading image'),
                                          SizedBox(height: 10),
                                          CircularProgressIndicator.adaptive(),
                                        ],
                                      ),
                                    );
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
                                              isWeb: isWeb(context) && kIsWeb,
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
                          const SizedBox(height: 15),
                          const Text(
                            '*Image must be clear',
                            style: TextStyle(
                                fontStyle: FontStyle.italic, color: Colors.red),
                          )
                        ]),
                  ),
                )),
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
                                      onTap: () {
                                        clearDependents();
                                        nameDependent.text = x.name;
                                        relationshipDependent.text =
                                            x.relationshipToInsured;
                                        if (x.dateOfBirth != null) {
                                          dateOfBirthDependent.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(x.dateOfBirth!);
                                        }
                                        sharingDependent.text = x.sharing;
                                        revocableDependent.text =
                                            x.revocability;
                                        final isUpdate = nameDependent.text
                                            .trim()
                                            .isNotEmpty;

                                        void remove() {
                                          _dependents.value.removeWhere(
                                              (element) =>
                                                  element.name == x.name);
                                          _dependents.add(_dependents.value);
                                        }

                                        showDialogShared(
                                            context,
                                            Container(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 500),
                                              // height: 220,
                                              width: 330,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                      'Dependent Information',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    height: 0,
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    child: Column(
                                                      children: [
                                                        textField(nameDependent,
                                                            'Full Name'),
                                                        const SizedBox(
                                                            height: 20),
                                                        textField(
                                                            relationshipDependent,
                                                            'This person\'s relationship to you'),
                                                        const SizedBox(
                                                            height: 20),
                                                        textFieldDate(
                                                            dateOfBirthDependent,
                                                            'Date of Birth'),
                                                        const SizedBox(
                                                            height: 20),
                                                        textField(
                                                            sharingDependent,
                                                            'Sharing ( Ex. 50%, 25%)',
                                                            keyboardType:
                                                                TextInputType
                                                                    .number),
                                                        const SizedBox(
                                                            height: 20),
                                                        textFieldChoice(
                                                            revocableDependent,
                                                            'Can be Cancelled?',
                                                            ['Yes', 'No']),
                                                        const SizedBox(
                                                            height: 20),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16,
                                                            bottom: 16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                            child: Text(isUpdate
                                                                ? 'Update Dependent'
                                                                : 'Add Dependent'),
                                                            onPressed:
                                                                () async {
                                                              remove();
                                                              var date = [];
                                                              if (dateOfBirthDependent
                                                                  .text
                                                                  .isEmpty) {
                                                              } else {
                                                                date =
                                                                    dateOfBirthDependent
                                                                        .text
                                                                        .split(
                                                                            '/');
                                                              }
                                                              final dependent = Dependent(
                                                                  name:
                                                                      nameDependent
                                                                          .text,
                                                                  relationshipToInsured:
                                                                      relationshipDependent
                                                                          .text,
                                                                  dateOfBirth: date
                                                                          .isEmpty
                                                                      ? null
                                                                      : DateTime
                                                                          .parse(
                                                                              '${date[2]}-${date[1]}-${date[0]}'),
                                                                  revocability:
                                                                      revocableDependent
                                                                          .text,
                                                                  sharing:
                                                                      sharingDependent
                                                                          .text);
                                                              if (_dependents
                                                                  .value
                                                                  .isEmpty) {
                                                                _dependents
                                                                    .add([
                                                                  dependent
                                                                ]);
                                                              } else {
                                                                _dependents
                                                                    .add([
                                                                  ..._dependents
                                                                      .value,
                                                                  dependent
                                                                ]);
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        if (isUpdate)
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                        if (isUpdate)
                                                          ElevatedButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red),
                                                              onPressed: () {
                                                                remove();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Remove Depedent'))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
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
                    clearDependents();
                    showDialogShared(
                        context,
                        Stack(
                          children: [
                            Container(
                              constraints: const BoxConstraints(maxHeight: 500),
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
                                            'What is your relationship to this person'),
                                        const SizedBox(height: 20),
                                        textFieldDate(dateOfBirthDependent,
                                            'Date of Birth'),
                                        const SizedBox(height: 20),
                                        textField(sharingDependent,
                                            'Sharing ( Ex. 50%, 25%)',
                                            keyboardType: TextInputType.number),
                                        const SizedBox(height: 20),
                                        textFieldChoice(revocableDependent,
                                            'Can be Cancelled?', ['Yes', 'No']),
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
                                          var date = [];
                                          if (dateOfBirthDependent
                                              .text.isEmpty) {
                                          } else {
                                            date = dateOfBirthDependent.text
                                                .split('/');
                                          }
                                          final dependent = Dependent(
                                              name: nameDependent.text,
                                              relationshipToInsured:
                                                  relationshipDependent.text,
                                              dateOfBirth: date.isEmpty
                                                  ? null
                                                  : DateTime.parse(
                                                      '${date[2]}-${date[1]}-${date[0]}'),
                                              revocability:
                                                  revocableDependent.text,
                                              sharing: sharingDependent.text);
                                          if (_dependents.value.isEmpty) {
                                            _dependents.add([dependent]);
                                          } else {
                                            _dependents.add([
                                              ..._dependents.value,
                                              dependent
                                            ]);
                                          }
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            )
                          ],
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
                const Divider(),
                textFieldChoice(termOfContract, 'Term Of Contract',
                    ['12 months', '24 months', '36months']),
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
                child: const Text('Personal Information',
                    style: TextStyle(color: Colors.white))),
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
                // text(passportNumber, '*Passport Number'),
                // text(
                //   expiryDate,
                //   '*Expiry Date',
                // ),
              ],
            ),
            const Divider(),
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Dependents',
                    style: TextStyle(color: Colors.white))),
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
                child: const Text('Employment Information',
                    style: TextStyle(color: Colors.white))),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 0.0,
              runSpacing: 10.0,
              children: [
                text(employerName, 'Employer Name: '),
                text(
                  employmentContactNumber,
                  'Employer Contact No.',
                ),
                textLong(employerAddress, 'Employer Address'),
                text(termOfContract, 'Term Of Contract'),
                text(countryOfDeployment, 'Country Of Deployment'),
                text(
                  natureOfBusiness,
                  'Nature Of Business',
                ),
                text(position, 'Position'),
                text(employmentDate, 'Date of Employment'),
                text(effectiveDate, 'Departure/Effective Date'),
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Payment',
                    style: TextStyle(color: Colors.white))),
            const SizedBox(height: 15),
            textFieldChoice(annualPremium, 'Annual Premium', [
              '\$24 for one(1) year',
              '\$48 for two(2) years',
              '\$72 for three(3) years'
            ]),
            const Divider(),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.blue,
                child: const Text('Payment Options',
                    style: TextStyle(color: Colors.white))),
            StreamBuilder<int>(
                stream: _selectedPayment$,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox();
                  }
                  final data = snapshot.data;
                  return Column(
                    children: [
                      // ListTile(
                      //   onTap: () {
                      //     if (data == 1) {
                      //       _selectedPayment$.add(0);
                      //       return;
                      //     }
                      //     _selectedPayment$.add(1);
                      //   },
                      //   title:
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       const Text('Pay to agent'),
                      //       if (data! == 1)
                      //         const SizedBox(
                      //           height: 15,
                      //         ),
                      //       if (data == 1)
                      //         textFieldChoice(agentName, 'Agent Name', []),
                      //     ],
                      //   ),
                      //   leading: data == 1
                      //       ? const Icon(Icons.circle_rounded,
                      //           color: Colors.green)
                      //       : const Icon(Icons.circle_outlined),
                      //   subtitle: Text('09207433898'),
                      // ),
                      // const Divider(),
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
                            const SizedBox(height: 15),
                            Text('STRONGHOLD INSURANCE COMPANY, INC.'),
                            const SizedBox(height: 10),
                            const Text('BDO Peso Account: \n003008061601'),
                            const Divider(),
                            const Text('BDO Dollar Account: \n103000678 829'),
                            const SizedBox(height: 15),
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
                                                      if (email.text.isEmpty) {
                                                        showToast(
                                                            'Email is required');
                                                        return;
                                                      }
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
                                                      if (email.text.isEmpty) {
                                                        showToast(
                                                            'Email is required');
                                                        return;
                                                      }
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
                                                    if (snapshot.data == 'z') {
                                                      return Center(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                                'Uploading image'),
                                                            SizedBox(
                                                                height: 10),
                                                            CircularProgressIndicator
                                                                .adaptive(),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                    final complete =
                                                        Completer();
                                                    complete.complete(
                                                        snapshot.data);
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        await showDialog(
                                                            context: context,
                                                            builder: (_) => imageDialog(
                                                                tag: snapshot
                                                                    .data!,
                                                                isWeb: isWeb(
                                                                        context) &&
                                                                    kIsWeb,
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
                                            const SizedBox(height: 10),
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
                      if (_selectedPayment$.value > 0)
                        Text(
                          _selectedPayment$.value == 1
                              ? '*Pay to agent first before you click send form'
                              : '*Process payment first before you click send form',
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 15),
                      const Text(
                        'Receive the certificate through email within 24 working hours',
                      ),
                    ],
                  );
                }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(
                      child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(15)),
                    onPressed: () {
                      if (!summaryInfoCheck()) {
                        showToast('Annual premium is empty');
                        return;
                      }

                      if (_selectedPayment$.value == 0) {
                        showToast('No payment option selected');
                        return;
                      }

                      if (_selectedPayment$.value == 3 &&
                          receiptImagePath.trim().isEmpty) {
                        showToast('Transaction Receipt image is required');
                        return;
                      }
                      setInfo();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(isUpdating ? 'Update Form' : 'Send Form',
                          style: const TextStyle(fontSize: 15)),
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
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.none,
      // validator: (str) => str,
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
          print(email.text);
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

  Widget textFieldDate(TextEditingController ctrler, String labelText,
      {bool? condition}) {
    return TextFieldShared(
      ctrler: ctrler,
      labelText: labelText,
      readOnly: true,
      constraints: const BoxConstraints(maxWidth: 300),
      keyboardType: TextInputType.none,
      onTap: () async {
        await selectPopupDate(context, ctrler);
        if (condition != null) {
          final date = stringToDate(ctrler.text);
          final currentDate = DateTime.now();
          if (date.compareTo(currentDate) > 0) {
            showToast('Date must not ');
            return;
          }
        }
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

  showToastSuccess(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: Colors.green,
      duration: const Duration(milliseconds: 4000),
    ));
  }

  Widget textFieldChoice(
      TextEditingController ctrler, String labelText, List<String> list) {
    return TextFieldShared(
        labelText: labelText,
        readOnly: true,
        ctrler: ctrler,
        keyboardType: TextInputType.none,
        constraints:
            isWeb(context) ? const BoxConstraints(maxWidth: 300) : null,
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          final result = await showDialog(
              context: context,
              builder: (_) => dialogChoiceShared(context,
                  list: list, title: labelText, ctrler: ctrler));
          if (result == null) {
            return;
          }
          ctrler.text = result;
        });
  }

  Widget imageDialog(
      {required String tag,
      required bool isWeb,
      // required Widget widget,
      required BuildContext context}) {
    if (isWeb) {
      String imageUrl = tag;
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        imageUrl,
        (int _) => ImageElement()..src = imageUrl,
      );
    }
    return Dialog(
      child: Stack(children: [
        isWeb
            ? HtmlElementView(
                viewType: tag,
              )
            : PhotoView(
                tightMode: true,
                imageProvider: NetworkImage(tag),
              ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
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
