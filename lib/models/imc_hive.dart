import 'dart:math';
import 'package:hive/hive.dart';

part 'imc_hive.g.dart';

@HiveType(typeId: 0)
class Imc extends HiveObject {
  @HiveField(0)
  List<double>? peso;

  @HiveField(1)
  double? altura;

  @HiveField(2)
  String? nome;

  @HiveField(3)
  List<String>? data;

//esse é obrigatorio
  Imc();

  Imc.create(this.nome, this.peso, this.altura, this.data);

  void addPeso(double peso) {
    this.peso!.add(peso);
  }

  void addData(String data) {
    this.data!.add(data);
  }

  List<double> getImc() {
    List<double> imcs = [];
    for (var p in peso!) {
      double imc = p / pow(altura!, 2);
      imcs.add(double.parse(imc.toStringAsFixed(2).toString()));
    }
    return imcs;
  }

  List<String> calcularIMC() {
    List<String> texts = [];
    for (var p in peso!) {
      double imc = p / pow(altura!, 2);
      imc < 16
          ? texts.add(
              "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de Magreza grave")
          : imc > 16 && imc < 17
              ? texts.add(
                  "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de Magreza moderada")
              : imc > 17 && imc < 18.5
                  ? texts.add(
                      "Seu imc é: ${imc.toStringAsFixed(2)}, você está estado de Magreza leve")
                  : imc > 18.5 && imc < 25
                      ? texts.add(
                          "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de saudável")
                      : imc > 25 && imc < 30
                          ? texts.add(
                              "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de sobrepeso")
                          : imc > 30 && imc < 35
                              ? texts.add(
                                  "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de obesidade grau I")
                              : imc > 35 && imc < 40
                                  ? texts.add(
                                      "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de obesidade grau II (severa)")
                                  : imc >= 40
                                      ? texts.add(
                                          "Seu imc é: ${imc.toStringAsFixed(2)}, você está em estado de obesidade grau III (mórbida)")
                                      : texts.add("");
    }
    return texts;
  }
}
