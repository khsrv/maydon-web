
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final String text;
  final String image;
  const OnboardingWidget({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32, left: 32),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontFamily: "Graduate",
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
