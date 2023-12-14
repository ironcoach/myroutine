// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/screens/create_routine_screen.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

class DisplayListOfRoutines extends ConsumerWidget {
  const DisplayListOfRoutines({
    Key? key,
    required this.routines,
  }) : super(key: key);

  final List<Routine> routines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    // final height =
    //     isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyRoutinesMessage =
        routines.isEmpty ? 'No Routines' : 'There are no tasks';

    return CommonContainer(
      height: deviceSize.height * 0.25,
      child: routines.isEmpty
          ? Center(
              child: Text(
                emptyRoutinesMessage,
                style: context.textTheme.titleLarge,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: routines.length,
              itemBuilder: (ctx, index) {
                final routine = routines[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateRoutineScreen(
                                action: "edit",
                                title: routine.title,
                                note: routine.note,
                                id: routine.id!,
                              )),
                    );
                    // context.pushNamed(
                    //   "createRoutine",
                    //   pathParameters: {
                    //     "action": "Edit",
                    //     "title": "${routine.title}",
                    //     "note": "${routine.note}",
                    //     "id": "${routine.id}",
                    //   },
                    // );
                  },
                  onLongPress: () {
                    AppAlerts.showDeleteRoutine(context, ref, routine);
                  },
                  child: RoutineTile(
                    routine: routine,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
    );
  }
}
