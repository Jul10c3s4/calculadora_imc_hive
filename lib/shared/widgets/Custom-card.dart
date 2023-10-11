import 'package:calculadora_imc_hive/models/imc_hive.dart';
import 'package:calculadora_imc_hive/shared/widgets/custom-text.dart';
import 'package:calculadora_imc_hive/shared/widgets/custom-textField.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  Imc imc;
  Function alterarPeso;
  Function delete;
  CustomCard(
      {super.key,
      required this.imc,
      required this.alterarPeso,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.subTitleCard("Nome: ${imc.nome.toString()}"),
                        CustomText.subTitleCard(
                            "Altura: ${imc.altura.toString()}"),
                        CustomText.subTitleCard(
                            "Peso: ${imc.peso!.last.toString()}")
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.subTitleCard(
                                "Data: ${imc.data!.last.toString()}"),
                            const SizedBox(
                              width: 3,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText.subTitleCard(
                                "Imc: ${imc.getImc().last.toString()}"),
                            const SizedBox(
                              width: 4,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: CustomText.subTitle(
                                            imc.calcularIMC().last.toString()),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  CustomText.subTitleOk("ok"))
                                        ],
                                      );
                                    });
                              },
                              child: CustomText.subTitleCardButton("detalhes"),
                              style: TextButton.styleFrom(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 0),
                                  backgroundColor: Colors.purple),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.purple, elevation: 8),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: CustomText.subTitle(
                                            "Deseja apagar os dados de ${imc.nome} pemanentemente? "),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: CustomText.subTitleCancel(
                                                  "Cancelar")),
                                          TextButton(
                                              onPressed: () {
                                                delete(imc);
                                              },
                                              child:
                                                  CustomText.subTitleOk("ok"))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            imc.peso!.length > 1
                ? Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                context: context,
                                builder: (context) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                                  const Icon(Icons.arrow_back)),
                                        ],
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: buildRows(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: CustomText.subTitleButton("imcs anteriores"),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  alterarPeso(imc.peso!.last, imc.altura);
                },
                style: TextButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.purple,
                ),
                child: CustomText.subTitleButton("Alterar peso"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRows(BuildContext context) {
    var imcsNumber = imc.getImc();
    var imcsText = imc.calcularIMC();
    var pesos = imc.peso;
    List<Widget> rows = [];
    for (var i = 0; i < imc.peso!.length; i++) {
      rows.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.subTitleCard("Data: ${imc.data![i].toString()}"),
                    CustomText.subTitleCard("Peso: ${pesos![i].toString()}")
                  ],
                ),
              ],
            ),
            Row(
              children: [
                CustomText.subTitleCard("Imc: ${imcsNumber[i].toString()}"),
                const SizedBox(
                  width: 4,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: CustomText.subTitle(imcsText[i].toString()),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: CustomText.subTitleOk("ok"))
                            ],
                          );
                        });
                  },
                  child: CustomText.subTitleCardButton("detalhes"),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 0),
                      backgroundColor: Colors.purple),
                ),
              ],
            )
          ],
        ),
      ));
    }
    return rows;
  }
}
