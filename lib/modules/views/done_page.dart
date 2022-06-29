import 'package:flutter/material.dart';

class DonePage extends StatefulWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check, size: 40, color: Colors.green),
          SizedBox(
            height: 10,
          ),
          Text('TRANSACTION COMPLETE',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          // SizedBox(height: 40),
          // Text('The certificate will be sent to your email')
        ],
      ),
    ));
  }
}
