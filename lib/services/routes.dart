import '../modules/views/input_page.dart';
import '../modules/views/login.dart';
import '../modules/views/main.dart';
import '../modules/views/view_page.dart';

dynamic routes() {
  return {
    '/': (context) => const MainPage(),
    'login': (context) => const LoginPage(),
    'input': (context) => const InputPage(),
    'view': (context) => const ViewPage(),
  };
}
