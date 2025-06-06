import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskyapp/component/custom_ElevatedButton.dart';
import 'package:taskyapp/component/custom_textfiled.dart';
import 'package:taskyapp/screens/home_page.dart';

class WelcomePage extends StatelessWidget {

 WelcomePage({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();



  TextEditingController usernameController = TextEditingController(); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                 SizedBox(height: 16),
                 
                  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    SvgPicture.asset("assets/images/logo.svg", height: 42, width: 42), 
                     SizedBox(width: 16),
                      Text(
                        'Tasky',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
              
                  const SizedBox(height: 118),
              
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky',
                         style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SvgPicture.asset('assets/images/waving_hand.svg'),
                    ],
                  ),
              
                  const SizedBox(height: 10),
              
                 Text(
                  'Your productivity journey starts here.',
                   style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
              
                  const SizedBox(height: 29),

                 SvgPicture.asset('assets/images/welcome.svg', width: 215, height: 200),
              
                  CustomTextFiled(
                    controller:usernameController,
                    textData: 'Full Name',
                    hintTextData: "e.g Sarah Khalid",
                    size: 15,
                    textcolor: 0xFFFFFCFC,
                    hintcolor: 0xFF6D6D6D,
                    validator:(String? value)
                    {
                      if(value == null || value.isEmpty)
                      {
                          return "Please Enter Your Name";
                      }
                      else
                      {
                        return null;
                      }
                    }
                  ),

               SizedBox(height: 24),

               CustomElevatedbutton(
                textData: 'Let’s Get Started',
                onPressFunc: ()
                async {
                  if(_key.currentState?.validate()??false)
                  {
                      final SharedPreferences prefs =
                         await SharedPreferences.getInstance();    

                     prefs.setString("username",usernameController.text);         

                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomePage();
                            },
                          ),
                        );
                  }   
                },
              
               ),
            
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
