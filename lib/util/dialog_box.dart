import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          'Görev Ekle',
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
                'Yeni bir tane ekle',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                ),
              ),
              subtitle: Text(
                'Bana Görevinden Bahset',
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
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                hintText: 'Görevim ',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Save Button
                MyButton(
                  text: 'Şimdi Oluştur',
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Başarıyla Eklendi'),
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
