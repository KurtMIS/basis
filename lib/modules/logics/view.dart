import '../../repositories/input_repo.dart';
import '../../services/locator.dart';
import '../models/info/info.dart';

class View {
  final inputRepo = locator.get<InputRepo>();

  Stream<List<Info>> getInfos(Info info) => inputRepo.searchInfo$(info);
}
