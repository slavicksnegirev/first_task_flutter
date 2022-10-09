import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
  PlatformFile? platformFile;
  String? selectedItem = 'Выберите расширение';

  List<String> items = [
    'Выберите расширение', '1', '2',
  ];

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      file = File(result.files.single.path!);
      platformFile = result.files.single;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Конвертер файлов'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: selectFile,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [10, 4],
                      strokeCap: StrokeCap.round,
                      color: Colors.blue,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Iconsax.folder_open,
                              color: Colors.blue,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Выберите файл',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black26),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              platformFile != null
                  ? Container(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Выбранный файл',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: const Offset(0, 1),
                                      blurRadius: 3,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        file!,
                                        width: 70,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          platformFile!.name,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${(platformFile!.size / 1024).ceil()} KB',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black26),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ))
                  : Container(),
              Container(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  )),
                  value: selectedItem,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: platformFile != null
                                        ? Colors.black
                                        : Colors.black26)),
                          ))
                      .toList(),
                  onChanged: (item) => setState(() => selectedItem = item),
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          ),
        ),
      );
}
