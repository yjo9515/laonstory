import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../../common/util/static_logic.dart';
import '../../common/widget/edit_text_field_widget.dart';
import '../etc/bloc/detail_bloc.dart';
import '../settings/model/admin_setting_model.dart';
import 'binding.dart';

class NoticeDialog {
  static show(BuildContext context, {Notice? value, Function()? onChange}) {
    return dialog(context, ShowNoticeDialog(value: value ?? const Notice(), onChange: onChange ?? () => {}));
  }

  static add(BuildContext context, {Function()? onChange}) {
    return dialog(context, AddNoticeDialog(onChange: onChange ?? () => {}));
  }

  static edit(BuildContext context, {Notice? value, Function()? onChange}) {
    return dialog(context, EditNoticeDialog(value: value ?? const Notice(), onChange: onChange ?? () => {}));
  }
}

class ShowNoticeDialog extends StatelessWidget {
  const ShowNoticeDialog({
    Key? key,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  final Notice value;
  final Function() onChange;

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        '공지사항 상세정보',
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
                        DialogDataWidget(
                          title: '등록일자',
                          content: timeParser(value.createdAt, true),
                        ),
                        DialogDataWidget(title: '공지사항 제목', content: value.title ?? ""),
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
                            NoticeDialog.edit(context, value: value, onChange: onChange);
                          },
                          child: Text(
                            '공지사항 수정',
                            style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                          )),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditNoticeDialog extends StatefulWidget {
  const EditNoticeDialog({
    Key? key,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  final Notice value;
  final Function() onChange;

  @override
  State<EditNoticeDialog> createState() => _EditNoticeDialogState();
}

class _EditNoticeDialogState extends State<EditNoticeDialog> {
  bool showHtml = true;

  final TextEditingController titleController = TextEditingController();
  final HtmlEditorController contentController = HtmlEditorController();

  @override
  void initState() {
    titleController.text = widget.value.title ?? "";
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
                          label: '공지사항 제목',
                          controller: titleController,
                          onFieldSubmitted: (text) => () {},
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
                          hint: '공지사항 내용입력',
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
                        context.read<DetailBloc>().add(EditNotice(widget.value.id ?? '0', {
                              'title': titleController.text,
                              'content': await contentController.getText(),
                              'noticeType': 'NOTICE',
                            }));
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
                        context.read<DetailBloc>().add(DeleteNotice(widget.value.id ?? '0'));
                        widget.onChange();
                      },
                      child: Text(
                        '공지사항 삭제',
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

class AddNoticeDialog extends StatefulWidget {
  const AddNoticeDialog({Key? key, required this.onChange}) : super(key: key);

  final Function() onChange;

  @override
  State<AddNoticeDialog> createState() => _AddNoticeDialogState();
}

class _AddNoticeDialogState extends State<AddNoticeDialog> {
  bool showHtml = true;

  final TextEditingController titleController = TextEditingController();
  final HtmlEditorController contentController = HtmlEditorController();

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
                          label: '공지사항 제목',
                          controller: titleController,
                          onFieldSubmitted: (text) => () {},
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
                          hint: '공지사항 내용입력',
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
                            context.read<DetailBloc>().add(AddNotice({
                                  'title': titleController.text,
                                  'content': await contentController.getText(),
                                  'noticeType': 'NOTICE',
                                }));
                            widget.onChange();
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
