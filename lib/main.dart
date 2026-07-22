import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Ekran orientatsiyasini faqat landscape qilish
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Status bar va navigation barni yashirish
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  
  // O'yinni ishga tushirish
  runApp(const FootballEliteMobile());
  
  // Splash screen ni olib tashlash
  FlutterNativeSplash.remove();
}

class FootballEliteMobile extends StatelessWidget {
  const FootballEliteMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Football Elite Mobile - FEM',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
