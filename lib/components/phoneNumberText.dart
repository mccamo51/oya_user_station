import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:oya_porter/components/textField.dart';
import 'package:oya_porter/spec/colors.dart';

String countryCode = "233", countryName = "GH";
// Widget phoneText(
//     {PhoneNumber number,
//     TextEditingController controller,
//     String hintText,
//     String locale}) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 5),
//     decoration: BoxDecoration(
//         color: SECONDARYCOLOR, borderRadius: BorderRadius.circular(6)),
//     child: InternationalPhoneNumberInput(
//       onInputChanged: (PhoneNumber number) {
//         print(number.dialCode);
//         countryCode = number.dialCode;
//       },
//       onInputValidated: (bool value) {
//         // print(value);
//       },
//       selectorConfig: SelectorConfig(
//           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//           countryComparator: ((cv, i) {
//             // print(cv.alpha2Code);
//             return 0;
//           })),
//       ignoreBlank: false,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       selectorTextStyle: TextStyle(color: Colors.black),
//       hintText: hintText,
//       locale: "GH",
//       initialValue: number,
//       textFieldController: controller,
//       formatInput: false,
//       countries: ["GH", "TG", "NG", "AU", "CI", "BF"],
//       keyboardType:
//           TextInputType.numberWithOptions(signed: true, decimal: true),
//       inputBorder: InputBorder.none,
//       onSaved: (PhoneNumber number) {
//         print('On Saved: ${number.phoneNumber}');
//       },
//       onSubmit: () {
//         print('On Saved: $number');
//       },
//     ),
//   );
// }

Widget _buildDropdownItem(Country country) => Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}"),
        ],
      ),
    );

Widget newCountrySelect(
    {PhoneNumber number,
    TextEditingController controller,
    String hintText,
    String locale}) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: SECONDARYCOLOR, borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Expanded(
            child: CountryPickerDropdown(
              initialValue: countryName,
              itemBuilder: _buildDropdownItem,
              itemFilter: (c) =>
                  ["GH", "TG", "NG", "AU", "CI", "BF"].contains(c.isoCode),
              // priorityList: [
              //   CountryPickerUtils.getCountryByIsoCode('GH'),
              //   CountryPickerUtils.getCountryByIsoCode('CN'),
              // ],
              sortComparator: (Country a, Country b) =>
                  a.isoCode.compareTo(b.isoCode),
              onValuePicked: (Country country) {
                countryCode = ("${country.phoneCode}");
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: textFormField(
                hintText: hintText,
                controller: controller,
                focusNode: null,
                inputType: TextInputType.phone,
              ),
            ),
          )
        ],
      ));
}
