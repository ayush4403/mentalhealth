import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

TextField reusableTextField(
    String text,
    IconData icon,
    TextEditingController controller,
    TextInputType keyboardType,
    VoidCallback togglePasswordVisibility,
    ) {
  bool obscureText = keyboardType == TextInputType.visiblePassword;

  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    enableSuggestions: !obscureText,
    autocorrect: !obscureText,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      suffixIcon: obscureText
          ? IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
        ),
        onPressed: () {
          // Toggle the password visibility
          togglePasswordVisibility();
        },
      )
          : null,
      labelText: text,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
  );
}





Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin:  EdgeInsets.fromLTRB(70, MediaQuery.of(context).size.width*0.05, 70, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return const Color.fromARGB(255, 58, 143,131);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}