import 'package:easy_localization/easy_localization.dart';
import 'package:evently/auth/CustomButton/customButton.dart';
import 'package:evently/auth/CustomTextField/customTextField.dart';
import 'package:evently/providers/user.dart';
import 'package:evently/utils/colors.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:evently/models/user.dart';
import 'package:provider/provider.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
bool isVisible = false;
bool isVisible2 = false;
var formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController rePassController = TextEditingController();

class _SignupState extends State<Signup> {
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
              Text("create_your_account".tr(),style: Theme.of(context).textTheme.headlineLarge,),
              CustomTextField(filled: Theme.of(context).brightness == Brightness.light ? true : false,
                  fillColor: AppColors.inputLight,
                  borderColor:  Theme.of(context).brightness == Brightness.dark ? AppColors.strokeDark : AppColors.strokeLight,
                  prefixIcon: Icon(Icons.person_outline_outlined,color: AppColors.disableLight,),
                  hintText: "enter_your_name".tr(),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                controller: nameController,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return "Please Enter your name";
                  }
                  return null;
                },
              ),
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
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return "Please Enter Password";
                  }
                  if(text.length < 6 ){
                    return "Password should at least 6 characters";
                  }
                  return null;
                },
                obscureText: isVisible ? false : true,
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
              CustomTextField(filled: Theme.of(context).brightness == Brightness.light ? true : false,
                fillColor: AppColors.inputLight,
                borderColor:  Theme.of(context).brightness == Brightness.dark ? AppColors.strokeDark : AppColors.strokeLight,
                prefixIcon: Icon(Icons.lock,color: AppColors.disableLight,),
                hintText: "confirm_your_password".tr(),
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                obscureText: isVisible2 ? false : true,
                controller: rePassController,
                validator: (text) {
                  if(text == null || text.trim().isEmpty){
                    return "Please Enter Password";
                  }
                  if(text != passController.text){
                    return "Repassword doesn't match the password";
                  }
                  return null;
                },
                suffixIcon: IconButton(onPressed: () {
                  if (isVisible2 == false){
                    isVisible2 = true;
                  }
                  else{
                    isVisible2 = false ;
                  }
                  setState(() {

                  });
                }, icon: isVisible2 ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined)),
              ),

              CustomButton(title: "sign_up".tr(),onTap: signup,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("already_have_account_q".tr(),style: Theme.of(context).textTheme.bodyMedium,),
                  TextButton(onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                  }, child: Text("login".tr(),
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
                    color: Theme.of(context).brightness == Brightness.light ?
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
                    Text("signup_with_google".tr(),style:Theme.of(context).textTheme.headlineSmall ,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signup() async {
    if(formKey.currentState!.validate() == true){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        await FirebaseUtils.addUserToFirestore(
          User(
            id: credential.user?.uid??"",
            name: nameController.text,
            email: emailController.text,
          ),
        );


        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser( User(
          id: credential.user?.uid??"",
          name: nameController.text,
          email: emailController.text,
        ),);
        print("id : ${credential.user?.uid ?? ""}");
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }


    }
  }
}
