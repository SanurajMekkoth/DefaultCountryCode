library country_code_picker;

import 'package:default_country_code/Model/CountryCode.dart';
import 'package:default_country_code/default_country_code.dart';
import 'package:default_country_code/res/Styles.dart';
import 'package:flutter/material.dart';

export '/Model/CountryCode.dart';

class CountryCodePicker extends StatefulWidget {
  const CountryCodePicker({Key? key, this.onSelect}) : super(key: key);
  final Function(CountryCode?)? onSelect;

  @override
  _CountryCodePickerState createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  List<CountryCode>? _countryCodes;
  CountryCode? _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _setCountryCodes();
    _setDefaultCountryCode();
  }

  _onSelect(CountryCode? countryCode) {
    setState(() {
      _selectedCountryCode = countryCode;
    });
    widget.onSelect?.call(_selectedCountryCode);
  }

  _setCountryCodes() async {
    _countryCodes = await DefaultCountryCode.getCountryCodes(context);
  }

  _setDefaultCountryCode() async {
    _selectedCountryCode = await DefaultCountryCode.detectSIMCountry(context);
    if (null == _selectedCountryCode) {
      _selectedCountryCode =
          await DefaultCountryCode.detectNetworkCountry(context);
    } else if (null == _selectedCountryCode) {
      _selectedCountryCode =
          await DefaultCountryCode.detectLocaleCountry(context);
    } else if (null == _selectedCountryCode) {
      _selectedCountryCode = _countryCodes?.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black12, width: 1)),
      onPressed: () => _showCountryCodeDialog(),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: _CountryCodeItemView(countryCode: _selectedCountryCode),
    );
  }

  _showCountryCodeDialog() {
    showDialog(
        context: context,
        builder: (context) => _CountryCodeDialogView(
              countryCodes: _countryCodes,
              onSelect: _onSelect,
            ));
  }
}

class _CountryCodeItemView extends StatelessWidget {
  const _CountryCodeItemView({Key? key, required this.countryCode})
      : super(key: key);
  final CountryCode? countryCode;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${countryCode?.dialCode ?? ""}  ${countryCode?.code ?? ""}  ${countryCode?.name ?? ""}",
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class _CountryCodeDialogView extends StatefulWidget {
  const _CountryCodeDialogView(
      {Key? key, required this.countryCodes, this.onSelect})
      : super(key: key);
  final List<CountryCode>? countryCodes;
  final Function(CountryCode?)? onSelect;

  @override
  __CountryCodeDialogViewState createState() => __CountryCodeDialogViewState();
}

class __CountryCodeDialogViewState extends State<_CountryCodeDialogView> {
  List<CountryCode>? _filteredCountryCodes;

  @override
  void initState() {
    super.initState();
    _filteredCountryCodes = widget.countryCodes;

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: Styles.defaultDialogBackground,
          constraints: BoxConstraints(
              maxHeight: Styles.getDefaultDialogHeight(context),
              maxWidth: Styles.getDefaultDialogWidth(context)),
          child: Column(
            children: [
              Container(
                decoration: Styles.defaultTextFieldDecoration,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: TextField(
                        onChanged: searchCountry,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          isDense: true,
                          hintText: "Search",
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _filteredCountryCodes?.length ?? 0,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            widget.onSelect
                                ?.call(_filteredCountryCodes![index]);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: _CountryCodeItemView(
                                countryCode: _filteredCountryCodes![index]),
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }

  searchCountry(String searchText) {
    setState(() {
      _filteredCountryCodes = widget.countryCodes
          ?.where((countryCode) =>
              countryCode.code!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              countryCode.name!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              countryCode.dialCode!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
          .toList();
    });
  }
}
