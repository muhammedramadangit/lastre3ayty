import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Auth/Confim_Code/Confirm_Code.dart';
import 'package:lastre3ayty/User/screens/Auth/SignUp/Bloc/Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/SignUp/Bloc/state.dart';
import 'package:lastre3ayty/common/AnimatedWidget.dart';
import 'package:lastre3ayty/common/CenterLoading.dart';
import 'package:lastre3ayty/common/CustomButton.dart';
import 'package:lastre3ayty/common/CustomRegisterIcon.dart';
import 'package:lastre3ayty/common/CustomTextField.dart';
import 'package:lastre3ayty/common/CustonSnackBar.dart';
import 'package:lastre3ayty/theme/color.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = SignUpCubit.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //============ Logo Position ===========
                      AnimatedWidgets(
                        duration: 1,
                        horizontalOffset: 0,
                        virticaloffset: 50,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/app_logo.png'),
                            ),
                          ),
                        ),
                      ),

                      //============ SignUp Card =============
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: 0,
                        virticaloffset: 100,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Card(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            elevation: 3,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    '?????????? ????????',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Cairo-Bold',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  //=========== ?????? ???????????????? =============
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: false,
                                    label: "?????? ????????????????",
                                    inputType: TextInputType.name,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/username.png"),
                                    validate: (value) {
                                      if(value.isEmpty) {
                                        return "???? ???????? ???????? ?????? ????????????????";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.name = value;
                                    },
                                  ),

                                  //=========== ?????? ???????????? =============
                                  CustomTextField(
                                    horizontalPadding: 10,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: false,
                                    label: "?????? ????????????",
                                    inputType: TextInputType.phone,
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/phone.png"),
                                    suffixIcon: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Divider(),
                                        Text("+966", textDirection: TextDirection.ltr, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),),
                                      ],
                                    ),
                                    validate: (value) {
                                      if(value.isEmpty) {
                                        return "?????????? ???????? ?????? ????????????";
                                      }else if (value.length < 9 || value.length > 9){
                                        return "?????????? ?????? ???????????? 9 ??????????";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.phone = value;
                                    },
                                  ),

                                  //=========== ???????? ???????????? =============
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: true,
                                    label: "???????? ????????????",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (value) {
                                      if(value.isEmpty) {
                                        return "?????????? ???????? ???????? ????????????";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.password = value;
                                    },
                                  ),

                                  //=========== ?????????? ???????? ???????????? =============
                                  CustomTextField(
                                    horizontalPadding: 8,
                                    labelSize: 12,
                                    leftPadding: 5,
                                    rightPadding: 5,
                                    verticalPadding: 0,
                                    secureText: true,
                                    label: "?????????? ???????? ????????????",
                                    prefixIcon: customRegisterIcon(imgSrc: "assets/icons/password.png"),
                                    validate: (value) {
                                      if(value.isEmpty) {
                                        return "???? ???????? ???????? ???????? ????????????";
                                      }else if(value != cubit.password){
                                        return "???????? ???????????? ?????? ??????????????";
                                      }
                                    },
                                    onChanged: (value) {
                                      cubit.confirmpass = value;
                                    },
                                  ),

                                  SizedBox(height: 10),

                                  //=========== ?????????? =============
                                  BlocConsumer<SignUpCubit, SignUpState>(
                                    listener: (_, state){
                                      if(state is SignUpErrorState){
                                        customSnackBar(_, state.error);
                                      }else if(state is SignUpSuccessState){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmCode()));
                                        print("============================= ???? ?????????????? ?????????? =========================");

                                      }
                                    },
                                    builder: (context, state) {
                                      return state is SignUpLoadingState
                                          ? CenterLoading()
                                          : CustomButton(
                                              text: "??????????",
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: 40,
                                              onTap: () {
                                                if (_formKey.currentState.validate()) {
                                                  cubit.SignUp();
                                                }
                                              },
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //=========== ???????? ???????? ?? =============
                      AnimatedWidgets(
                        duration: 1.5,
                        horizontalOffset: 0,
                        virticaloffset: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '???????? ??????????',
                              style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.darkerGreyText,
                              ),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '?????????? ????????????',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Cairo-Bold',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}