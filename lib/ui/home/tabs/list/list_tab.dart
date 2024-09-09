// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo6/model/todo_dm.dart';
import 'package:todo6/ui/home/tabs/list/settings/todo.dart';
import 'package:todo6/utils/app_colors.dart';
import 'package:todo6/utils/app_style.dart';
import 'package:todo6/utils/date_time_extension.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedCalendarDate = DateTime.now();
  List<ToDoDm> toDosList = [];
  @override
  Widget build(BuildContext context) {
    getToDosFromDataBase();
    return Column(
      children: [
        buildCalendar(),
        Expanded(
          flex: 75,
            child: ListView.builder(
                itemCount: toDosList.length,
                itemBuilder: (context, index) {
                  return Todo(item: toDosList[index], onDelete: (todo) {  },);
                }))
      ],
    );
  }

  buildCalendar() {
    return Expanded(
      flex: 25,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                
                child: Container(
                  color: AppColors.bgColor,
                ),
              )
            ],
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: selectedCalendarDate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            itemBuilder: (context, date, isslected, onDateTapped) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCalendarDate = date;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        date.dayName,
                        style: isslected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      const Spacer(),
                      Text(
                        date.day.toString(),
                        style: isslected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              );
            },
            onDateChange: (selectedDate) {},
          ),
        ],
      ),
    );
  }

  void onDateTapped() {}

  void getToDosFromDataBase() async {
    CollectionReference todocollection =
        FirebaseFirestore.instance.collection(ToDoDm.collectionName);
    QuerySnapshot querySnapshot = await todocollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    toDosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return ToDoDm.fromFireStore(json);
    }).toList();
   toDosList.where((todo)=>
   todo.date.year == selectedCalendarDate.year &&
   todo.date.month == selectedCalendarDate.month &&
   todo.date.day == selectedCalendarDate.day).toList();
  }
}
