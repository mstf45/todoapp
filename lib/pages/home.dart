import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/pages/home_mixin/home_mixin.dart';
import 'package:todoapp/util/todo_tile.dart';
import 'package:hidable/hidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixinUsing {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff86A8cf),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.blue,
        backgroundColor: const Color(0xff522B5B),
        centerTitle: true,
        title: Text(
          'Projelerim',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (isSelect) {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      actions: [
                        IconButton(
                          onPressed: () {
                            deleteAllTasks();
                            Navigator.pop(context);
                          },
                          icon: const Text('Devam'),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Text('Vazgeç'),
                        ),
                      ],
                      title: const Text('Dikkat \n Tüm Notlarınız Silinecektir.!'),
                      insetAnimationCurve: Curves.easeIn,
                    );
                  },
                );
              } else {
                selectAllTasks();
              }
            },
            icon: Icon(
              isSelect ? Icons.delete : Icons.check_circle,
            ),
          ),
        ],
      ),
      body: db.toDoList.isNotEmpty
          ? ListView.builder(
              controller: scrollController,
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFuntion: (context) => deleteTask(index),
                  editFuntion: (p0) => editTask(index),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.text.isEmpty)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Lottie.asset('assets/lottie/success.json',
                          repeat: false),
                    ),
                  Text(
                    'Yeni Proje Eklemek İçin \n + \n Butonuna Basınız.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Hidable(
        controller: scrollController,
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
            tooltip: 'Yeni Not Ekle',
            elevation: 0,
            backgroundColor: const Color(0xff06142e),
            onPressed: createNewTaskk,
            label: Row(
              children: [
                Text(
                  'Yeni Bir Proje Ekle ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
