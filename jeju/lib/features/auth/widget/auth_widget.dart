import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
/* 아임포트 휴대폰 본인인증 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_certification.dart';
/* 아임포트 휴대폰 본인인증 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:jeju_host_app/core/core.dart';
import 'package:jeju_host_app/features/setting/repository/edit_info_repository.dart';
import 'package:jeju_host_app/features/signup/bloc/host_signup_bloc.dart';
import 'package:jeju_host_app/features/signup/repository/host_signup_repository.dart';

import '../../../core/config/logger.dart';
import '../../../core/domain/api/api_url.dart';

class AuthWidget extends StatefulWidget {
  String? path;
  AuthWidget({super.key, this.path});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(create: (context) => HostSignUpBloc()
    //     child: BlocConsumer<HostSignUpBloc, Host>,
    // )
    return IamportCertification(
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp73842754',
      /* [필수입력] 본인인증 데이터 */
      data:
      // widget.path == 'edit'?
      // CertificationData(
      //   pg: 'MIIiasTest',                                         // PG사
      //   merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',  // 주문번호
      //   mRedirectUrl: '$authUrl/certifications/confirm',
      //   phone: '01032022635',
      //     name: '윤준오'
      // ):
      CertificationData(
        pg: 'MIIiasTest',                                         // PG사
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',  // 주문번호
        mRedirectUrl: '$authUrl/certifications/confirm',
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        print(widget.path);
        if(widget.path == 'edit'){
          try{
            EditInfoRepository.to.authConfirm(result['imp_uid']).then((value) => context.pop(true));
          } on ExceptionModel catch (e){
            logger.d(e);
            context.pop(e.message);
          }

        }else{
          logger.d(result['imp_uid']);
          HostSignUpRepository.to.authHost(result['imp_uid']).then((value) => context.pushReplacement('/signup/host/done'));

        }
      },
    );

  }
}
