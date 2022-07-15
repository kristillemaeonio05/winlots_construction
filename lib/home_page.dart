import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'custom_widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var photos = [];
  bool includePhoto = false;

  var comments = TextEditingController();

  String dateVal = '';
  var date = [
    '2020-06-29',
    '2020-06-18',
    '2020-11-29',
    '2020-02-11',
    '2021-06-05'
  ];
  String selectedAreaVal = '';
  var selectedArea = ['Area 1', 'Area 2', 'Area 3', 'Area 4', 'Area 5'];
  String taskCategoryVal = '';
  var taskCategory = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5'
  ];
  String tags = '';

  bool existingEvent = false;
  String selectEventVal = '';
  var selectEvent = ['Event 1', 'Event 2', 'Event 3', 'Event 4', 'Event 5'];

  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? images = [];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 15.0,
              ),
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: 10.0),
                  Text(
                    '20041075  | TAP-NS TAP-North Stanthfield',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 15.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add to site diary',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.help, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Card(
                      elevation: 12,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Add Photos to site diary',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Divider(height: 20.0),
                            Builder(builder: (context) {
                              if (images != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 20.0,
                                    children: images!.map(
                                      (image) {
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            SizedBox(
                                              height: 75.0,
                                              width: 75.0,
                                              child: Image.file(
                                                File(image.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              right: -13.0,
                                              top: -13.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() =>
                                                      images!.remove(image));
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(30.0),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.cancel_rounded,
                                                    size: 25.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(18)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: includePhoto ? selectImages : null,
                              child: const Text(
                                'Add a photo',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                              child: CheckboxListTile(
                                value: includePhoto,
                                contentPadding: EdgeInsets.zero,
                                title: const Text('include in photo gallery'),
                                onChanged: (val) {
                                  setState(() {
                                    includePhoto = val!;
                                    if (!val) images!.clear();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Card(
                      elevation: 12,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Comments',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Divider(height: 20.0),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Comments'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Required Field' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Card(
                      elevation: 12,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Divider(height: 20.0),
                            Dropdown(
                              title: '2020-06-29',
                              items: date,
                              onChanged: (val) {
                                setState(() => dateVal = val!);
                              },
                              validator: (value) =>
                                  value == null ? 'Required Field' : null,
                            ),
                            Dropdown(
                              title: 'Select Area',
                              items: selectedArea,
                              onChanged: (val) {
                                setState(() => selectedAreaVal = val!);
                              },
                              validator: (value) =>
                                  value == null ? 'Required Field' : null,
                            ),
                            Dropdown(
                              title: 'Task Category',
                              items: taskCategory,
                              onChanged: (val) {
                                setState(() => taskCategoryVal = val!);
                              },
                              validator: (value) =>
                                  value == null ? 'Required Field' : null,
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Tags'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Required Field' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Card(
                      elevation: 12,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 50.0,
                              child: CheckboxListTile(
                                value: includePhoto,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  'List of existing event',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    includePhoto = val!;
                                    if (!val) selectEventVal = '';
                                  });
                                },
                              ),
                            ),
                            const Divider(height: 20.0),
                            Dropdown(
                              title: 'Select an event',
                              items: selectEvent,
                              onChanged: includePhoto
                                  ? (val) {
                                      setState(() => selectEventVal = val!);
                                    }
                                  : null,
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(18)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: validateForm,
                      child: const Text(
                        'Next',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() => images!.addAll(selectedImages));
    }
  }

  void validateForm() {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      List<String> img = images!.map((e) => e.path).toList();
      Map<String, dynamic> body = {
        'images': img,
        'comments': comments.text,
        'date': dateVal,
        'area': selectedAreaVal,
        'task_category': taskCategoryVal,
        'event': selectEventVal
      };

      uploadData(body);
    }
  }

  void refrehInput() {
    setState(() {
      formKey.currentState!.reset();
      includePhoto = false;
      existingEvent = false;
      images!.clear();
    });
  }

  Future<void> uploadData(Map<String, dynamic> body) {
    Uri uri = Uri.parse('https://reqres.in/api/posting');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    return http
        .post(uri, headers: headers, body: jsonEncode(body))
        .then((value) {
      var data = json.decode(value.body);

      if (kDebugMode) {
        print(data);
      }

      if (value.statusCode == 201) {
        customDialog('Success', 'Saved successfully.');
        refrehInput();
      } else {
        customDialog('Sorry!', 'Something went wrong.');
      }
    });
  }

  customDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
