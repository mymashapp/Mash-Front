import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';

Widget countryCodePicker(
    {Function(CountryCode? v)? onChange, Function(CountryCode? v)? onInit}) {
  return SizedBox(
    width: 90,
    child: CountryCodePicker(
      padding: EdgeInsets.all(0),
      textStyle:
          GoogleFonts.sourceSansPro(color: AppColors.kOrange, fontSize: 16),
      initialSelection: 'US',
      enabled: false,
      showFlag: true,
      alignLeft: true,
      showFlagDialog: true,
      showFlagMain: true,
      onInit: onInit,
    ),
  );
}
