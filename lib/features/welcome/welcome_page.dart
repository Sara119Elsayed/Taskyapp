import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskyapp/component/custom_ElevatedButton.dart';
import 'package:taskyapp/component/custom_textfiled.dart';
import 'package:taskyapp/core/constants/storage_key.dart';
import 'package:taskyapp/features/home/home_page.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

class WelcomePage extends StatelessWidget {

 WelcomePage({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

 final TextEditingController usernameController = TextEditingController(); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
             left: 16,
            right: 16,
            ),
            child: Form(
              key: _key,
              child: Column(
                children: [
                 SizedBox(height: 52),
                 
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
                         style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SvgPicture.asset('assets/images/handimage.svg'),
                    ],
                  ),
              
                  const SizedBox(height: 10),
              
                 Text(
                  'Your productivity journey starts here.',
                   style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
              
                  const SizedBox(height: 30),
                        
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
                       
                        
                    await PrefrencesetManagerService().setString(StorageKey.username,usernameController.value.text);         
                        
                     Navigator.pushReplacement(
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
