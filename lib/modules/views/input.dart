import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stronghold_ofw/modules/shared_widgets/textfield.dart';

import '../../contants/measure.dart';
import '../models/dependent/dependent.dart';
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
  final _dependents = BehaviorSubject<List<Dependent>>.seeded(<Dependent>[]);
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
        Card(
          elevation: 5,
          // color: ,
          child: Padding(
            padding: EdgeInsets.all(isWeb(context) ? 30.0 : 20),
            child: Wrap(
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
          ),
        ),
        Container(
          color: Colors.blue,
        ),
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
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(child: item),
          ))
      .toList();
}
