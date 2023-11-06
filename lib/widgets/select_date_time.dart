import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/widgets/widgets.dart';

import '../utils/utils.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            readOnly: true,
            hintText: DateFormat.yMMMd().format(date),
            suffixIcon: IconButton(
                onPressed: () => _selectDate(context, ref),
                icon: const FaIcon(FontAwesomeIcons.calendar)),
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            readOnly: true,
            hintText: Helpers.timeToString(time),
            suffixIcon: IconButton(
                onPressed: () => _selectTime(context, ref),
                icon: const FaIcon(FontAwesomeIcons.clock)),
          ),
        ),
      ],
    );
  }
}

void _selectTime(BuildContext context, WidgetRef ref) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    ref.read(timeProvider.notifier).state = pickedTime;
  }
}

void _selectDate(BuildContext context, WidgetRef ref) async {
  final initialDate = ref.read(dateProvider);

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2023),
    lastDate: DateTime(2090),
  );

  if (pickedDate != null) {
    ref.read(dateProvider.notifier).state = pickedDate;
  }
}
