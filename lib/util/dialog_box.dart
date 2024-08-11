import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/custom_keys/keys.dart';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  late final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.blue,
        centerTitle: true,
        backgroundColor: const Color(0xff522B5B),
        elevation: 0,
        title: Text(
          CustomKeys.dialogBoxAppbarTitile,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
        ),
      ),
      backgroundColor: const Color(0xff86A8cf),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                CustomKeys.listTileTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                ),
              ),
              subtitle: Text(
                CustomKeys.listTileSubTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
            ),
            const SizedBox(height: 15),
            //get user input
            TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: controller,
              decoration:  InputDecoration(
                labelStyle: const TextStyle(fontSize: 20),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                hintText: CustomKeys.textFieldHintText,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Save Button
                MyButton(
                  text: CustomKeys.myButtonName,
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(CustomKeys.snackBarTitle),
                        ),
                      );
                    }
                    onSave();
                  },
                ),
                const SizedBox(width: 10),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
