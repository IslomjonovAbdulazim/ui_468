import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';

String apiKey = "AIzaSyCIyR35pgtP3spCguV6MprjB1W-RSWJWTA";

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  String output = "";
  Translation translator = Translation(apiKey: apiKey);

  void perevod() async {
    TranslationModel tr = await translator.translate(
      text: controller.text,
      to: "uz",
    );
    output = tr.translatedText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: 5,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (val) {
                    perevod();
                  },
                  onTapOutside: (val) {
                    focusNode.unfocus();
                    perevod();
                  },
                  decoration: InputDecoration(
                    hintText: "Input something...",
                    filled: true,
                    fillColor: Colors.indigo,
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
