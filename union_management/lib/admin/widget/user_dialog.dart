import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:union_management/common/util/logger.dart';

import '../../common/style.dart';
import '../../common/util/dialog_logic.dart';
import '../../common/util/static_logic.dart';
import '../../common/widget/common_table_data.dart';
import '../../common/widget/dropdown_menu_widget.dart';
import '../../common/widget/edit_text_field_widget.dart';
import '../etc/bloc/detail_bloc.dart';
import '../event/model/admin_point_model.dart';
import '../pay/model/admin_pay_model.dart';
import '../user/model/admin_user_model.dart';
import 'point_dialog.dart';
import '../../common/enum/enums.dart';
import 'binding.dart';

class UserDialog {
  static show(BuildContext context, {User? value, Function()? onChange, bool isManager = false}) {
    return dialog(context, ShowUserDialog(value: value ?? const User(), onChange: onChange ?? () => {}, isManager: isManager));
  }

  static add(BuildContext context, {Function()? onChange}) {
    return dialog(context, AddUserDialog(onChange: onChange ?? () => {}));
  }

  static edit(BuildContext context, {User? value, Function()? onChange}) {
    return dialog(context, EditUserDialog(value: value ?? const User(), onChange: onChange ?? () => {}));
  }
}

class ShowUserDialog extends StatelessWidget {
  const ShowUserDialog({Key? key, required this.value, required this.onChange, required this.isManager}) : super(key: key);

  final User value;
  final Function() onChange;
  final bool isManager;

  @override
  Widget build(BuildContext context) {

    final payTextController = TextEditingController();
    final pointTextController = TextEditingController();

    return AlertDialog(
      content: SizedBox(
        width: 1640,
        child: BlocProvider(
          create: (context) => DetailBloc()..add(Initial(id: value.id ?? "", isAdmin: !isManager)),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '회원 상세정보',
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xffF0F1F5),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              dataWidget(
                                context,
                                '조합원 번호',
                                value.serialNumber,
                              ),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              dataWidget(context, '이름', value.name),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              if(!isManager) dataWidget(context, '가입일', dateParser(value.createdAt, true)),
                              if(!isManager) Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              if(!isManager) dataWidget(context, '연락처', value.phoneNumber),
                              if(!isManager)  Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              dataWidget(context, '성별', changeGenderToString(value.gender)),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              dataWidget(
                                context,
                                '연령',
                                value.age,
                              ),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              if(!isManager) dataWidget(context, '상태', activeToString(value.active)),
                              if(!isManager) Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              if(!isManager) dataWidget(context, '구분', positionToString(value.position)),
                              if(isManager) dataWidget(context, '보유 포인트(점)', numberFormatter(value.point)),

                            ],
                          ),
                          if(!isManager) const SizedBox(
                            height: 16,
                          ),
                          if(!isManager) Row(
                            children: [
                              dataWidget(context, '주소', value.address),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              dataWidget(context, '구좌', numberFormatter(value.account)),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              dataWidget(context, '출자금(원)', numberFormatter(value.price)),
                              Container(
                                width: 1,
                                height: 24,
                                color: const Color(0xffA6AEBA),
                              ),
                              dataWidget(context, '보유 포인트(점)', numberFormatter(value.point)),
                            ],
                          ),
                          if(!isManager) const SizedBox(
                            height: 16,
                          ),
                          if(!isManager) IntrinsicHeight(
                            child: dataWidget(context, '메모', value.memo),
                          ),
                          if(!isManager) Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    UserDialog.edit(
                                      context,
                                      value: value,
                                      onChange: () {
                                        onChange();
                                      },
                                    );
                                  },
                                  child: Text(
                                    '조합원 정보 수정',
                                    style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 480,
                      width: 1640,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!isManager) Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              height: 480,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xffDDDEE2), width: 1)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '출자금 변동 내역',
                                        style: textTheme(context).krBody2,
                                      ),
                                      const Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            PayDialog.add(context, user: value, onSave: onChange);
                                          },
                                          child: Text(
                                            '출자금 내역 등록',
                                            style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                                          )),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                          width: 200,
                                          child: EditTextFieldWidget(
                                              controller: payTextController,
                                              onFieldSubmitted: (text) => () {
                                                context.read<DetailBloc>().add(PayPaginate(value.id ?? "", 1, payTextController.text));
                                                  },
                                              suffixWidget: IconButton(onPressed: () {
                                                context.read<DetailBloc>().add(PayPaginate(value.id ?? "", 1, payTextController.text));
                                              }, icon: SvgPicture.asset('assets/icons/ic_search.svg'))))
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      headingTextStyle: textTheme(context).krSubtext1B,
                                      dataTextStyle: textTheme(context).krSubtext1,
                                      dividerThickness: 3,
                                      showBottomBorder: true,
                                      columnSpacing: 0,
                                      horizontalMargin: 0,
                                      border: const TableBorder(
                                        horizontalInside: BorderSide(width: 1, color: Color(0xffDDDEE2)),
                                      ),
                                      columns: const [
                                        CommonColumn('번호'),
                                        CommonColumn('일시'),
                                        CommonColumn('이름'),
                                        CommonColumn('구분'),
                                        CommonColumn('내용'),
                                        CommonColumn('금액(원)'),
                                      ],
                                      rows: payDataWidget(context, state.pays, (pay){
                                        PayDialog.edit(context, id: pay.id ?? '0', user: value, pay: pay, onSave: () => onChange());
                                      }),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            context.read<DetailBloc>().add(PayPaginate(value.id, 1, payTextController.text));
                                          },
                                          icon: const Icon(Icons.keyboard_double_arrow_left_outlined)),
                                      IconButton(
                                          onPressed: () {
                                            var page = paginateNumber(state.payMeta?.currentPage ?? 1, state.payMeta?.totalPages ?? 1, Path.left);
                                            if (page != 0) {
                                              context.read<DetailBloc>().add(PayPaginate(value.id, page, payTextController.text));
                                            }
                                          },
                                          icon: const Icon(Icons.keyboard_arrow_left_outlined)),
                                      for (int page = getMinPage(state.payMeta?.currentPage ?? 1, state.payMeta?.totalPages ?? 1); page <= getMaxPage(state.payMeta?.currentPage ?? 1, state.payMeta?.totalPages ?? 1); page++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          child: TextButton(
                                              style: TextButton.styleFrom(backgroundColor: page == (state.payMeta?.currentPage ?? 1) ? black : white),
                                              onPressed: () {
                                                context.read<DetailBloc>().add(PayPaginate(value.id, page, payTextController.text));

                                              },
                                              child: Text(
                                                '$page',
                                                style: textTheme(context).krBody1.copyWith(color: page == (state.payMeta?.currentPage ?? 1) ? white : black),
                                              )),
                                        ),
                                      IconButton(
                                          onPressed: () {
                                            var page = paginateNumber(state.payMeta?.currentPage ?? 1, state.payMeta?.totalPages ?? 1, Path.right);
                                            if (page != 0) {
                                              context.read<DetailBloc>().add(PayPaginate(value.id, page, payTextController.text));
                                            }
                                          },
                                          icon: const Icon(Icons.keyboard_arrow_right_outlined)),
                                      IconButton(
                                          onPressed: () {
                                            context.read<DetailBloc>().add(PayPaginate(value.id, state.payMeta?.totalPages ?? 1, payTextController.text));
                                          },
                                          icon: const Icon(Icons.keyboard_double_arrow_right_outlined)),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              height: 480,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xffDDDEE2), width: 1)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '포인트 내역(활동정보)',
                                        style: textTheme(context).krBody2,
                                      ),
                                      const Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            showDialog<void>(
                                              barrierDismissible: true,
                                              barrierColor: black.withOpacity(0.1),
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AddPointDialog(
                                                  isManager: isManager,
                                                  user: value,
                                                  onSave: () {
                                                    onChange();
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            '포인트 내역 등록',
                                            style: textTheme(context).krBody2.copyWith(decoration: TextDecoration.underline, color: black),
                                          )),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                          width: 200,
                                          child: EditTextFieldWidget(
                                              controller: pointTextController,
                                              onFieldSubmitted: (text) => () {
                                                    context.read<DetailBloc>().add(PointPaginate(value.id, 1, pointTextController.text));
                                                  },
                                              suffixWidget: IconButton(onPressed: () {
                                                context.read<DetailBloc>().add(PointPaginate(value.id, 1, pointTextController.text));

                                              }, icon: SvgPicture.asset('assets/icons/ic_search.svg'))))
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      headingTextStyle: textTheme(context).krSubtext1B,
                                      dataTextStyle: textTheme(context).krSubtext1,
                                      dividerThickness: 3,
                                      showBottomBorder: true,
                                      columnSpacing: 0,
                                      horizontalMargin: 0,
                                      border: const TableBorder(
                                        horizontalInside: BorderSide(width: 1, color: Color(0xffDDDEE2)),
                                      ),
                                      columns: eventLabelWidget(context, textTheme(context).krSubtext1.copyWith(color: const Color(0xffB5B0BF))),
                                      rows: eventDataWidget(context, state.points, (point){
                                        if(isManager && point.sort == '지급') {
                                          return;
                                        }
                                        PointDialog.edit(context, isManager: isManager, user: value, point: point, onSave: () => onChange());
                                      }),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            context.read<DetailBloc>().add(PointPaginate(value.id, 1, pointTextController.text));
                                          },
                                          icon: const Icon(Icons.keyboard_double_arrow_left_outlined)),
                                      IconButton(
                                          onPressed: () {
                                            var page = paginateNumber(state.pointMeta?.currentPage ?? 1, state.pointMeta?.totalPages ?? 1, Path.left);
                                            if (page != 0) {
                                              context.read<DetailBloc>().add(PointPaginate(value.id, page, pointTextController.text));
                                            }
                                          },
                                          icon: const Icon(Icons.keyboard_arrow_left_outlined)),
                                      for (int page = getMinPage(state.pointMeta?.currentPage ?? 1, state.pointMeta?.totalPages ?? 1); page <= getMaxPage(state.pointMeta?.currentPage ?? 1, state.pointMeta?.totalPages ?? 1); page++)
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          child: TextButton(
                                              style: TextButton.styleFrom(backgroundColor: page == (state.pointMeta?.currentPage ?? 1) ? black : white),
                                              onPressed: () {
                                                context.read<DetailBloc>().add(PointPaginate(value.id, page, pointTextController.text));

                                              },
                                              child: Text(
                                                '$page',
                                                style: textTheme(context).krBody1.copyWith(color: page == (state.pointMeta?.currentPage ?? 1) ? white : black),
                                              )),
                                        ),
                                      IconButton(
                                          onPressed: () {
                                            var page = paginateNumber(state.pointMeta?.currentPage ?? 1, state.pointMeta?.totalPages ?? 1, Path.right);
                                            if (page != 0) {
                                              context.read<DetailBloc>().add(PointPaginate(value.id, page, pointTextController.text));
                                            }
                                          },
                                          icon: const Icon(Icons.keyboard_arrow_right_outlined)),
                                      IconButton(
                                          onPressed: () {
                                            context.read<DetailBloc>().add(PointPaginate(value.id, state.pointMeta?.totalPages ?? 1, pointTextController.text));
                                          },
                                          icon: const Icon(Icons.keyboard_double_arrow_right_outlined)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dataWidget(BuildContext context, String title, String? content) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 700),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme(context).krSubtext2,
            ),
            const SizedBox(height: 8),
            Text(
              content ?? "",
              maxLines: 5,
              style: textTheme(context).krSubtext1.copyWith(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ));
  }

  List<DataRow> payDataWidget(BuildContext context, List<Pay> pays, Function(Pay) onClick) {
    return pays
        .asMap()
        .entries
        .map((e) => DataRow(
        onSelectChanged: (selected) => onClick(e.value),
        cells: [
              CommonCell((e.key + 1).toString()),
              CommonCell(dateParser(e.value.payTime, true)),
              CommonCell('${e.value.user?.name}'),
              CommonCell('${e.value.sort}'),
              CommonCell(e.value.memo ?? "-"),
              CommonCell(numberFormatter(e.value.amount)),
            ]))
        .toList();
  }

  List<DataColumn> eventLabelWidget(BuildContext context, TextStyle style) {
    return [
      const CommonColumn('번호'),
      const CommonColumn('일시'),
      const CommonColumn('이름'),
      const CommonColumn('활동 유형'),
      const CommonColumn('내용'),
      const CommonColumn('포인트'),
    ];
  }

  List<DataRow> eventDataWidget(BuildContext context, List<Point> points, Function(Point) onClick) {
    return points
        .asMap()
        .entries
        .map((e) => DataRow(onSelectChanged: (selected) => onClick(e.value), cells: [
              CommonCell((e.key + 1).toString()),
              CommonCell(dateParser(e.value.payTime, true)),
              CommonCell('${e.value.user?.name}'),
              CommonCell('${e.value.sort}'),
              CommonCell(e.value.memo ?? "-"),
              CommonCell(numberFormatter(e.value.amount)),
            ]))
        .toList();
  }
}

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({Key? key, required this.onChange}) : super(key: key);

  final Function() onChange;

  @override
  Widget build(BuildContext context) {
    final positionController = TextEditingController(text: '조합원');
    final nameController = TextEditingController();
    final dateController = TextEditingController();
    final idController = TextEditingController();
    final phoneController = TextEditingController();
    final serialController = TextEditingController();
    final addressController = TextEditingController();
    final accountController = TextEditingController();
    final priceController = TextEditingController();
    final pointController = TextEditingController();
    final memoController = TextEditingController();

    return AlertDialog(
      content: SizedBox(
        width: 800,
        child: BlocProvider(
          create: (context) => DetailBloc(),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '조합원 신규 등록',
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
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                '조합원 구분',
                                style: textTheme(context).krSubtext2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownMenuWidget<String>(
                              dropdownList: const ['조합원', '대의원'],
                              onChanged: (value) {
                                positionController.text = value ?? "";
                              },
                              value: '조합원',
                            ),
                            const SizedBox(height: 16),
                            DataInputWidget(title: '이름', hint: '조합원의 이름을 입력해 주세요.', controller: nameController),
                            const SizedBox(height: 16),
                            DataInputWidget(title: '가입일', hint: '가입일을 선택해 주세요.', controller: dateController, date: true),
                            const SizedBox(height: 16),
                            DataInputWidget(title: '조합원 번호', hint: '조합원 번호를 입력해 주세요.', controller: idController),
                            const SizedBox(height: 16),
                            DataInputWidget(title: '주민등록번호', hint: '주민등록번호를 입력해 주세요.(123456-1234567)', controller: serialController, registration: true),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(title: '전화번호', hint: '연락처를 입력해 주세요.(010-1234-5678)', controller: phoneController, phone: true),
                            const SizedBox(height: 16),
                            DataInputWidget(title: '주소', hint: '주소를 입력해 주세요.', controller: addressController),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '구좌',
                              hint: '구좌 수를 입력해 주세요.',
                              controller: accountController,
                            ),
                            const SizedBox(height: 16),
                            DataInputWidget(
                              title: '출자금(원)',
                              hint: '출자금을 입력해 주세요.',
                              controller: priceController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '포인트(점)',
                              hint: '보유 포인트를 입력해 주세요..',
                              controller: pointController,
                              number: true,
                            ),
                            const SizedBox(height: 16),
                            DataInputWidget(
                              title: '메모',
                              hint: '메모를 입력해주세요.',
                              controller: memoController,
                              memo: true,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              final userData = User(
                                position: stringToPosition(positionController.text),
                                serialNumber: idController.text,
                                name: nameController.text,
                                createdAt: dateFormatter(dateController.text).toString(),
                                registrationNumber: serialController.text,
                                phoneNumber: phoneController.text,
                                address: addressController.text,
                                account: int.tryParse(accountController.text) ?? 0,
                                price: int.tryParse(priceController.text) ?? 0,
                                point: int.tryParse(pointController.text) ?? 0,
                                memo: memoController.text,
                              );
                              context.read<DetailBloc>().add(AddUser(userData.toJson()));
                              onChange();

                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '조합원 신규 등록',
                                  style: textTheme(context).krBody2,
                                ))))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({
    Key? key,
    required this.onChange,
    required this.value,
  }) : super(key: key);

  final User value;
  final Function() onChange;

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late TextEditingController positionController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController serialController = TextEditingController();
  late TextEditingController idController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController accountController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController pointController = TextEditingController();
  late TextEditingController memoController = TextEditingController();
  late TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    positionController = TextEditingController(text: positionToString(widget.value.position));
    nameController = TextEditingController(text: widget.value.name);
    dateController = TextEditingController(text: dateParser(widget.value.createdAt, true));
    phoneController = TextEditingController(text: widget.value.phoneNumber);
    serialController = TextEditingController(text: widget.value.registrationNumber);
    idController = TextEditingController(text: widget.value.serialNumber);
    addressController = TextEditingController(text: widget.value.address);
    accountController = TextEditingController(text: widget.value.account.toString());
    priceController = TextEditingController(text: widget.value.price.toString());
    pointController = TextEditingController(text: widget.value.point.toString());
    memoController = TextEditingController(text: widget.value.memo);
    statusController = TextEditingController(text: activeToString(widget.value.active));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 800,
        child: BlocProvider(
          create: (context) => DetailBloc(),
          child: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '조합원 정보 수정',
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
                            DataInputWidget(
                              title: '조합원 번호',
                              hint: '조합원의 번호를 입력해 주세요.',
                              controller: idController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                '조합원 구분',
                                style: textTheme(context).krSubtext2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownMenuWidget<String>(
                              dropdownList: const ['조합원', '대의원'],
                              onChanged: (value) {
                                positionController.text = value ?? "";
                              },
                              value: positionController.text,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                '조합원 상태',
                                style: textTheme(context).krSubtext2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownMenuWidget<String>(
                              dropdownList: const ['정상', '사망', '중복', '탈퇴'],
                              onChanged: (value) {
                                statusController.text = value ?? "";
                              },
                              value: statusController.text,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '이름',
                              hint: '조합원의 이름을 입력해 주세요.',
                              controller: nameController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '가입일',
                              hint: '가입일을 입력해 주세요.(2023년1월1일)',
                              controller: dateController,
                              date: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '주민등록번호',
                              hint: '주민등록번호를 입력해 주세요.(123456-1234567)',
                              controller: serialController,
                              registration: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '전화번호',
                              hint: '연락처를 입력해 주세요.(010-1234-5678)',
                              controller: phoneController,
                              phone: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '주소',
                              hint: '주소를 입력해 주세요.',
                              controller: addressController,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(title: '구좌', hint: '구좌 수를 입력해 주세요.', controller: accountController, number: true, enable: false),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '출자금(원)',
                              hint: '출자금을 입력해 주세요.',
                              controller: priceController,
                              number: true,
                              enable: false,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '포인트(점)',
                              hint: '보유 포인트를 입력해 주세요..',
                              controller: pointController,
                              enable: false,
                              number: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            DataInputWidget(
                              title: '메모',
                              hint: '메모를 입력해주세요.',
                              controller: memoController,
                              memo: true,
                            ),
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
                        child: ElevatedButton(
                            onPressed: () {
                              final userData = User(
                                serialNumber: idController.text,
                                position: stringToPosition(positionController.text),
                                name: nameController.text,
                                createdAt: dateFormatter(dateController.text).toString(),
                                registrationNumber: serialController.text,
                                phoneNumber: phoneController.text,
                                address: addressController.text,
                                account: int.tryParse(accountController.text) ?? 0,
                                price: int.tryParse(priceController.text) ?? 0,
                                point: int.tryParse(pointController.text) ?? 0,
                                memo: memoController.text,
                                active: stringToActive(statusController.text),
                              );
                              logger.d(userData.toJson());
                              context.read<DetailBloc>().add(EditUser(widget.value.id ?? "0", userData.toJson()));
                              widget.onChange();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '조합원 정보 수정',
                                  style: textTheme(context).krBody2,
                                )))),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            context.read<DetailBloc>().add(DeleteUser(widget.value.id ?? '0'));
                            widget.onChange();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            '조합원 정보 삭제',
                            style: textTheme(context).krBody1.copyWith(color: const Color(0xff757575), decoration: TextDecoration.underline),
                          )),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataInputWidget extends StatelessWidget {
  const DataInputWidget(
      {Key? key,
      required this.title,
      required this.hint,
      required this.controller,
      this.memo = false,
      this.number = false,
      this.date = false,
      this.phone = false,
      this.registration = false,
        this.isPassword = false,
      this.enable = true})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool memo;
  final bool number;
  final bool date;
  final bool phone;
  final bool registration;
  final bool enable;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
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
                  onClick: (text) async {
                    if (date) {
                      controller.text = await _selectDate(context);
                    }
                  },
                  enabled: !date && enable,
                  isNumber: number,
                  hint: hint,
                  isPhone: phone,
                  isPassword: isPassword,
                  textInputAction: memo ? TextInputAction.newline : TextInputAction.done,
                  minLines: memo ? 3 : 1,
                  maxLines: memo ? 10 : 1,
                  controller: controller,
                  onFieldSubmitted: (text) => () {},
                ),
              ),
            ),
          ],
        ));
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
}
