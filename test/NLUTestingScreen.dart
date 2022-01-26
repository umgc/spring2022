import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:untitled3/Services/NLU/Bot/NLULibService.dart';

class NLUTestingScreen extends StatefulWidget {

  const NLUTestingScreen({Key? key}) : super(key: key);

  @override
  _NLUTestingScreenPageState createState() => _NLUTestingScreenPageState();
}

class _NLUTestingScreenPageState extends State<NLUTestingScreen> {
  final controller = TextEditingController();
  late final NLULibService nluLibService;


  String? answer;

  @override
  void initState() {
    super.initState();
    nluLibService = NLULibService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                      ),
                    )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: answer != null
                            ? Colors.orangeAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        answer ?? 'Ask Question',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 3,
                            maxLengthEnforcement: MaxLengthEnforcement.none,
                            style: TextStyle(fontSize: 14),
                            controller: controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter question'),
                          ),
                        ),
                        IconButton(
                          onPressed: getAnswer,
                          icon: Icon(
                            Icons.arrow_upward_sharp,
                            color: Colors.orange,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getAnswer() {
    setState(() {
         nluLibService.getNLUResponseUITest(controller.text).toString();
    });
  }
}