import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
          "WELCOME TO VIGENESIA".toUpperCase(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.purple
            ),
           ),
        // const SizedBox(height: defaultPadding * 2),
        const Text(
          "Nama Kelompok :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Text(
          "Mohammad Elvian (19210972) ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),const Text(
          "Asep Nur Rohman ()",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),const Text(
          "Samuldi ()",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),const Text(
          "Pretty LB Situmeang ()",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),

        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 1),
      ],
    );
  }
}