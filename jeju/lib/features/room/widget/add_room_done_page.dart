part of '../ui/add_room_page.dart';

class AddRoomDonePage extends StatefulWidget {
  const AddRoomDonePage({Key? key,
    required this.bloc
  }) : super(key: key);

  final AddRoomBloc bloc;

  @override
  State<AddRoomDonePage> createState() => _AddRoomDonePageState();
}

class _AddRoomDonePageState extends State<AddRoomDonePage> {
  late final ConfettiController _controllerCenter;
  late final StreamSubscription<int>? _tickerSubscription;
  int second = 3;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
    HapticFeedback.mediumImpact();
    _tickerSubscription = Ticker.to.timer(time: 3).timeout(const Duration(seconds: 5), onTimeout: (_) {
      context.goNamed('main', queryParameters: {'index': '2'});
      /// todo 상세페이지 라우팅
    }).listen((event) {
      if (event <= 0) {
        context.goNamed('main', queryParameters: {'index': '2'});

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
              ConfettiWidget(
                numberOfParticles: 20,
                emissionFrequency: 0.015,
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 12,
                minBlastForce: 7,
                gravity: 0.3,
                shouldLoop: false,
                colors: const [Colors.green, Colors.greenAccent, Colors.blue, Colors.pink, Colors.blueAccent, Colors.pinkAccent, Colors.orange, Colors.purple],
              ),
              Image.asset('assets/images/popper.webp', width: 40),
              const SizedBox(height: 32),
              Text('축하합니다!', style: context.textTheme.krPoint1.copyWith(color: white)),
              Text('숙소등록을 완료했습니다!', style: context.textTheme.krPoint1.copyWith(color: white)),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), alignment: Alignment.centerRight, child: Text('$second초뒤 상세페이지로', style: context.textTheme.krBody5.copyWith(color: white))),
            ],
          ),
        ),
      ),
    );
  }
}
