import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/database/my_database.dart';
import 'package:to_do_app/dialogeUtils.dart';
import 'package:to_do_app/home/providers/settings_provider.dart';
import '../database/Task.dart';
import '../date_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_task,
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium),
              textAlign: TextAlign.center,
            ),
            TextFormField(
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty)
                  return AppLocalizations.of(context)!.please_enter_title;
                else
                  return null;
              },
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.task_title),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: descriptionController,
              validator: (text) {
                if (text == null || text.trim().isEmpty)
                  return AppLocalizations.of(context)!.please_enter_description;
                else
                  return null;
              },
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 4,
              minLines: 4,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.description),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              AppLocalizations.of(context)!.select_date,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            InkWell(
              onTap: () {
                showDateDialoge();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text(AppLocalizations.of(context)!.add))
          ],
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  void showDateDialoge() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 10 + 3)));
    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      String title = titleController.text;
      String description = descriptionController.text;
      Task task = Task(
          title: title,
          description: description,
          dateTime: dateOnly(selectedDate),
          isDone: false);
      showLoading(context, AppLocalizations.of(context)!.loading,
          isCancelable: false);
      MyDatabase.insertTask(task).then((value) {
        showMessage(
            context, AppLocalizations.of(context)!.task_added_successfully,
            posActionName: AppLocalizations.of(context)!.ok, posAction: () {
          Navigator.pop(context);
        });
      }).onError((error, stackTrace) {
        showMessage(context,
            AppLocalizations.of(context)!.something_went_wrong_try_again_later,
            posActionName: AppLocalizations.of(context)!.ok, posAction: () {
          Navigator.pop(context);
        });
      }).timeout(Duration(seconds: 5), onTimeout: () {
        showMessage(context, AppLocalizations.of(context)!.task_saved_locally,
            posActionName: AppLocalizations.of(context)!.ok, posAction: () {
          Navigator.pop(context);
        });
      });
    }
  }
}
