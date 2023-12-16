import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainScreens.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import '../../components/background.dart';
import '../MainScreens.dart';
// import 'components/sign_up_top_image.dart';
// import 'components/signup_form.dart';

class Main_screen extends StatelessWidget {
  
  final String? nama;
  final String? iduser;
  const Main_screen({Key? key, this.nama,this.iduser
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileMainScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: MainScreens(),
              ),
              
                  ],
                ),
              )
            
          )
          );
        
     
  }
}

class MobileMainScreen extends StatelessWidget {
  const MobileMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MainScreens(),
       
            Spacer(),
          ],
        );
        // const SocalSignUp()
     
  }
}
