import 'package:flutter/material.dart';
import 'package:slicky/feature_box.dart';
import 'package:slicky/openai_service.dart';
import 'package:slicky/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final OpenAIService openAIService = OpenAIService();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slicky"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. virtual assistant image
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                ),
              ],
            ),
            // 2. chat bubble
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  )),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Good Morning! How can I help you?',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 25,
                    color: Pallete.mainFontColor,
                  ),
                ),
              ),
            ),
            // 3. Fixed text
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10, left: 20),
              child: const Text(
                'Here are a few solutions',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 4. Suggestion Box
            const Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  descriptionText:
                      'A smart way to stay organized and informed with Chat GPT',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Dall-E',
                  descriptionText:
                      'Get inspired and stay creative with your personal assistant',
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  descriptionText:
                      'Get the best of both worlds with a voice assistant powered by ChatGPT',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await stopListening();
          } else {
            speechToText.initialize();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
