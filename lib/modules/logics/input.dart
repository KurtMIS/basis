import '../../repositories/input_repo.dart';
import '../../services/locator.dart';
import '../models/info/info.dart';

class Input {
  final inputRepo = locator.get<InputRepo>();

  Future<void> setInfo(Info req) async => await inputRepo.setInfo(req);
}
