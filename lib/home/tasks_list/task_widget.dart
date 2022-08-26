import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/database/my_database.dart';
import 'package:to_do_app/dialogeUtils.dart';
import 'package:to_do_app/home/tasks_list/task_edit.dart';
import 'package:to_do_app/my_theme.dart';

import '../../database/Task.dart';

class TaskWidget extends StatelessWidget {
  Task task;

  TaskWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                MyDatabase.deleteTask(task).then((value) {
                  showMessage(context,
                      AppLocalizations.of(context)!.task_deleted_successfully,
                      posActionName: AppLocalizations.of(context)!.ok);
                }).onError((error, stackTrace) {
                  showMessage(
                      context,
                      AppLocalizations.of(context)!
                          .something_went_wrong_try_again_later,
                      posActionName: AppLocalizations.of(context)!.ok);
                }).timeout(Duration(seconds: 5), onTimeout: () {
                  showMessage(context,
                      AppLocalizations.of(context)!.data_deleted_locally,
                      posActionName: AppLocalizations.of(context)!.ok);
                });
              },
              icon: Icons.delete,
              backgroundColor: MyTheme.red,
              label: AppLocalizations.of(context)!.delete,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (_) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskEdit(task)));
              },
              icon: Icons.edit,
              backgroundColor: MyTheme.green,
              label: AppLocalizations.of(context)!.edit,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 80,
                decoration: BoxDecoration(
                    color: task.isDone!
                        ? MyTheme.green
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: task.isDone! ? MyTheme.green : null)),
                    SizedBox(
                      width: 8,
                    ),
                    Row(children: [
                      Text(
                        task.description ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ])
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              task.isDone!
                  ? Text(
                      AppLocalizations.of(context)!.done,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.green),
                    )
                  : InkWell(
                      onTap: () {
                        MyDatabase.editIsDone(task);
                        setState() {}
                        ;
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
