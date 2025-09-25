import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jeju_host_app/core/core.dart';

class OutPageFirst extends StatelessWidget {
  const OutPageFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backButton: true,
      ),
      body: SafeArea(
        top: false,
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 141),
                Text('탈퇴를 진행하시려구요?',
                    style: context.textTheme.krPoint1.copyWith(color: black),
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                Text('회원탈퇴할경우 이전의 모든 예약 내역과\n제주살이의 멋진 숙소들을\n더 이상 예약할 수 없습니다.',
                    style: context.textTheme.krBody3.copyWith(color: black2),
                    textAlign: TextAlign.center),
              ]))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: LargeButton(
              text: '탈퇴하기',
              onTap: () {
                context.push('/setting/out/2');

              },
            ),
          )
        ]),
      ),
    );
  }
}

class OutPageSecond extends StatelessWidget {
  const OutPageSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backButton: true,
      ),
      body: SafeArea(
        top: false,
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 141),
                        Text('탈퇴하시는 이유를 알려주세요.',
                            style: context.textTheme.krPoint1.copyWith(color: black),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 32),
                        DropdownMenuWidget<String>(
                          filled: false,
                          hint: '탈퇴사유를 선택해주세요.',
                          dropdownList: const [
                            '앱이 너무 복잡함',
                            '호스트가 집주인일 경우(부동산 명의자)',
                          ],
                          onChanged: (value) {
                            // context.read<AddRoomBloc>().add(CheckOwner(owner: value));
                          },
                        ),
                      ]))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: LargeButton(
              text: '탈퇴하기',
              onTap: () {


              },
            ),
          )
        ]),
      ),
    );
  }
}
