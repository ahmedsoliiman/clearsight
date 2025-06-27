import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lottie/lottie.dart';
import 'home.dart';
import 'dart:async';

class FaceRecognitionInfoPage extends StatefulWidget {
  const FaceRecognitionInfoPage({super.key});

  @override
  State<FaceRecognitionInfoPage> createState() => _FaceRecognitionInfoPageState();
}

class _FaceRecognitionInfoPageState extends State<FaceRecognitionInfoPage> {
  bool _isProcessing = false;
  bool _showSuccess = false;
  XFile? _capturedImage;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureAndUpload() async {
    setState(() {
      _isProcessing = true;
      _uploadedImageUrl = null;
      _capturedImage = null;
      _showSuccess = false;
    });
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        setState(() { _isProcessing = false; });
        return;
      }
      setState(() { _capturedImage = image; });
      final bytes = await image.readAsBytes();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'face_${timestamp}.jpg';
      final storage = Supabase.instance.client.storage;
      final response = await storage.from('faces').uploadBinary(
        filename,
        bytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg'),
      );
      if (response.isNotEmpty && !response.contains('error')) {
        final url = Supabase.instance.client.storage.from('faces').getPublicUrl(filename);
        setState(() {
          _uploadedImageUrl = url;
          _showSuccess = true;
          _isProcessing = false;
        });
        // Show success animation for 6 seconds, then navigate home
        Future.delayed(const Duration(seconds: 6), () {
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
            );
          }
        });
      } else {
        setState(() { _isProcessing = false; });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: $response'), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      setState(() { _isProcessing = false; });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Recognition'),
        backgroundColor: Color(0xff5D83DD),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: _showSuccess
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'images/je/success_check.json',
                      width: 120,
                      height: 120,
                      repeat: false,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Face recognized successfully!',
                      style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Face scan icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff5D83DD), width: 4),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.face, color: Color(0xff5D83DD), size: 36),
                          Positioned(
                            bottom: 6,
                            right: 6,
                            child: Icon(Icons.qr_code_scanner, color: Color(0xff5D83DD), size: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'This feature uses facial recognition to enhance security and provide a personalized experience. Your face data is processed securely and is never shared.',
                        style: TextStyle(fontSize: 16, color: Color(0xff313131)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_isProcessing)
                      const CircularProgressIndicator(color: Color(0xff5D83DD)),
                    if (!_isProcessing)
                      ElevatedButton.icon(
                        onPressed: _captureAndUpload,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Scan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff5D83DD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    if (_capturedImage != null && _uploadedImageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: kIsWeb
                            ? Image.network(_uploadedImageUrl!, width: 120)
                            : Image.file(File(_capturedImage!.path), width: 120),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
} 