import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:union_management/common/util/static_logic.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../../common/widget/dropdown_menu_widget.dart';
import '../../common/widget/edit_text_field_widget.dart';
import '../etc/bloc/detail_bloc.dart';
import '../event/model/admin_point_model.dart';
import '../user/model/admin_user_model.dart';

class PointDialog {
  static add(BuildContext context, {required User user, required Function() onSave, required bool isManager}) {
    return dialog(context, AddPointDialog(user: user, isManager: isManager, onSave: onSave));
  }

  static edit(BuildContext context, {required User user, required Point point, required Function() onSave, required bool isManager}) {
    return dialog(
        context,
        EditPointDialog(
          isManager: isManager,
          point: point,
          onSave: onSave,
          user: user,
        ));
  }
}

class AddPointDialog extends StatefulWidget {
  const AddPointDialog({Key? key, required this.onSave, required this.user, required this.isManager}) : super(key: key);

  final User user;
  final bool isManager;

  final Function() onSave;

  @override
  State<AddPointDialog> createState() => _AddPointDialogState();
}

class _AddPointDialogState extends State<AddPointDialog> {
  final sortController = TextEditingController(text: '지급');
  final dateController = TextEditingController();
  late final TextEditingController nameController;
  late final TextEditingController serialController;
  final pointController = TextEditingController();
  final memoController = TextEditingController();

  @override
  void initState() {
    if (widget.isManager) {
      sortController.text = '사용';
    }
    nameController = TextEditingController(text: widget.user.name);
    serialController = TextEditingController(text: widget.user.serialNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 800,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '포인트 내역 등록',
                    style: textTheme(context).krBody2,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(width: 1, color: gray2)),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataInputWidget(context, '이름', '이름을 입력해 주세요.', nameController, enabled: false),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '조합원 번호', '조합원 번호를 입력해 주세요.', serialController, enabled: false),
                      const SizedBox(height: 16),
                      widget.isManager
                          ? dataInputWidget(context, '구분', '', sortController, enabled: false)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(margin: const EdgeInsets.symmetric(horizontal: 24), child: Text('구분', style: textTheme(context).krSubtext2)),
                                const SizedBox(height: 8),
                                DropdownMenuWidget<String>(
                                  dropdownList: const ['지급', '사용'],
                                  onChanged: (value) {
                                    sortController.text = value ?? "";
                                  },
                                  value: sortController.text,
                                ),
                              ],
                            ),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '일시', '지급 또는 사용일시를 선택해 주세요.', dateController, enabled: false, datePick: true),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '포인트(점)', '포인트를 입력해 주세요.', pointController, isNumber: true),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '메모', '메모를 입력해주세요.', memoController, isMemo: true),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: BlocProvider(
                    create: (context) => DetailBloc(),
                    child: BlocBuilder<DetailBloc, DetailState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () async {
                              context.read<DetailBloc>().add(AddPoint(widget.user.id ?? '0', {
                                    'sort': sortController.text,
                                    'date': dateController.text,
                                    'name': nameController.text,
                                    'serial': serialController.text,
                                    'point': int.parse(pointController.text),
                                    'memo': memoController.text,
                                    'figure': sortController.text == '지급' ? 'FIGURES_ADD' : 'FIGURES_SUB'
                                  }));
                              await context.read<DetailBloc>().stream.first.then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                widget.onSave();
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '포인트 내역 저장',
                                  style: textTheme(context).krBody2,
                                )));
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return DateFormat('yyyy-MM-dd').format(selected ?? DateTime.now());
  }

  Widget dataInputWidget(
    BuildContext context,
    String title,
    String hint,
    TextEditingController controller, {
    bool isMemo = false,
    bool isNumber = false,
    bool datePick = false,
    bool enabled = true,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme(context).krSubtext2,
            ),
            const SizedBox(height: 8),
            IntrinsicHeight(
              child: SizedBox(
                width: double.infinity,
                child: EditTextFieldWidget(
                  onClick: (data) async {
                    if (datePick) {
                      controller.text = await _selectDate(context);
                    }
                  },
                  isNumber: isNumber,
                  textInputAction: isMemo ? TextInputAction.newline : TextInputAction.done,
                  hint: hint,
                  fill: datePick,
                  minLines: isMemo ? 3 : 1,
                  enabled: enabled,
                  maxLines: isMemo ? 10 : 1,
                  controller: controller,
                  onFieldSubmitted: (text) => () {},
                ),
              ),
            ),
          ],
        ));
  }
}

class EditPointDialog extends StatefulWidget {
  const EditPointDialog({Key? key, required this.onSave, required this.user, required this.point, required this.isManager}) : super(key: key);

  final User user;
  final Point point;
  final Function() onSave;
  final bool isManager;

  @override
  State<EditPointDialog> createState() => _EditPointDialogState();
}

class _EditPointDialogState extends State<EditPointDialog> {
  final sortController = TextEditingController(text: '지급');
  final dateController = TextEditingController();
  late final TextEditingController nameController;
  late final TextEditingController serialController;
  final pointController = TextEditingController();
  final memoController = TextEditingController();

  @override
  void initState() {
    if (widget.isManager) {
      sortController.text = '사용';
    }
    nameController = TextEditingController(text: widget.user.name);
    serialController = TextEditingController(text: widget.user.serialNumber);
    sortController.text = widget.point.sort ?? '';
    dateController.text = dateFormatParser(widget.point.payTime);
    pointController.text = (widget.point.amount ?? 0).toString();
    memoController.text = widget.point.memo ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 800,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '포인트 내역 수정',
                    style: textTheme(context).krBody2,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(width: 1, color: gray2)),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataInputWidget(context, '이름', '이름을 입력해 주세요.', nameController, enabled: false),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '조합원 번호', '조합원 번호를 입력해 주세요.', serialController, enabled: false),
                      const SizedBox(height: 16),
                      widget.isManager
                          ? dataInputWidget(context, '구분', '', sortController, enabled: false)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(margin: const EdgeInsets.symmetric(horizontal: 24), child: Text('구분', style: textTheme(context).krSubtext2)),
                                const SizedBox(height: 8),
                                DropdownMenuWidget<String>(
                                  dropdownList: const ['지급', '사용'],
                                  onChanged: (value) {
                                    sortController.text = value ?? "";
                                  },
                                  value: sortController.text,
                                ),
                              ],
                            ),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '일시', '지급 또는 사용일시를 선택해 주세요.', dateController, enabled: false, datePick: true),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '포인트(점)', '포인트를 입력해 주세요.', pointController, isNumber: true),
                      const SizedBox(height: 16),
                      dataInputWidget(context, '메모', '메모를 입력해주세요.', memoController, isMemo: true),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: BlocProvider(
                    create: (context) => DetailBloc(),
                    child: BlocBuilder<DetailBloc, DetailState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () async {
                              context.read<DetailBloc>().add(EditPoint(widget.point.id ?? '0', {
                                    'sort': sortController.text,
                                    'date': dateController.text,
                                    'name': nameController.text,
                                    'serial': serialController.text,
                                    'point': int.parse(pointController.text),
                                    'memo': memoController.text,
                                    'figure': sortController.text == '지급' ? 'FIGURES_ADD' : 'FIGURES_SUB'
                                  }));
                              await context.read<DetailBloc>().stream.first.then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                widget.onSave();
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '포인트 내역 저장',
                                  style: textTheme(context).krBody2,
                                )));
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return DateFormat('yyyy-MM-dd').format(selected ?? DateTime.now());
  }

  Widget dataInputWidget(
    BuildContext context,
    String title,
    String hint,
    TextEditingController controller, {
    bool isMemo = false,
    bool isNumber = false,
    bool datePick = false,
    bool enabled = true,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme(context).krSubtext2,
            ),
            const SizedBox(height: 8),
            IntrinsicHeight(
              child: SizedBox(
                width: double.infinity,
                child: EditTextFieldWidget(
                  onClick: (data) async {
                    if (datePick) {
                      controller.text = await _selectDate(context);
                    }
                  },
                  isNumber: isNumber,
                  textInputAction: isMemo ? TextInputAction.newline : TextInputAction.done,
                  hint: hint,
                  minLines: isMemo ? 3 : 1,
                  enabled: enabled,
                  maxLines: isMemo ? 10 : 1,
                  controller: controller,
                  onFieldSubmitted: (text) => () {},
                ),
              ),
            ),
          ],
        ));
  }
}
