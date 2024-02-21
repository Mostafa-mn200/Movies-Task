
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../AppRouter.dart';
import '../../../../conustant/di.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/shared_preference_serv.dart';
import '../../../../conustant/toast_class.dart';
import '../../../../main.dart';
import '../../../business/changeLanguageController/ChangeLanguageController.dart';

class ChangeLanguageScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _changeLanguageScreen();
  }
}

class _changeLanguageScreen extends State<ChangeLanguageScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ));
  var isSelected=false;
  int? itemId=0;
  final changeLanguageController = Get.put(ChangeLanguageController());

  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(start: 10,end: 10),
              child: Text('choose_the_language'.tr(),
                style: TextStyle(fontSize: 18.sp,
                    fontFamily: 'lexend_extraBold',
                    fontWeight: FontWeight.w800,
                    color: Colors.black45),),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                setState(() {
                  isSelected=true;
                  itemId=1;
                  changeLanguageController.lang='en';
                  sharedPreferencesService.setString("lang", changeLanguageController.lang);
                  translator.setNewLanguage(
                    context,
                    newLanguage: changeLanguageController.lang,
                    remember: true,
                  );
                  Phoenix.rebirth(context);

                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 7.h,
                margin: const EdgeInsetsDirectional.only(start: 10,end: 10),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Image(image: AssetImage('assets/en.png')),
                    SizedBox(width: 2.w,),
                    Text('english'.tr(),
                      style:  TextStyle(fontSize: 14.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),),
                    const Spacer(),
                    isSelected==true && itemId==1?SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/unChecked.svg'),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsetsDirectional.only(start: 10,end: 10),
                child: SvgPicture.asset('assets/separator.svg')),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                setState(() {
                  isSelected=true;
                  itemId=2;
                  changeLanguageController.lang='ar';
                  sharedPreferencesService.setString("lang", changeLanguageController.lang);
                  translator.setNewLanguage(
                    context,
                    newLanguage: changeLanguageController.lang,
                    remember: true,
                  );
                  Phoenix.rebirth(context);
                });

              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 7.h,
                margin: const EdgeInsetsDirectional.only(start: 10,end: 10),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Image(image: AssetImage('assets/ar.png')),
                    SizedBox(width: 2.w,),
                    Text('arabic'.tr(),
                      style: TextStyle(fontSize: 14.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,)),
                    const Spacer(),
                    isSelected==true && itemId==2?SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/unChecked.svg'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h,),
            Container(
              margin: EdgeInsets.only(left: 3.h, right: 3.h),
              width: double.infinity,
              height: 8.h,
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () async{
                  if(isSelected!=false){
                    Navigator.pushNamedAndRemoveUntil(context,'/buttom_navagation_page',
                        ModalRoute.withName('/buttom_navagation_page'),arguments: 0);
                  }else{
                    ToastClass.showCustomToast(context, 'please_choose_lang'.tr(), 'error');
                  }
                },
                child: Text('keep_going2'.tr(),
                  style: TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

}
