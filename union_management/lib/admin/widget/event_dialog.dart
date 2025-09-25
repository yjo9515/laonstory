import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../../common/util/static_logic.dart';
import '../../common/widget/edit_text_field_widget.dart';
import '../etc/bloc/detail_bloc.dart';
import '../event/model/admin_event_model.dart';
import 'binding.dart';

class EventDialog {
  static show(BuildContext context, {Event? value, Function()? onChange}) {
    return dialog(context, ShowEventDialog(value: value ?? const Event(), onChange: onChange ?? () => {}));
  }

  static add(BuildContext context, {Function()? onChange}) {
    return dialog(context, AddEventDialog(onChange: onChange ?? () => {}));
  }

  static edit(BuildContext context, {Event? value, Function()? onChange}) {
    return dialog(context, EditEventDialog(value: value ?? const Event(), onChange: onChange ?? () => {}));
  }
}

class ShowEventDialog extends StatelessWidget {
  const ShowEventDialog({Key? key, required this.value, required this.onChange}) : super(key: key);

  final Event value;
  final Function() onChange;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 800,
        height: 800,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '행사 상세정보',
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
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: const Color(0xffF0F1F5),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 16.0,
                children: [
                  DialogDataWidget(title: '등록일자', content: timeParser(value.createdAt, true)),
                  DialogDataWidget(
                    title: '행사제목',
                    content: value.title ?? "",
                  ),
                  DialogDataWidget(
                    title: '진행일자',
                    content: dateParser(value.eventTime, true),
                  ),
                  DialogDataWidget(
                    title: '참여 지급포인트',
                    content: numberFormatter(value.point),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: (value.content ?? "").replaceAll('font-feature-settings: normal;', ''),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      EventDialog.edit(context, value: value, onChange: onChange);
                    },
                    child: Text(
                      '행사정보 수정',
                      style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditEventDialog extends StatefulWidget {
  const EditEventDialog({
    Key? key,
    required this.value,
    required this.onChange,
    this.canEdit = true,
  }) : super(key: key);

  final Event value;
  final Function() onChange;
  final bool canEdit;

  @override
  State<EditEventDialog> createState() => _EditEventDialogState();
}

class _EditEventDialogState extends State<EditEventDialog> {
  bool showHtml = true;

  final TextEditingController titleController = TextEditingController();
  final HtmlEditorController contentController = HtmlEditorController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pointController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.value.title ?? "";
    dateController.text = dateParser(widget.value.eventTime, true);
    pointController.text = widget.value.point.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 800,
        height: 800,
        child: BlocProvider(
          create: (context) => DetailBloc(),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: EditTextFieldWidget(
                          label: '행사 제목',
                          controller: titleController,
                          onFieldSubmitted: (text) => () {},
                        ),
                      ),
                      const SizedBox(width: 36),
                      SizedBox(
                        width: 150,
                        child: EditTextFieldWidget(
                          label: '포인트',
                          controller: pointController,
                          onFieldSubmitted: (text) => () {},
                        ),
                      ),
                      const SizedBox(width: 36),
                      IntrinsicWidth(
                        child: EditTextFieldWidget(
                          onClick: (data) async {
                            setState(() {
                              showHtml = false;
                            });
                            _selectDate(context).then((value) {
                              dateController.text = value;
                              setState(() {
                                showHtml = true;
                              });
                            });
                          },
                          hint: '',
                          label: '진행일자',
                          controller: dateController,
                          enabled: false,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (showHtml)
                    Expanded(
                      child: HtmlEditor(
                        controller: contentController,
                        callbacks: Callbacks(
                            onChangeContent: (data) {},
                            onInit: () {
                              contentController.setFullScreen();
                            }),
                        htmlEditorOptions: HtmlEditorOptions(
                          hint: '행사 내용입력',
                          spellCheck: true,
                          initialText: widget.value.content ?? "",
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(
                          textStyle: textTheme(context).krSubtitle1R,
                          toolbarType: ToolbarType.nativeGrid,
                        ),
                        otherOptions: const OtherOptions(height: 480),
                      ),
                    ),
                  if (!showHtml) const Spacer(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        context.read<DetailBloc>().add(EditEvent(widget.value.id ?? '0',
                            {'title': titleController.text, 'content': await contentController.getText(), 'point': pointController.text, 'eventTime': dateFormatter(dateController.text).toString()}));
                        widget.onChange();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          '저장',
                          style: textTheme(context).krBody2,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<DetailBloc>().add(DeleteEvent(widget.value.id ?? '0'));
                        widget.onChange();
                      },
                      child: Text(
                        '행사 삭제',
                        style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({Key? key, required this.onChange}) : super(key: key);

  final Function() onChange;

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  bool showHtml = true;

  final TextEditingController titleController = TextEditingController();
  final HtmlEditorController contentController = HtmlEditorController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 800,
        height: 800,
        child: BlocProvider(
          create: (context) => DetailBloc(),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: EditTextFieldWidget(
                          label: '행사 제목',
                          controller: titleController,
                          onFieldSubmitted: (text) => () {},
                        ),
                      ),
                      const SizedBox(width: 36),
                      SizedBox(
                        width: 150,
                        child: EditTextFieldWidget(
                          label: '포인트',
                          controller: pointController,
                          onFieldSubmitted: (text) => () {},
                        ),
                      ),
                      const SizedBox(width: 36),
                      IntrinsicWidth(
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 150),
                          child: EditTextFieldWidget(
                            onClick: (data) async {
                              setState(() {
                                showHtml = false;
                              });
                              _selectDate(context).then((value) {
                                dateController.text = value;
                                setState(() {
                                  showHtml = true;
                                });
                              });
                            },
                            hint: '',
                            label: '진행일자',
                            controller: dateController,
                            enabled: false,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (showHtml)
                    Expanded(
                      child: HtmlEditor(
                        controller: contentController,
                        callbacks: Callbacks(
                            onChangeContent: (data) {},
                            onInit: () {
                              contentController.setFullScreen();
                            }),
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: '행사 내용입력',
                          shouldEnsureVisible: true,
                          spellCheck: true,
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(textStyle: textTheme(context).krSubtitle1R, toolbarType: ToolbarType.nativeGrid),
                        otherOptions: const OtherOptions(height: 480),
                      ),
                    ),
                  if (!showHtml) const Spacer(),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            context
                                .read<DetailBloc>()
                                .add(AddEvent({'title': titleController.text, 'content': await contentController.getText(), 'point': pointController.text, 'eventTime': dateController.text}));
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                '저장',
                                style: textTheme(context).krBody2,
                              ))))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<String> _selectDate(BuildContext context) async {
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
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
