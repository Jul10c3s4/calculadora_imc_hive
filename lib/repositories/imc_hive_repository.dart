import 'package:calculadora_imc_hive/models/imc_hive.dart';
import 'package:hive/hive.dart';

class ImcHiveRepository {
  static late Box _box;
  static const String CHAVE_IMCS = "CHAVE_IMCS";
  static const String CHAVE_IMCS_MODEL = "CHAVE_IMCS_MODEL";

  ImcHiveRepository._create();

  static Future<ImcHiveRepository> load() async {
    if (Hive.isBoxOpen(CHAVE_IMCS)) {
      _box = Hive.box(CHAVE_IMCS);
    } else {
      _box = await Hive.openBox(CHAVE_IMCS);
    }
    return ImcHiveRepository._create();
  }

  void salvar(Imc imc) {
    _box.add(imc);
  }

  void update(Imc imc) {
    imc.save();
  }

  void delete(Imc imc) {
    imc.delete();
  }

  List<Imc> getData() {
    return _box.values.cast<Imc>().toList();
  }
}
