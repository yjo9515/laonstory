import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../common/style.dart';
import '../../common/widget/custom_app_bar.dart';
import '../../global/bloc/global_bloc.dart';
import '../widgets/binding.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff4C8DEF),
            foregroundColor: white,
            iconTheme: const IconThemeData(color: white),
            title: const Text('회원정보'),
            actions: const [
              // IconButton(
              //   onPressed: () {
              //     showGeneralDialog(
              //       context: context,
              //       pageBuilder: (
              //         BuildContext context,
              //         Animation<double> animation,
              //         Animation<double> secondaryAnimation,
              //       ) {
              //         return Scaffold(
              //           backgroundColor: Colors.black.withOpacity(0.85),
              //           appBar: CustomAppBar(
              //             textTitle: '조합원 인증 QR코드',
              //             actions: [
              //               IconButton(
              //                   onPressed: () {
              //                     Navigator.of(context).pop();
              //                   },
              //                   icon: const Icon(Icons.close)),
              //               const SizedBox(width: 4)
              //             ],
              //           ),
              //           body: InkWell(
              //             splashFactory: NoSplash.splashFactory,
              //             onTap: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: Center(
              //               child: Hero(
              //                 tag: 'QRCode',
              //                 child: QrImageView(
              //                   data: state.profileModel?.data?.serialNumber ?? "",
              //                   backgroundColor: Colors.white,
              //                   version: QrVersions.auto,
              //                   size: MediaQuery.of(context).size.width * 0.7,
              //                   gapless: false,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   icon: SvgPicture.asset('assets/icons/ic_qr.svg'),
              // )
            ],
          ),
          backgroundColor: const Color(0xff4C8DEF),
          body: PageView(
            controller: pageController,
            children: [
              ProfileWidget(
                onClick: () => pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
              ),
              // BookTitleWidget(),
              // InfoWidget(),
              // TableWidget(),
              // PointWidget(),
              const MembershipWidget(),
            ],
          ),
        );
      },
    );
  }
}
