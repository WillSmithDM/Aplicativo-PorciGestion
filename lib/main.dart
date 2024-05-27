import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Hive.initFlutter();
  initializeDateFormatting('es_ES', null).then((_) {
    runApp(MyApp());
  });
}



class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Tu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/Select':
            return MaterialPageRoute(builder: (_) => const CampaingSelection());
          case '/Home':
            return MaterialPageRoute(builder: (_) => const Menu());
          default:
            return null;
        }
      },
    );
  }
}
