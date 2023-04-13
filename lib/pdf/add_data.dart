import 'package:flutter/material.dart';
import 'package:manager_app/pdf/pdf_inv_screen.dart';

class MyAddDataScreen extends StatefulWidget {
  const MyAddDataScreen({super.key});

  @override
  State<MyAddDataScreen> createState() => _MyAddDataScreenState();
}

class _MyAddDataScreenState extends State<MyAddDataScreen> {
  late TextEditingController ctrltex = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: TextFormField(
                controller: ctrltex,
                onFieldSubmitted: (val) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPdfInvScreen(data: val)));
                },
                decoration: const InputDecoration(
                  hintText: 'Add text',
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyPdfInvScreen(data: ctrltex.text)));
                },
                child: const Text('show pdf')),
          ],
        ),
      ),
    );
  }
}
