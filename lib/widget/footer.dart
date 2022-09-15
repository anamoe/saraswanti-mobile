import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:saraswantiland/widget/maicolors.dart';

class FooterKu extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10,bottom: 15,left: 10,right: 10),
      margin: EdgeInsets.only(top :10),
      child: Column(
        children: [
           GestureDetector(
                          onTap: () {
                            bukabrowser("https://saraswantiproperty.com/law/privacy-policy.html");
                          },
            //               child : Text("Privacy Policy",style: GoogleFonts.lato(
            //   textStyle: Theme.of(context).textTheme.headline4,
            //   fontSize: 12,
            //   color: Colors.black,
            //   fontWeight: FontWeight.w700,
            // ),),

             child :Image.asset(
               'assets/icon/privacy policy.png',
               width: 350,
             ),
          ),


          //
          // Text("Developed and Managed by PT. Saraswanti Indoland Development.",style: GoogleFonts.lato(
          //     textStyle: Theme.of(context).textTheme.headline4,
          //     fontSize: 12,
          //     color: Colors.black,
          //   ),),
          //
          // Text("All contents on this app are illustrative only, so changes can occur and not part of the sales offer.",style: GoogleFonts.lato(
          //     textStyle: Theme.of(context).textTheme.headline4,
          //     fontSize: 12,
          //     color: Colors.black,
          //   ),
          //   textAlign: TextAlign.center,
          //   ),
        ],
      ),
    )
      ],
    );
  }


    void bukabrowser(String link) async {
      String url() {
        return link;
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

}
