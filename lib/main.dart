import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:clearsight/pages/signin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://otcfhoalgmskduprfxzp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90Y2Zob2FsZ21za2R1cHJmeHpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAzMjg1ODIsImV4cCI6MjA2NTkwNDU4Mn0.SrIjlYektqHA4yHRJJfHUTqZtKfOhcHq2hUguKOLuv0',
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Enable device preview in debug mode
  runApp(
    DevicePreview(
      enabled: !kReleaseMode && kIsWeb,  // Enable only in debug mode and web
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings: PlatformSettingsData(
        platformStyle: PlatformStyleData(
          web: PlatformStyle.Material,
          android: PlatformStyle.Material,
          ios: PlatformStyle.Cupertino,
        ),
      ),
      builder: (context) => PlatformApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: (context, child) {
          // Apply DevicePreview in debug mode
          final processedChild = DevicePreview.appBuilder(context, child ?? const SizedBox());
          
          // Wrap with a MediaQuery to handle responsive layout
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,  // Prevent text scaling
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return processedChild;
              },
            ),
          );
        },
        home: const Signin(),
        material: (_, __) => MaterialAppData(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff5D83DD),
            ),
          ),
        ),
        cupertino: (_, __) => CupertinoAppData(
          theme: const CupertinoThemeData(
            primaryColor: Color(0xff5D83DD),
            brightness: Brightness.light,
          ),
        ),
      ),
    );
  }
}
