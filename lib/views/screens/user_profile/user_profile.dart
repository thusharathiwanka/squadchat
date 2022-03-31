import 'package:flutter/material.dart';
import 'package:squadchat/colors.dart';
import 'package:squadchat/theme.dart';
import 'package:squadchat/views/widgets/login/logo.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: primary,
                      size: 30,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'assets/images/logo.png',
                            scale: 5,
                          ),
                        ),
                        Text(
                          "Squadchat",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isLightTheme(context)
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.logout_rounded,
                      color: primary,
                      size: 30,
                    ),
                  ]),
            ),
            const Spacer(),
            SizedBox(
              height: 126,
              width: 126,
              child: Material(
                color:
                    isLightTheme(context) ? Colors.grey[200] : Colors.grey[900],
                borderRadius: BorderRadius.circular(126),
                child: InkWell(
                  borderRadius: BorderRadius.circular(126),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(126),
                              child: Image.network(
                                  'http://10.0.2.2:3000/public/uploads/images/profile/scaled_image_picker887393490857838263.jpg',
                                  width: 126,
                                  height: 126,
                                  fit: BoxFit.cover))),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {},
                child: const Icon(Icons.delete_forever),
                style: ElevatedButton.styleFrom(
                    primary: primary,
                    fixedSize: const Size(60, 60),
                    shape: const CircleBorder(),
                    elevation: 0),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Logo(),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          'Squadchat',
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
