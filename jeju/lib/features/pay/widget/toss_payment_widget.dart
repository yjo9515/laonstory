import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jeju_host_app/features/room/bloc/room_event.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';
import 'package:jeju_host_app/core/core.dart';
import '../../room/bloc/room_detail_bloc.dart';
import '../../room/bloc/room_state.dart';

class TossPaymentWidget extends StatefulWidget {
  const TossPaymentWidget(
      {super.key,
      this.totalAmount = 0,
      this.order,
      this.name,
      this.id,
      this.dateRange,
      this.guestCount});

  final int totalAmount;
  final String? order;
  final String? name;
  final int? id;
  final int? guestCount;
  final DateRange? dateRange;

  @override
  State<TossPaymentWidget> createState() => _TossPaymentWidgetState();
}

class _TossPaymentWidgetState extends State<TossPaymentWidget> {
  var loaded = false;
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  @override
  void initState() {
    super.initState();
    _paymentWidget = PaymentWidget(
        clientKey: Env.tossTestClientKey, customerKey: "a1b2c3d4e5f67890");

    _paymentWidget
        .renderPaymentMethods(
            selector: 'methods',
            amount: Amount(
                value: widget.totalAmount,
                currency: Currency.KRW,
                country: "KR"))
        .then((control) async {
      _paymentMethodWidgetControl = control;
      await _paymentMethodWidgetControl
          ?.getSelectedPaymentMethod()
          .then((value) {
        setState(() {
          loaded = true;
        });
      });
    });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  PaymentMethodWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'methods',
                  ),
                  AgreementWidget(
                      paymentWidget: _paymentWidget, selector: 'agreement'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            if (loaded)
              BlocProvider(
                  create: (context) =>
                      RoomDetailBloc(),
                        // ..add(Initial(id: widget.id.toString())),
                  child: BlocConsumer<RoomDetailBloc, RoomDetailState>(
                    builder: (context, state) {
                      return LargeButton(
                        text: '${numberFormatter(widget.totalAmount)} 원 결제하기',
                        onTap: () async {
                          logger.d(widget.id);
                          logger.d({
                            'beforeAmount': 0,
                            'endDate': DateFormat('yyyy-MM-dd').format(widget.dateRange!.end),
                            'orderNumber': widget.order,
                            'startDate': DateFormat('yyyy-MM-dd').format(widget.dateRange!.start),
                            'people': widget.guestCount,
                          });

                          await _paymentWidget.requestPayment(paymentInfo: PaymentInfo(orderId: '${widget.order}', orderName: '${widget.name}')).then((value) {
                          if (value.success != null) {

                            context.read<RoomDetailBloc>().add(OnReservation(
                                accommodationId: widget.id,
                                request: {
                                  'beforeAmount': 0,
                                  'endDate': DateFormat('yyyy-MM-dd').format(widget.dateRange!.end),
                                  'orderNumber': widget.order,
                                  'people': widget.guestCount,
                                  'startDate': DateFormat('yyyy-MM-dd').format(widget.dateRange!.start),
                                  'payment' : {
                                    'amount': value.success?.amount,
                                    'orderId' : value.success?.orderId,
                                    'paymentKey' : value.success?.paymentKey
                                  }
                                }
                                ));
                          } else if (value.fail != null) {
                            context.read<RoomDetailBloc>().add(const Error(LogicalException(message: '결제에 실패했습니다.')));
                          }
                          });
                        },
                      );
                    },
                    listener: (context, state) {
                      if (state.status == CommonStatus.failure) {
                        showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog.adaptive(
                                title: const Text(
                                  '알림',
                                ),
                                content: Text(
                                  state.errorMessage ?? '',
                                ),
                                actions: <Widget>[
                                  adaptiveAction(
                                    context: context,
                                    onPressed: () =>
                                        Navigator.pop(context, '확인'),
                                    child: const Text('확인'),
                                  ),
                                ],
                              );
                            });
                      } else if (state.status == CommonStatus.success) {
                        context.push('/pay/done');
                      }
                    },
                  )),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
