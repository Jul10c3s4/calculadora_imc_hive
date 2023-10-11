import 'package:calculadora_imc_hive/models/imc_hive.dart';
import 'package:calculadora_imc_hive/repositories/imc_hive_repository.dart';
import 'package:calculadora_imc_hive/shared/widgets/Custom-card.dart';
import 'package:calculadora_imc_hive/shared/widgets/custom-text.dart';
import 'package:calculadora_imc_hive/shared/widgets/custom-textField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculatorImcPage extends StatefulWidget {
  const CalculatorImcPage({super.key});

  @override
  State<CalculatorImcPage> createState() => _CalculatorImcPageState();
}

class _CalculatorImcPageState extends State<CalculatorImcPage> {
  final TextEditingController _alturaController =
      TextEditingController(text: "");
  final TextEditingController _pesoController = TextEditingController(text: "");
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _newPesoController =
      TextEditingController(text: "");
  final formatador = DateFormat('dd/MM/yyyy');
  var imcs = <Imc>[];
  late ImcHiveRepository imcHiveRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    imcHiveRepository = await ImcHiveRepository.load();
    imcs = imcHiveRepository.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText.title("Histórico de Imcs"),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: imcs.length,
                          itemBuilder: (context, index) {
                            var imc = imcs[index];
                            return CustomCard(
                              alterarPeso: (double peso, double altura) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shadowColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        content: CustomTextField(
                                            title: "Insira o novo peso:",
                                            textControler: _newPesoController,
                                            sufixIcon: const Icon(Icons.scale),
                                            textInputType:
                                                TextInputType.number),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: CustomText.subTitleCancel(
                                                  "Cancelar")),
                                          TextButton(
                                              onPressed: () {
                                                for (int i = 0;
                                                    i <= imcs.length;
                                                    i++) {
                                                  if (imcs[i].peso!.last ==
                                                          peso &&
                                                      imcs[i].altura ==
                                                          altura) {
                                                    imcs[i].addData(
                                                        formatador.format(
                                                            DateTime.now()));
                                                    imcs[i].addPeso(
                                                        double.parse(
                                                            _newPesoController
                                                                .text
                                                                .toString()));
                                                    _newPesoController.text =
                                                        "";
                                                    _newPesoController.text =
                                                        "";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                    return;
                                                  } else {}
                                                }
                                              },
                                              child:
                                                  CustomText.subTitleOk("Ok"))
                                        ],
                                      );
                                    });
                              },
                              delete: (Imc imc) {
                                imcHiveRepository.delete(imc);
                                getData();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              imc: imc,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                });
          },
          child: const Icon(
            Icons.history_edu,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.purple,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: CustomText.title("Calculadora de IMC"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                textInputType: TextInputType.text,
                title: "Insira seu nome: ",
                textControler: _nameController,
                hintText: "maria",
                sufixIcon: const Icon(Icons.person)),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                textInputType: TextInputType.number,
                title: "Insira sua altura: ",
                textControler: _alturaController,
                hintText: "1.80",
                sufixIcon: const Icon(Icons.height)),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                textInputType: TextInputType.number,
                title: "Insira seu peso: ",
                textControler: _pesoController,
                hintText: "60",
                sufixIcon: const Icon(Icons.scale)),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  if (_alturaController.text == "" ||
                      _pesoController.text == "") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: CustomText.subTitle(
                                "Preencha todos os campos para calcular o imc!"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: CustomText.subTitleOk("ok"))
                            ],
                          );
                        });
                  } else {
                    try {
                      var newImc = Imc.create(
                          _nameController.text,
                          [double.parse(_pesoController.text)],
                          double.parse(_alturaController.text),
                          [formatador.format(DateTime.now())]);
                      imcHiveRepository.salvar(newImc);
                      getData();
                      _alturaController.text = "";
                      _pesoController.text = "";
                      _nameController.text = "";
                      setState(() {});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: CustomText.title(
                              "Altura ou peso em formato incorreto!")));
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: CustomText.subTitle(e.toString()),
                            );
                          });
                    }
                  }
                },
                child: CustomText.titleWhite(
                  "Calcular",
                ),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    backgroundColor: const Color.fromARGB(194, 255, 102, 153)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            imcs.isNotEmpty
                ?
                //_nameController.text = imcs.last.peso.last.toString()
                CustomCard(
                    alterarPeso: (double peso, double altura) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              content: CustomTextField(
                                  title: "Insira o novo peso:",
                                  textControler: _newPesoController,
                                  sufixIcon: const Icon(Icons.scale),
                                  textInputType: TextInputType.number),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child:
                                        CustomText.subTitleCancel("Cancelar")),
                                TextButton(
                                    onPressed: () {
                                      for (int i = 0; i <= imcs.length; i++) {
                                        if (imcs[i].peso!.last == peso &&
                                            imcs[i].altura == altura) {
                                          imcs[i].addData(formatador
                                              .format(DateTime.now()));
                                          imcs[i].addPeso(double.parse(
                                              _newPesoController.text
                                                  .toString()));
                                          _newPesoController.text = "";
                                          imcHiveRepository.update(imcs[i]);
                                          getData();
                                          Navigator.pop(context);
                                          return;
                                        } else {}
                                      }
                                    },
                                    child: CustomText.subTitleOk("Ok"))
                              ],
                            );
                          });
                    },
                    delete: (Imc imc) {
                      imcHiveRepository.delete(imc);
                      getData();
                      Navigator.pop(context);
                    },
                    imc: imcs.last,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
