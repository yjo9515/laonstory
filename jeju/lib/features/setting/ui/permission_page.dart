// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jeju_host_app/core/core.dart';
// import 'package:jeju_host_app/features/setting/bloc/alert_bloc.dart';
// import 'package:jeju_host_app/features/setting/bloc/alert_event.dart';
// import 'package:jeju_host_app/features/setting/bloc/alert_state.dart';
//
// class PermissionPage extends StatelessWidget {
//   const PermissionPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         textTitle: '권한 설정',
//         backButton: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width:  MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(width: 0.2,color: black5))
//               ),
//               padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('제주살이 권한 안내',style: context.textTheme.krButton1.copyWith(fontSize: 18),),
//                 SizedBox(height: 16,),
//                 Text('제주살이는 아래 권한들을 필요로 합니다.',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
//                 Text('서비스 사용 중 앱에서 요청 시 허용해주세요.',style: context.textTheme.krBody1.copyWith(fontSize: 16),)
//               ],
//             ),
//             ),
//             BlocProvider(
//               create: (context) => PermissionBloc()..add(Initial()),
//               child: BlocConsumer<PermissionBloc, PermissionState>(
//                 listener: (context, state){
//
//                 },
//                 builder: (context, state){
//                   return Column(
//                     children: [
//                       Container(
//                         width:  MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             border: Border(bottom: BorderSide(width: 0.2,color: black5))
//                         ),
//                         padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('필수 접근 권한',style: context.textTheme.krButton1.copyWith(fontSize: 18),),
//                             SizedBox(height: 16,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('전화',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
//                                 Transform.scale(
//                                     scale: 0.75,
//                                     child:CupertinoSwitch(
//                                         thumbColor: state.phone == true ? mainJeJuBlue : gray0,
//                                         activeColor: Colors.white,
//                                         value: state.phone,
//                                         onChanged: (value) async {
//                                             context.read<PermissionBloc>().add(ChangePermission(type: 'phone'));
//                                         }))
//                               ],
//                             ),
//                             SizedBox(height: 16,),
//                             Row(
//                               children:[
//                                 Flexible(
//                                     flex:75,
//                                     child: Text(
//                                       '본인 이용 확인을 위해 제주살이 앱을 사용중인 휴대폰의 전화번호를 조회할 수 있습니다.',style: context.textTheme.krBody1.copyWith(fontSize: 16,color: gray0),)),
//                                 Spacer(flex: 15,)
//                               ] ,)
//
//
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('선택 접근 권한',style: context.textTheme.krButton1.copyWith(fontSize: 18),),
//                             SizedBox(height: 16,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('갤러리',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
//                                 Transform.scale(
//                                     scale: 0.75,
//                                     child:CupertinoSwitch(
//                                         thumbColor: state.gallery == true ? mainJeJuBlue : gray0,
//                                         activeColor: Colors.white,
//                                         value: state.gallery,
//                                         onChanged: (value) async {
//                                           context.read<PermissionBloc>().add(ChangePermission(type: 'gallery'));
//                                         }))
//                               ],
//                             ),
//                             SizedBox(height: 16,),
//                             Row(
//                               children:[
//                                 Flexible(
//                                     flex:75,
//                                     child: Text(
//                                       '리뷰를 작성할 때 사진을 업로드 할 경우, 갤러리에 사진들을 이용하게 됩니다.',style: context.textTheme.krBody1.copyWith(fontSize: 16,color: gray0),)),
//                                 Spacer(flex: 15,)
//                               ] ,),
//                             SizedBox(height: 32,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('푸시 알림',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
//                                 Transform.scale(
//                                     scale: 0.75,
//                                     child:CupertinoSwitch(
//                                         thumbColor: state.push == true ? mainJeJuBlue : gray0,
//                                         activeColor: Colors.white,
//                                         value: state.push,
//                                         onChanged: (value) async {
//                                           context.read<PermissionBloc>().add(ChangePermission(type: 'push'));
//                                         }))
//                               ],
//                             ),
//                             SizedBox(height: 16,),
//                             Row(
//                               children:[
//                                 Flexible(
//                                     flex:75,
//                                     child: Text(
//                                       '앱에서 발송하는 푸시 알림을 받습니다.',style: context.textTheme.krBody1.copyWith(fontSize: 16,color: gray0),)),
//                                 Spacer(flex: 15,)
//                               ] ,),
//                             SizedBox(height: 32,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('카메라',style: context.textTheme.krBody1.copyWith(fontSize: 16),),
//                                 Transform.scale(
//                                     scale: 0.75,
//                                     child:CupertinoSwitch(
//                                         thumbColor: state.camera == true ? mainJeJuBlue : gray0,
//                                         activeColor: Colors.white,
//                                         value: state.camera,
//                                         onChanged: (value) async {
//                                           context.read<PermissionBloc>().add(ChangePermission(type: 'camera'));
//                                         }))
//                               ],
//                             ),
//                             SizedBox(height: 16,),
//                             Row(
//                               children:[
//                                 Flexible(
//                                     flex:75,
//                                     child: Text(
//                                       '카메라에 접근하여 사진을 찍을 수 있습니다.',style: context.textTheme.krBody1.copyWith(fontSize: 16,color: gray0),)),
//                                 Spacer(flex: 15,)
//                               ] ,),
//                             SizedBox(height: 60,),
//                           ],
//                         ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
