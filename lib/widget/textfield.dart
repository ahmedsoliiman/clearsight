import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First name'),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 150,
                    height: 49, // تعيين عرض محدد
                    child: buildTextField(" "),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last name'),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 150,
                    height: 49, // تعيين عرض محدد
                    child: buildTextField(" "),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email'),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 150,
                    height: 49, // تعيين عرض محدد
                    child: buildTextField(" "),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('phone number'),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 150,
                    height: 49, // تعيين عرض محدد
                    child: buildTextField(" "),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    'password',
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                height: 49,
                child: buildPasswordField("", isPasswordVisible, () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                }),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    'confirm password',
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                height: 49,
                child: buildPasswordField(" ", isConfirmPasswordVisible, () {
                  setState(() {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
                fontSize: 20,
                color: Color(0xff6F6F6F),
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xffBFBFBF)),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(
      String label, bool isVisible, VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: toggleVisibility,
          ),
          labelStyle: TextStyle(
              fontSize: 20,
              color: Color(0xff6F6F6F),
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xffBFBFBF)),
          ),
        ),
      ),
    );
  }
}
