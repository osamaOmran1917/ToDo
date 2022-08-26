import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/database/my_database.dart';
import 'package:to_do_app/home/tasks_list/task_widget.dart';

import '../../database/Task.dart';
import '../providers/settings_provider.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            showYears: true,
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365 * 10 + 3)),
            lastDate: DateTime.now().add(Duration(days: 365 * 10 + 3)),
            onDateSelected: (date) {
              if (date == null) return;
              selectedDate = date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor:
                settingsProvider.isDarkMode() ? Colors.white : Colors.black,
            dayColor:
                settingsProvider.isDarkMode() ? Colors.white : Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              // future: MyDatabase.getAllTasks(),
              stream: MyDatabase.listenForTasksRealTimeUpdates(selectedDate),
              builder: (buildContext, snapshot) {
                if (snapshot.hasError)
                  //Assignment: Add Try Again Button
                  return Text('Error Loading Data, Please Try Again Later');
                else if (snapshot.connectionState == ConnectionState.waiting)
                  return const Center(
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator()));
                var data = snapshot.data?.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return TaskWidget(data![index]);
                  },
                  itemCount: data!.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
