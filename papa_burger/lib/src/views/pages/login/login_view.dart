import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return _buildPage(context);
      },
    );
  }

  _buildPage(BuildContext context) => GestureDetector(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: ListView(
            children: [
              Column(
                children: [
                  const LoginImage(),
                  const LoginForm(),
                  SizedBox(
                    height: AppDimen.h6,
                  ),
                  const KText(
                    text: 'Or sign in',
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: AppDimen.h6,
                  ),
                  LoginWithGoogleAndFacebook(
                    height: AppDimen.h60,
                  ),
                  SizedBox(
                    height: AppDimen.h12,
                  ),
                  const LoginFooter(),
                ],
              ),
            ],
          ),
        ),
        onTap: () => _releaseFocus(context),
      );

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
