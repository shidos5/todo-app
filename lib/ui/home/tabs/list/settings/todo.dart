import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo6/model/todo_dm.dart';
import 'package:todo6/utils/app_colors.dart';
import 'package:todo6/utils/app_style.dart';

class Todo extends StatefulWidget {
  final ToDoDm item;
  final Function(ToDoDm) deleteTodo; 

  const Todo({super.key, required this.item, required this.deleteTodo});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
List <ToDoDm> todos = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 26),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteItem(), 
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                bottomLeft: Radius.circular(22),
              ),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
          ],
        ),
        child: Container(
          width: 352,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Row(
            children: [
              buildVerticalLine(context),
              const SizedBox(width: 25),
              buildTodoInfo(),
              buildTodoState(),
            ],
          ),
        ),
      ),
    );
  }
 void deleteItem() {
    setState(() {
     widget.deleteTodo(widget.item); 
    });

  }



  buildVerticalLine(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * .07,
        width: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
      );

  buildTodoInfo() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              widget.item.title,
              maxLines: 1,
              style:
                  AppStyle.bottomSheetTitle.copyWith(color: AppColors.primary),
            ),
            const Spacer(),
            Text(
              widget.item.description,
              style: AppStyle.bodyTextStyle,
            ),
            const Spacer(),
          ],
        ),
      );

  buildTodoState() => GestureDetector(
        onTap: () {
          setState(() {
            widget.item.isDone = !widget.item.isDone;
            crossFadeState = widget.item.isDone
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst;
          });
        },
        child: AnimatedCrossFade(
          firstChild: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: const Icon(
              Icons.done,
              color: Colors.white,
              size: 35,
              semanticLabel: 'Mark as Done',
            ),
          ),
          secondChild: const Text(
            "Done!",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          crossFadeState: crossFadeState,
          duration: const Duration(milliseconds: 500),
        ),
      );
 
}