import 'package:flutter/material.dart';

import '../../../core/core.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key, this.room});

  final Room? room;

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  var showMoreText = false;
  var showMoreIcon = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text('${widget.room?.name}', style: context.textTheme.krPoint1),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.star, color: pointJeJuYellow, size: 16),
              const SizedBox(width: 8),
              Text('${widget.room?.score ?? 0} (${widget.room?.reviewCount ?? 0})', style: context.textTheme.krBody1.copyWith(color: black3)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Row(
                  children: (widget.room?.theme ?? [])
                      .map(
                        (e) => Container(margin: const EdgeInsets.symmetric(horizontal: 4), child: ThemeWidget(theme: e.name ?? '')),
                      )
                      .toList(),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 24),
                Text('최대 인원 ${widget.room?.maximumPeople}명', style: context.textTheme.krBody3.copyWith(color: black3)),
                const SizedBox(width: 16),
                Text('|', style: context.textTheme.krBody3.copyWith(color: black3)),
                const SizedBox(width: 16),
                Text('반려동물 동반${widget.room?.isPossiblePet ?? false ? '가능' : '불가'}', style: context.textTheme.krBody3.copyWith(color: black3)),
                const SizedBox(width: 16),
                Text('|', style: context.textTheme.krBody3.copyWith(color: black3)),
                const SizedBox(width: 16),
                Text('숙박최소 ${widget.room?.minCheckDay}일', style: context.textTheme.krBody3.copyWith(color: black3)),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ),
        const TitleText(title: "숙소 정보"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Column(
                children: [
                  const SvgImage('assets/icons/ic_bed.svg'),
                  const SizedBox(height: 8),
                  Text('침대', style: context.textTheme.krBody3),
                  const SizedBox(height: 8),
                  Text('${(widget.room?.doubleBed ?? 0) + (widget.room?.queenBed ?? 0) + (widget.room?.kingBed ?? 0) + (widget.room?.singleBed ?? 0) + (widget.room?.superSingleBed ?? 0)}개',
                      style: context.textTheme.krBody4),
                ],
              ),
              Container(margin: const EdgeInsets.symmetric(vertical: 4), height: 32, child: const VerticalDivider(width: 80, thickness: 1, color: black6)),
              Column(
                children: [
                  const SvgImage('assets/icons/ic_shower.svg'),
                  const SizedBox(height: 8),
                  Text('욕실', style: context.textTheme.krBody3),
                  const SizedBox(height: 8),
                  Text('${widget.room?.bathroomCount}개', style: context.textTheme.krBody4),
                ],
              ),
              Container(margin: const EdgeInsets.symmetric(vertical: 4), height: 32, child: const VerticalDivider(width: 80, thickness: 1, color: black6)),
              Column(
                children: [
                  const SvgImage('assets/icons/ic_stair.svg'),
                  const SizedBox(height: 8),
                  Text('층수', style: context.textTheme.krBody3),
                  const SizedBox(height: 8),
                  Text('${widget.room?.floor}층', style: context.textTheme.krBody4),
                ],
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        const TitleText(title: "숙소 설명"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: LayoutBuilder(builder: (context, size) {
            var span = TextSpan(
              text: '${widget.room?.description}',
              style: context.textTheme.krBody3,
            );
            var exceeded = hasTextOverflow(span.text ?? '', context.textTheme.krBody3, maxWidth: size.maxWidth, maxLines: showMoreText ? null : 10);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Column(children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Text.rich(
                      span,
                      overflow: TextOverflow.clip,
                      maxLines: showMoreText ? null : 10,
                    ),
                    if (exceeded)
                      Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.8),
                                Colors.white.withOpacity(0.95),
                              ],
                            ),
                          ),
                          height: 48),
                  ],
                ),
                if (exceeded)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: LargeButton(
                      margin: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          showMoreText = true;
                        });
                      },
                      color: white,
                      centerWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '더보기',
                            style: context.textTheme.krButton1,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                  )
              ]),
            );
          }),
        ),
        const SizedBox(height: 16),
        const TitleText(title: "숙소 편의시설"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: showMoreIcon
                        ? null
                        : (widget.room?.facility.length ?? 0) > 10
                            ? 280
                            : null,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      childAspectRatio: 4,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: widget.room!.facility.map((element) {
                        return SizedBox(
                          height: 24,
                          child: Row(children: [
                            //todo 이미지
                            const SizedBox(width: 8),
                            Text(
                              '${element.name}',
                              style: context.textTheme.krBody3,
                            )
                          ]),
                        );
                      }).toList(),
                    ),
                  ),
                  if ((widget.room?.facility.length ?? 0) > 10 && !showMoreIcon)
                    Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0.95),
                            ],
                          ),
                        ),
                        height: 48),
                ],
              ),
              if ((widget.room?.facility.length ?? 0) > 10 && !showMoreIcon)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: LargeButton(
                    margin: EdgeInsets.zero,
                    onTap: () {
                      setState(() {
                        showMoreIcon = true;
                      });
                    },
                    color: white,
                    centerWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '더보기',
                          style: context.textTheme.krButton1,
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
        const SizedBox(height: 16),
        const TitleText(title: "숙소 입/퇴실"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 108, child: Text('체크인', style: context.textTheme.krBody3)),
                  Text('${timeAParser(widget.room?.checkIn)} 이후', style: context.textTheme.krBody3),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  SizedBox(width: 108, child: Text('체크 아웃', style: context.textTheme.krBody3)),
                  Text('${timeAParser(widget.room?.checkOut)} 이전', style: context.textTheme.krBody3),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 108, child: Text('예약 취소', style: context.textTheme.krBody3)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('10일 전까지 ${widget.room?.refundRuleTen == 0 ? '환불 불가' : '${widget.room?.refundRuleTen}% 환불'}', style: context.textTheme.krBody3),
                      Text('7일 전까지 ${widget.room?.refundRuleSeven == 0 ? '환불 불가' : '${widget.room?.refundRuleSeven}% 환불'}', style: context.textTheme.krBody3),
                      Text('5일 전까지 ${widget.room?.refundRuleFive == 0 ? '환불 불가' : '${widget.room?.refundRuleFive}% 환불'}', style: context.textTheme.krBody3),
                      Text('3일 전 ${widget.room?.refundRuleThree == 0 ? '환불 불가' : '${widget.room?.refundRuleThree}% 환불'}', style: context.textTheme.krBody3),
                      Text('1일 전 ${widget.room?.refundRuleOne == 0 ? '환불 불가' : '${widget.room?.refundRuleOne}% 환불'}', style: context.textTheme.krBody3),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool hasTextOverflow(String text, TextStyle style, {double minWidth = 0, double maxWidth = double.infinity, int? maxLines}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}
