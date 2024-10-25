import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defualtButton({
   double width = double.infinity ,
   Color background= Colors.blue ,
  required Function()? function ,
  required String text ,
}) => Container(
  width: width,
  height: 40.0,
  color: background,
  child: MaterialButton(
    onPressed:function ,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),


  ),
);

Widget defualtFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  required String? Function(String?)? validate ,
  required String label ,
  required IconData prefix ,
  bool isPassword = false ,
  IconData? suffix ,
  Function()? suffixPressed ,
  Function()? onTap ,
  Function(String)? onSubmit ,
  Function(String)? onChange ,
  bool isClickable = true ,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  enabled:isClickable ,
  obscureText: isPassword,
  onTap: onTap,
  onFieldSubmitted: onSubmit,
  onChanged: onChange ,
  decoration: InputDecoration(
    labelText: label,
    suffixIcon: suffix != null ? IconButton(
      onPressed:suffixPressed ,
      icon: Icon(
        suffix ,
      ),
    ) : null,
    border: const OutlineInputBorder() ,
    prefixIcon: Icon(
      prefix ,
    ),
  ),
  validator: validate ,
);





void navigateTo(context , Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context) => Widget ,
  ),
);

void navigateAndFinish(context , Widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context) => Widget ,
  ),
    (route){
    return false;
    }
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_left_sharp
    ),
  ),
  titleSpacing: 1.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

void showToast({
  required String text,
  required ToastStates state,

})=>Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
    }
    return color;
  }



