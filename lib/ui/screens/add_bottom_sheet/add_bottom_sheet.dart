// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo6/model/todo_dm.dart';
import 'package:todo6/utils/app_style.dart';
import 'package:todo6/utils/date_time_extension.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const AddBottomSheet(),
            ));
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'add new task',
            textAlign: TextAlign.center,
            style: AppStyle.bottomSheetTitle,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'enter task title'),
            controller: titleController,
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            decoration:
                const InputDecoration(hintText: 'enter task description'),
            controller: descriptionController,
          ),
          Text(
            'select date',
            style: AppStyle.bottomSheetTitle.copyWith(fontSize: 16),
          ),
          InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                selectedDate.toFormatDate,
                style: AppStyle.normalGreyTextStyle,
                textAlign: TextAlign.center,
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addToDoTODatabase();
              },
              child: const Text('Add'))
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            initialDate: selectedDate) ??
        selectedDate;
    setState(() {});
  }

  void addToDoTODatabase() {
    CollectionReference toDoCollection =
        FirebaseFirestore.instance.collection(ToDoDm.collectionName);
    DocumentReference doc = toDoCollection.doc();
    ToDoDm toDoDm = ToDoDm(
        id: doc.id,
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
        isDone: false);
    doc.set(toDoDm.toJson()).timeout(
      const Duration(microseconds: 500),
      onTimeout: () {
        Navigator.pop(context);
      },
    );
  }
}
