import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = StorageService(await SharedPreferences.getInstance());
  runApp(MisbahatiApp(storage: storage));
}

class MisbahatiApp extends StatefulWidget {
  const MisbahatiApp({super.key, required this.storage});
  final StorageService storage;
  @override State<MisbahatiApp> createState() => _MisbahatiAppState();
}

class _MisbahatiAppState extends State<MisbahatiApp> {
  late ThemeMode mode;
  @override void initState() { super.initState(); mode = widget.storage.themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light; }
  Future<void> setMode(ThemeMode value) async { setState(() => mode = value); await widget.storage.saveThemeMode(value == ThemeMode.dark ? 'dark' : 'light'); }
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'مسبحتي', debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme, darkTheme: AppTheme.darkTheme, themeMode: mode,
    home: HomeScreen(storage: widget.storage, themeMode: mode, onThemeChanged: setMode),
  );
}
