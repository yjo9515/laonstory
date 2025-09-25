import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/features.dart';
import 'package:jeju_host_app/features/review/bloc/review_event.dart';

import '../bloc/review_bloc.dart';
import '../bloc/review_state.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({super.key, this.room});

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          textTitle: '리뷰 남기기',
          backButton: true,
        ),
        body: BlocProvider(
          create: (context) => ReviewBloc(),
          child: BlocConsumer<ReviewBloc, ReviewState>(
            listener: (context,state){
              if (state.status == CommonStatus.ready){
                context.push('/reservation/review/done');
              }else if (state.status == CommonStatus.failure){
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
                            onPressed: () => Navigator.pop(context, '확인'),
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    });
              }
            },
            builder: (BuildContext context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoomListWidget(
                      room: room,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '숙소는 청결했나요?',
                            style: context.textTheme.krBody1
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            child: RatingBar.builder(
                              itemSize: 32,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                context.read<ReviewBloc>().add(Rating(
                                    type: 'clean', score: rating.toInt()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '호스트는 친절했나요?',
                            style: context.textTheme.krBody1
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            child: RatingBar.builder(
                              itemSize: 32,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                context.read<ReviewBloc>().add(Rating(
                                    type: 'kindness', score: rating.toInt()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '숙소는 청결했나요?',
                            style: context.textTheme.krBody1
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            child: RatingBar.builder(
                              itemSize: 32,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                context.read<ReviewBloc>().add(Rating(
                                    type: 'explain', score: rating.toInt()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    InputWidget(

                      onChange: (value){
                        context.read<ReviewBloc>().add(AddContent(value));
                      },
                      hint: '리뷰를 자유롭게 작성해주세요',
                      format: TextInputType.text,
                      maxLength: 500,
                      count: true,
                      minLines: 5,
                      maxLines: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: LargeButton(
                        text: '리뷰 등록',
                        onTap: () {
                          context.read<ReviewBloc>().add(Add());
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
class AddReviewDonePage extends StatefulWidget {
  const AddReviewDonePage({Key? key}) : super(key: key);

  @override
  State<AddReviewDonePage> createState() => _AddReviewDonePageState();
}

class _AddReviewDonePageState extends State<AddReviewDonePage> {
  late final ConfettiController _controllerCenter;
  late final StreamSubscription<int>? _tickerSubscription;
  int second = 3;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
    HapticFeedback.mediumImpact();
    _tickerSubscription = Ticker.to.timer(time: 3).timeout(const Duration(seconds: 5), onTimeout: (_) {
      context.go('/');
      // context.go('/signup/host/1');

    }).listen((event) {
      if (event <= 0) {
        context.go('/');
        // context.go('/signup/host/1');
      }
      setState(() {
        second = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.activeButton,
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('', style: context.textTheme.krBody5.copyWith(color: white)),
              const Spacer(),
              const SizedBox(height: 32),
              Text('리뷰 등록이 완료되었어요!', style: context.textTheme.krPoint1.copyWith(color: white)),
              const SizedBox(height: 56),
              Text('제주살이 여행이\n즐거우셨기를 바랍니다.', style: context.textTheme.krBody3.copyWith(color: white),textAlign: TextAlign.center,),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), alignment: Alignment.centerRight, child: Text('${second}초뒤 메이페이지로', style: context.textTheme.krBody5.copyWith(color: white))),
            ],
          ),
        ),
      ),
    );
  }
}