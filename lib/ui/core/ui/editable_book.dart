import 'dart:developer';

import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class EditableBook extends StatefulWidget {

  const EditableBook({super.key, required this.quizBook, this.scale = 1.5, required this.isValidCallback});

  final QuizBook quizBook;
  final double scale;
  final Function isValidCallback;

  @override
  State<EditableBook> createState() => _EditableBookState();
}

class _EditableBookState extends State<EditableBook> {
  late TextEditingController _controller;
  
  late QuizBook quizBook;

  @override
  void initState() {
    super.initState();
    quizBook = QuizBook.copyOf(widget.quizBook);
    _controller = TextEditingController(text: quizBook.title != "" ? quizBook.title : null);
  }

  Color pickerColor = Color(0xFF585858);
  Color currentColor = Color(0xFF585858);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  IconData? _icon;

  _pickIcon() async {
    IconPickerIcon? icon = await showIconPicker(
        context,
        configuration: SinglePickerConfiguration(
          title: const Text("Selecione um ícone"),
          closeChild: const Text('Fechar', textScaler: TextScaler.linear(1.25)),
          iconPackModes: [IconPack.outlinedMaterial],
          searchHintText: "Pesquisar",
          noResultsText: "Nenhum resultado para:"
        ),
    );

    _icon = icon?.data;
    setState(() {
      quizBook.icon = _icon!;
      _notifyParent();
    });

    debugPrint('Picked Icon:  $icon');
  }

  _notifyParent() {
    bool isValid = quizBook.title != "";
    bool isChanged = !quizBook.areEqualTo(widget.quizBook);
    log("[EditableBook] [_notifyParent] isValid: $isValid | isChanged: $isChanged");
    widget.isValidCallback(isValid, isChanged, quizBook);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * widget.scale,
          height: 185 * widget.scale,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Color.lerp(quizBook.color, Colors.black, 0.4),
              width: 147 * widget.scale,
              height: 35 * widget.scale,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * widget.scale,
          height: 178 * widget.scale,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey[300],
              width: 130 * widget.scale,
              height: 28 * widget.scale,
            ),
          ),
        ),
        InkWell(
          onTap: () => {
            // raise the [showDialog] widget
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Selecione uma cor'),
                content: SingleChildScrollView(
                  // child: ColorPicker(
                  //   pickerColor: pickerColor,
                  //   onColorChanged: changeColor,
                  //   enableAlpha: false,
                  // ),
                  // Use Material color picker:
                  //
                  // child: MaterialPicker(
                  //   pickerColor: pickerColor,
                  //   onColorChanged: changeColor,
                  //   showLabel: true, // only on portrait mode
                  // ),
                  //
                  // Use Block color picker:
                  //
                  child: BlockPicker(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                  ),
                  //
                  // child: MultipleChoiceBlockPicker(
                  //   pickerColors: currentColors,
                  //   onColorsChanged: changeColors,
                  // ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Confirmar'),
                    onPressed: () {
                      setState(() {
                        currentColor = pickerColor;
                        quizBook.color = currentColor;
                        _notifyParent();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          },
          child: Container(
            margin: const EdgeInsets.all(10.0),
            color: quizBook.color,
            width: 150 * widget.scale,
            height: 170 * widget.scale,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * widget.scale,
          height: 170 * widget.scale,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 12.0 * widget.scale),
              width: 120 * widget.scale,
              height: 25 * widget.scale,
              child: Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Digíte o título",
                    hintStyle: TextStyle(
                      fontSize: 13 * widget.scale, 
                      color: const Color.fromARGB(200, 255, 255, 255), 
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  style: TextStyle(fontSize: 13 * widget.scale, color: Colors.white, fontWeight: FontWeight.bold),
                  onChanged: (value) => {
                    setState(() {
                      quizBook.title = value;
                      _notifyParent();
                    })
                  }
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * widget.scale,
          height: 170 * widget.scale,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 20.0 * widget.scale),
              width: 120 * widget.scale,
              height: 100 * widget.scale,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: _pickIcon,
                  child: Stack(
                    children: [
                      Container(
                        color: Color.lerp(quizBook.color, Colors.white, 0.6),
                      ),
                      Center(
                        child: Icon(
                          quizBook.icon, 
                          size: 100 * widget.scale,
                          color: Color.lerp(quizBook.color, Colors.black, 0.3)
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}