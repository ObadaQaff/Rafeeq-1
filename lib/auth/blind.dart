import 'dart:async';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:front/main.dart';
import 'package:front/component/customdrawer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

class Blind extends StatefulWidget {
  const Blind({super.key});

  @override
  State<Blind> createState() => _BlindState();
}

class _BlindState extends State<Blind> {
  late CameraController controller;
  bool isReady = false;

  // ———— TTS ————
  final FlutterTts tts = FlutterTts();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    initCamera();
    setupTTS();
  }

  // ———— إعداد TTS ————
  Future<void> setupTTS() async {
    tts.setCompletionHandler(() {
      setState(() => isSpeaking = false);
    });
  }

  Future<void> speakText(String text) async {
    setState(() => isSpeaking = true);
    await tts.speak(text);
  }

  // ———— تشغيل الكاميرا ————
  Future<void> initCamera() async {
    controller = CameraController(
      cameras![0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller.initialize();
    if (!mounted) return;

    setState(() => isReady = true);

    // ابدأ التقاط الصور كل ثانية
    startAutoCapture();
  }

  void startAutoCapture() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted || !isReady) return;

      try {
        final picture = await controller.takePicture();
        final file = File(picture.path);

        sendToModel(file);

      } catch (e) {
        print("Error capturing image: $e");
      }
    });
  }

  // ———— إرسال الصورة للموديل ————
  Future<void> sendToModel(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://YOUR_API_URL/predict/"), // ← غيّري الرابط
      );

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      final response = await request.send();
      String result = await response.stream.bytesToString();

      print("MODEL RESPONSE: $result");

      // اجعلي الموديل يحكي الوصف
      speakText(result);

    } catch (e) {
      print("Error sending to model: $e");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 85, 82),
        title: const Text("Blind Interface"),
      ),

      body: Stack(
        alignment: Alignment.center,
        children: [
          // ———— فريم الكاميرا ————
          isReady
              ? Center(
                  child: Container(
                    width: 350,
                    height: 550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color.fromARGB(255, 35, 85, 82),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 3,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: CameraPreview(controller),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          // ———— دائرة الصوت المتحركة ————
          Positioned(
            bottom: 30,
            child: AvatarGlow(
              glowColor: const Color.fromARGB(255, 35, 85, 82),
              animate: isSpeaking,
              glowShape: BoxShape.circle,
              duration: const Duration(milliseconds: 1500),
              child: Material(
                elevation: 5,
                shape: const CircleBorder(),
                color: const Color.fromARGB(255, 35, 85, 82),
                child: const CircleAvatar(
                  radius: 35,
                  backgroundColor: Color.fromARGB(255, 35, 85, 82),
                  child: Icon(
                    Icons.graphic_eq,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
