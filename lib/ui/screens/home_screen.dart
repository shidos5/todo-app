
import 'package:flutter/material.dart';
import 'package:todo6/ui/home/tabs/list/list_tab.dart';
import 'package:todo6/ui/home/tabs/list/setting_tab.dart';
import 'package:todo6/ui/screens/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo6/utils/app_colors.dart';


class HomeScreen extends StatefulWidget {
  static  String routeName = "Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;
  List<Widget> tabs = [const ListTab(), const SettingTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO Do List'),
        elevation: 0,
      ),
      body: tabs[currentindex],
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildButtomNavigationBar(),
    );
  }

  Widget buildButtomNavigationBar() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentindex,
            onTap: (tapIndex) {
              setState(() {
                currentindex = tapIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ]),
      );

  buildFab() => FloatingActionButton(
        onPressed: () {
          AddBottomSheet.show(context);
        },
        backgroundColor: AppColors.primary,
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 3)),
        child: const Icon(Icons.add),
      );
}
