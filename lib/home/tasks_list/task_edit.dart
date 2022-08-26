import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/Task.dart';

class TaskEdit extends StatelessWidget {
  static const String routeName = 'edit_task';
  Task task;

  TaskEdit(this.task);

  var formKey = GlobalKey<FormState>();
  String? titleController, descriptionController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .3,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'To Do List',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 27),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: MediaQuery.of(context).size.height * .65,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.edit_task,
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleMedium),
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      initialValue: task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.task_title),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty)
                          return AppLocalizations.of(context)!
                              .please_enter_description;
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      initialValue: task.description,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black, fontSize: 18),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty)
                          return AppLocalizations.of(context)!
                              .please_enter_description;
                        else
                          return null;
                      },
                      maxLines: 4,
                      minLines: 4,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.description),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    InkWell(
                      onTap: () {
                        // showDateDialoge();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${task.dateTime!.year}/${task.dateTime!.month}/${task.dateTime!.day}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        task.isDone = false;
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      minWidth: 255,
                      height: 55,
                      child: Text(
                        AppLocalizations.of(context)!.save_changes,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
