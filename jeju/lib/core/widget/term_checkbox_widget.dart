import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core.dart';

class TermCheckboxWidget extends StatelessWidget {
  const TermCheckboxWidget({Key? key, required this.termType, required this.onCheck, required this.agree}) : super(key: key);

  final TermType termType;
  final Function(bool) onCheck;
  final bool agree;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: switch (termType) {
        TermType.privacy => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    onCheck(!agree);
                  },
                  icon: SvgImage(agree ? 'assets/icons/ic_checkbox_on.svg' : 'assets/icons/ic_checkbox_off.svg'),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: AutoSizeText.rich(
                  TextSpan(
                    style: context.textTheme.krSubtext1,
                    children: <TextSpan>[
                      TextSpan(
                        text: '개인정보처리방침',
                        style: context.textTheme.krSubtext1.copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                  style: context.textTheme.krSubtext1,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        TermType.service => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    onCheck(!agree);
                  },
                  icon: SvgImage(agree ? 'assets/icons/ic_checkbox_on.svg' : 'assets/icons/ic_checkbox_off.svg'),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: AutoSizeText.rich(
                  TextSpan(
                    style: context.textTheme.krSubtext1,
                    children: <TextSpan>[
                      TextSpan(
                        text: '서비스이용약관',
                        style: context.textTheme.krSubtext1.copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                  style: context.textTheme.krSubtext1,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        TermType.host => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    onCheck(!agree);
                  },
                  icon: SvgImage(agree ? 'assets/icons/ic_checkbox_on.svg' : 'assets/icons/ic_checkbox_off.svg'),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: AutoSizeText.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '호스트 이용약관에 동의합니다.',
                        style: context.textTheme.krBody3,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 16),
              AutoSizeText.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '호스트 등록 약관 안내',
                      style: context.textTheme.krBody1.copyWith(decoration: TextDecoration.underline, color: black4),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
                maxLines: 2,
              ),
            ],
          ),
      },
    );
  }
}
