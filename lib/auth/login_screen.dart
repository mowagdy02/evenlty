import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/auth/CustomButton/customButton.dart';
import 'package:evently/auth/CustomTextField/customTextField.dart';
import 'package:evently/providers/language.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/routes.dart';
import 'package:evently/utils/styles.dart';
import 'package:evently/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/models/user.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04 * width , vertical: 0.08 * height),
        child: Form(
          key: formKey,
          child: Column(
            spacing: height * 0.02,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Theme.of(context).brightness == Brightness.light ?
              Image.asset("assets/images/Evently.png") :
              Image.asset("assets/images/Evently_dark.png"),
              Text("login_to_your_account".tr(),style: Theme.of(context).textTheme.headlineLarge,),
              CustomTextField(filled: Theme.of(context).brightness == Brightness.light ? true : false,
                fillColor: AppColors.inputLight,
                borderColor:  Theme.of(context).brightness == Brightness.dark ? AppColors.strokeDark : AppColors.strokeLight,
                prefixIcon: Icon(Icons.email_outlined,color: AppColors.disableLight,),
                hintText: "enter_your_email".tr(),
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                controller: emailController,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return "Please Enter Email";
                  }
                  final bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if(!emailValid){
                    return "Please Enter Valid email";
                  }
                  return null;
                },
              ),
              CustomTextField(filled: Theme.of(context).brightness == Brightness.light ? true : false,
                  fillColor: AppColors.inputLight,
                  borderColor:  Theme.of(context).brightness == Brightness.dark ? AppColors.strokeDark : AppColors.strokeLight,
                  prefixIcon: Icon(Icons.lock,color: AppColors.disableLight,),
                  hintText: "enter_your_password".tr(),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                controller: passController,
                obscureText: isVisible ? false : true,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return "Please Enter Password";
                  }
                  if(text.length < 6 ){
                    return "Password should at least 6 characters";
                  }
                  return null;
                },
                suffixIcon: IconButton(onPressed: () {
                  if (isVisible == false){
                    isVisible = true;
                  }
                  else{
                    isVisible = false ;
                  }
                  setState(() {

                  });
                }, icon: isVisible ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {
                    //todo navigate to forget password
                  }, child: Text("forget_password".tr(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor:  Theme.of(context).brightness == Brightness.light ?
                    AppColors.primaryLight :
                    AppColors.primaryDark
                  ),
                  )),
                ],
              ),
              CustomButton(title: "login".tr(),onTap: login,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("dont_have_account_q".tr(),style: Theme.of(context).textTheme.bodyMedium,),
                  TextButton(onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signup);
                  }, child: Text("signup".tr(),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor:  Theme.of(context).brightness == Brightness.light ?
                        AppColors.primaryLight :
                        AppColors.primaryDark
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    height: 2,
                    color: Theme.of(context).brightness == Brightness.light ?
                    AppColors.strokeLight:
                      AppColors.strokeDark
                  )),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Text("or".tr(),style: Theme.of(context).textTheme.displayLarge,),
                  ),
                  Expanded(child: Container(
                      height: 2,
                      color: Theme.of(context).brightness == Brightness.light ?
                      AppColors.strokeLight:
                      AppColors.strokeDark
                  )),
                ],
              ),
              Container(
                height: height * 0.06,
                decoration: BoxDecoration(
                  color:  Theme.of(context).brightness == Brightness.light ?
                  AppColors.inputLight :AppColors.inputDark,
                  border: BoxBorder.all(
                    color: Theme.of(context).brightness == Brightness.light ?
                    AppColors.strokeLight:AppColors.strokeDark,
                  ),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/google.png",width: width * 0.06,),
                    Text("login_with_google".tr(),style:Theme.of(context).textTheme.headlineSmall ,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> login() async {
    if(formKey.currentState!.validate() == true){
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text
        );
        print(credential.user?.uid??"");
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??"");
        if(user == null){
          return;
        }
        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        Navigator.pushReplacementNamed(context, AppRoutes.homescreen);
      } on FirebaseAuthException catch (e) {
       print(e);
      }
    }
  }
}
