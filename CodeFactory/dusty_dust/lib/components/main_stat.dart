import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: Colors.white, fontSize: 40.0);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text("서울", style: ts.copyWith(fontWeight: FontWeight.w700)),
            Text(
              "2026-3-01 11:00",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'asset/img/good.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            Text(
              "보통",
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "나쁘지 않네요!",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
