import 'package:flutter/material.dart';
import 'package:stronghold_ofw/constants/measure.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(isWeb(context) ? 40 : 15.0),
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/logo.png',
                      height: 100,
                    ),
                    const Text(
                      'OFW Insurance',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        'COMPULSORY INSURANCE COVERAGE FOR AGENCY-HIRED MIGRANT WORKERS',
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                            'Republic Act (RA) No. 10022 (an Act amending RA8042 otherwise known as the Migrant Workers and Overseas Filipinos Act of 1995, as amended, further improving the standard of protection and promotion of the welfare of Migrant Workers, their families and Overseas Filipinos in distress and for other purpose) requires the Compulsory Insurance coverage of Overseas Filipino Workers.'),
                        SizedBox(height: 15),
                        Text(
                            'Stronghold Insurance Co., Inc. and Philippine Life Financial Assurance Corporation banded together to provide Non-life and Life insurance coverage respectively to our Migrant Workers.'),
                        SizedBox(height: 15),
                        Text(
                            'The provider of our Travel Assistance Program for Overseas Filipino Workers is IBERO Asistencia that can be contacted 24/7 thru the assigned dedicated Hotline Number 00 632 459 4786.'),
                        SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(15),
                color: Colors.blue.shade900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    BigText(value: 'INSURANCE BENEFIT'),
                    TextWithSpace(
                        value:
                            'The insurer shall pay the benefits as determined in accordance with the provisions of the Policy immediately upon the receipt and approval of due proof of loss.'),
                    BigText(value: 'BENEFICIARY'),
                    TextWithSpace(
                        value:
                            'An insured shall have the right to designate anybody, not disqualified by law, as his beneficiary or beneficiaries, and may at anytime, designate new beneficiary or beneficiaries by filing through the Policyholder a properly completed written request on a form satisfactory to the Insurer. Such change shall take effect only when recorded in writing by the Insurer at its Home Office but without prejudice to the Insurer on any payment made before receipt of such notice.'),
                    TextWithSpace(
                        value:
                            'The indemnity for the loss of life of an Insured shall be payable to his designated beneficiary or beneficiaries, if surviving; or if there be no beneficiaries designated or surviving at the death of the Insured, to the surviving class of the following classes of successive preference beneficiaries: the Insured/s:'),
                    SizedBox(
                      height: 10,
                    ),
                    TextWithSpace(
                      value: '1. widow or widower',
                      noSpace: true,
                    ),
                    TextWithSpace(
                      value:
                          '2. surviving children born to or legally adopted by the member',
                      noSpace: true,
                    ),
                    TextWithSpace(
                      value: '3. surviving parents',
                      noSpace: true,
                    ),
                    TextWithSpace(
                      value: '4. surviving brothers and sisters',
                      noSpace: true,
                    ),
                    TextWithSpace(
                      value: '5. executors and administrators',
                      noSpace: true,
                    ),
                    TextWithSpace(
                        value:
                            'If there be two or more beneficiaries, they shall share equally on the proceeds unless otherwise specified by the Insured. All other indemnities under the Policy shall be payable to the Insured.'),
                    BigText(value: 'NOTICE OF CLAIM'),
                    TextWithSpace(
                        value:
                            'Written notice of claim must be given to the Insurer within thirty (30) daysafter the occurence or commencement of any loss covered by the Policy or as soon thereafter as is reasonably possible. Failure to comply within the time provided shall not invalidate nor reduce the claim if it is given as soon as was reasonably possible.'),
                    BigText(value: 'AVAILABILITY OF THE POLICY.'),
                    TextWithSpace(
                        value:
                            'The policy shall be kept in the main office and in the custody of an officer of the Policyholder. It will be available to the Insured\'s for their inspection during regular business hours of the Policyholder.')
                  ],
                ),
              ),
              // const Text(
              //     'POEA is reminding recruitment agencies and/or all returning Overseas Filipino Workers / Balik Manggagawa to register via BMOnline.ph or by submitting the following required documents:'),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green.shade900,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'input');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Proceed to fill up form'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward_sharp)
                    ],
                  )),
              const SizedBox(height: 30),
              // ElevatedButton(
              //     onPressed: () {}, child: const Text('Proceed to fill up form')),
            ],
          ),
        ));
  }
}

class BigText extends StatelessWidget {
  const BigText({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
    );
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) || (other is BigText && other.value == value);

  @override
  int get hashCode => value.hashCode;
}

class TextWithSpace extends StatelessWidget {
  const TextWithSpace({Key? key, required this.value, this.noSpace})
      : super(key: key);

  final String value;
  final bool? noSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white)),
        if (noSpace == null) const SizedBox(height: 10),
      ],
    );
  }

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextWithSpace && other.value == value);

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode => value.hashCode;
}
