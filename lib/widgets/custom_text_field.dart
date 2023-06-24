import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class CustomTextFieldWidget extends StatefulWidget {
  String label;
  Color? color;
  bool isPassword;
  String? errorText;
  TextInputType? keyboardType;
  TextEditingController controller;
  Function? onChanged;

  CustomTextFieldWidget({
    Key? key,
    required this.label,
    this.color,
    this.isPassword = false,
    this.errorText,
    this.keyboardType,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(fontSize: 24, color: AppColors.PRIMARY),
      textAlign: TextAlign.center,
      obscureText: widget.isPassword && !_passwordIsVisible,
      obscuringCharacter: '▒',
      keyboardType: widget.keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.label,
        filled: true,
        labelStyle: TextStyle(fontSize: 24, color: widget.color ?? AppColors.PRIMARY.withOpacity(.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            color: widget.color ?? AppColors.PURPLE,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            color: widget.color ?? AppColors.PURPLE.withOpacity(.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            width: 2,
            color: widget.color ?? AppColors.PURPLE,
          ),
        ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(() {
                  _passwordIsVisible = !_passwordIsVisible;
                }),
                child: Text(
                  _passwordIsVisible ? '🙉' : '🙈',
                  style: TextStyle(fontSize: 32),
                ),
              )
            : null,
        errorText: widget.errorText,
      ),
      onChanged: (value) => widget.onChanged != null ? widget.onChanged!() : {},
    );
  }
}
