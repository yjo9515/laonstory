import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:union_management/admin/pay/model/admin_pay_model.dart';
import 'package:union_management/common/util/static_logic.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../../common/widget/dropdown_menu_widget.dart';
import '../../common/widget/edit_text_field_widget.dart';
import '../etc/bloc/detail_bloc.dart';
import '../user/model/admin_user_model.dart';

class PayDialog {
  static add(BuildContext context, {required User user, required Function() onSave}) {
    return dialog(context, AddPayDialog(user: user, onSave: onSave));
  }

  static edit(BuildContext context, {required String id, required User user, required Pay pay, required Function() onSave}) {
    return dialog(
        context,
        EditPayDialog(
          id: id,
          pay: pay,
          onSave: onSave,
          user: user,
        ));
  }
}

class AddPayDialog extends StatefulWidget {
  const AddPayDialog({Key? key, required this.onSave, required this.user}) : super(key: key);

  final User user;
  final Function() onSave;

  @override
  State<AddPayDialog> createState() => _AddPayDialogState();
}

class _AddPayDialogState extends State<AddPayDialog> {
  final TextEditingController sortController = TextEditingController(text: '추가');
  final TextEditingController dateController = TextEditingController();
  late final TextEditingController nameController;
  late final TextEditingController serialController;
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  @override
  void initState() {
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
                    '출자금 내역 등록',
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
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '조합원 번호', '조합원 번호를 입력해 주세요.', serialController, enabled: false),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          '구분',
                          style: textTheme(context).krSubtext2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownMenuWidget<String>(
                        dropdownList: const ['추가', '반환'],
                        onChanged: (value) {
                          sortController.text = value ?? "";
                        },
                        value: sortController.text,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '일시', '추가, 반환 된 일시를 선택해 주세요.', dateController, datePick: true, enabled: false),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '계좌번호', '추가, 반환한 계좌번호를 입력하세요.', bankAccountController),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '구좌', '구좌 수를 입력해 주세요.', accountController, isNumber: true),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '출자금(원)', '출자금을 입력해 주세요.', priceController, isNumber: true),
                      const SizedBox(
                        height: 16,
                      ),
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
                              context.read<DetailBloc>().add(AddPay(widget.user.id ?? "0", {
                                    'sort': sortController.text,
                                    'date': dateController.text,
                                    'name': nameController.text,
                                    'serial': serialController.text,
                                    'bankAccount': bankAccountController.text,
                                    'account': int.parse(accountController.text),
                                    'price': int.parse(priceController.text),
                                    'memo': memoController.text,
                                    'figure': sortController.text == '추가' ? 'FIGURES_ADD' : 'FIGURES_SUB'
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
                                  '출자금 내역 저장',
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

  Widget dataInputWidget(BuildContext context, String title, String hint, TextEditingController controller, {bool isMemo = false, bool isNumber = false, bool datePick = false, bool enabled = true}) {
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

class EditPayDialog extends StatefulWidget {
  const EditPayDialog({Key? key, required this.id, required this.onSave, required this.pay, required this.user}) : super(key: key);

  final String id;
  final Pay pay;
  final User user;
  final Function() onSave;

  @override
  State<EditPayDialog> createState() => _EditPayDialogState();
}

class _EditPayDialogState extends State<EditPayDialog> {
  final TextEditingController sortController = TextEditingController(text: '추가');
  late final TextEditingController dateController;
  late final TextEditingController nameController;
  late final TextEditingController serialController;
  late final TextEditingController bankAccountController;
  late final TextEditingController accountController;
  late final TextEditingController priceController;
  late final TextEditingController memoController;

  @override
  void initState() {
    dateController = TextEditingController(text: dateFormatParser(widget.pay.payTime));
    nameController = TextEditingController(text: widget.user.name);
    serialController = TextEditingController(text: widget.user.serialNumber);
    bankAccountController = TextEditingController(text: widget.pay.bankAccount);
    accountController = TextEditingController(text: (widget.pay.account ?? ((widget.pay.amount ?? 0) / 10000)).toString());
    priceController = TextEditingController(text: widget.pay.amount.toString());
    memoController = TextEditingController(text: widget.pay.memo);
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
                    '출자금 내역 수정',
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
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '조합원 번호', '조합원 번호를 입력해 주세요.', serialController, enabled: false),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          '구분',
                          style: textTheme(context).krSubtext2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownMenuWidget<String>(
                        dropdownList: const ['추가', '반환'],
                        onChanged: (value) {
                          sortController.text = value ?? "";
                        },
                        value: sortController.text,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '일시', '추가, 반환 된 일시를 선택해 주세요.', dateController, datePick: true, enabled: false),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '계좌번호', '추가, 반환한 계좌번호를 입력하세요.', bankAccountController),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '구좌', '구좌 수를 입력해 주세요.', accountController, isNumber: true),
                      const SizedBox(
                        height: 16,
                      ),
                      dataInputWidget(context, '출자금(원)', '출자금을 입력해 주세요.', priceController, isNumber: true),
                      const SizedBox(
                        height: 16,
                      ),
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
                              context.read<DetailBloc>().add(EditPay(widget.pay.id ?? "0", {
                                    'sort': sortController.text,
                                    'date': dateController.text,
                                    'name': nameController.text,
                                    'serial': serialController.text,
                                    'bankAccount': bankAccountController.text,
                                    'account': int.parse(accountController.text),
                                    'price': int.parse(priceController.text),
                                    'memo': memoController.text,
                                    'figure': sortController.text == '추가' ? 'FIGURES_ADD' : 'FIGURES_SUB'
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
                                  '출자금 내역 저장',
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

  Widget dataInputWidget(BuildContext context, String title, String hint, TextEditingController controller, {bool isMemo = false, bool isNumber = false, bool datePick = false, bool enabled = true}) {
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
