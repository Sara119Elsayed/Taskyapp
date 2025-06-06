import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskyapp/component/custom_textfiled.dart';
import 'package:taskyapp/screens/addtask_page.dart';


class HomePage extends StatefulWidget {
  
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();

}

class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 52,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Good Evening ,Sara', 
                 style: Theme.of(context).textTheme.titleMedium,
                 )
            ],
          ),

          SizedBox(
            height:10 ,
          ),

        Text(
        'One task at a time.One step closer.', 
        style: Theme.of(context).textTheme.titleSmall,

          ),

        SizedBox(
            height:20 ,
          ),

          Text('Yuhuu ,Your work Is', style: Theme.of(context).textTheme.displayLarge),
            Row(
              children: [
                Text('almost done ! ', style: Theme.of(context).textTheme.displayLarge),
                SvgPicture.asset('assets/images/handimage.svg'),
              ],
            ),

        SizedBox(
            height:29 ,
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        height: 44,
        child: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () async {
                final bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AddTaskPage();
                    },
                  ),
                );
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            );
          },
        ),
      ),
    
      
      
    );
  }
}