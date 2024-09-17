import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/components/color_custom.dart';
import 'package:todoapp/custom_keys/keys.dart';
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
      backgroundColor: ColorCustom.scafoldbackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Visibility(
          visible: isVisibllitiy,
          child: IconButton(
            //  highlightColor: Colors.transparent,
            icon: const Icon(Icons.cancel),
            onPressed: () {
              selectAllTasks();
            },
          ),
        ),
        //  foregroundColor: Colors.blue,
        backgroundColor: ColorCustom.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          CustomKeys.appbarTitle,
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
                          icon: Text(CustomKeys.deleteTaskButton1),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Text(
                            CustomKeys.deleteTaskButton2,
                          ),
                        ),
                      ],
                      title: Text(CustomKeys.cupertinoAlertDialog),
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
            highlightColor: Colors.transparent,
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
                      child: Lottie.asset(CustomKeys.assetsPath, repeat: false),
                    ),
                  Text(
                    CustomKeys.clearListAdd,
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
          child: FloatingActionButton(
            tooltip: CustomKeys.tooltip,
            elevation: 0,
            backgroundColor: const Color(0xff06142e),
            onPressed: createNewTaskk,
            child: const Icon(
              Icons.add,
              color: ColorCustom.fabButtonbackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
