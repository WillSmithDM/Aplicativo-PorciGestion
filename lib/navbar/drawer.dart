import 'package:app_tesis/navbar/app_bar.dart';
import 'package:app_tesis/navbar/salomon_bottom_bar.dart';
import 'package:app_tesis/navbar/salomon_bottom_bar_item.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  static String id = "menu_view";

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const DashboardScreen(),
            const CategoryPage(),
            PerfilUsuario(
                navigatorKey: _navigatorKey,
                onLogout: () {
                  _handleLogout();
                },
                changeCamaping: () {
                  _handleChange();
                })
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.black,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.api_sharp),
              title: const Text("Categorias"),
              selectedColor: Colors.black,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_2_outlined),
              title: const Text("Perfil"),
              selectedColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        ModalRoute.withName(
            '/') // Replace this with your root screen's route name (usually '/')
        );
  }

  void _handleChange() {
    Navigator.pushReplacementNamed(context, '/Select');
  }
}
