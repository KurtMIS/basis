import '../modules/views/done_page.dart';
import '../modules/views/home_page.dart';
import '../modules/views/input_page.dart';
import '../modules/views/login.dart';
import '../modules/views/main.dart';

dynamic routes() {
  return {
    '/': (context) => const MainPage(),
    // 'login': (context) => const LoginPage(),
    'input': (context) => const InputPage(),
    // 'view': (context) => const ViewPage(),
    // 'done': (context) => const DonePage(),
    'home': (context) => const HomePage(),
  };
}
