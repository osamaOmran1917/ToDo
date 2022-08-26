import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/add_task_bottom_sheet.dart';
import 'package:to_do_app/home/providers/settings_provider.dart';
import 'package:to_do_app/home/tasks_list/tasks_list_tab.dart';

import 'settings/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    void showAddTaskBottomSheet() {
      showModalBottomSheet(
          backgroundColor: settingsProvider.isDarkMode()
              ? Theme.of(context).secondaryHeaderColor
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          ),
          context: context,
          builder: (buildContext) {
            return AddTaskBottomSheet();
          },
          isScrollControlled: true);
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('ToDo'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: settingsProvider.isDarkMode()
            ? Theme.of(context).secondaryHeaderColor
            : null,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          unselectedItemColor:
              settingsProvider.isDarkMode() ? Color(0xFFC8C9CB) : null,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: settingsProvider.isDarkMode()
            ? null
            : StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
          selectedIndex = 0; //سيلف
          setState(() {}); // سيلف
        },
        child: Icon(Icons.add),
      ),
      body: tabs[selectedIndex],
    );
  }

  var tabs = [TasksListTab(), SettingsTab()];
}
