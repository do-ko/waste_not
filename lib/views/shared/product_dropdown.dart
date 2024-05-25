import 'package:flutter/material.dart';
import 'package:waste_not/views/shared/theme.dart';

class ProductDropdown extends StatefulWidget {
  final Iterable<String> values;
  final String? currentValue;
  final void Function(String?) onChanged;

  const ProductDropdown(
      {super.key,
      required this.values,
      this.currentValue,
      required this.onChanged});

  @override
  State<StatefulWidget> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  String? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Card(
            color: containerColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15), // Set the Card's border radius
            ),
            shadowColor: Colors.transparent,
            child: Expanded(
                child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              isExpanded: true,
              dropdownColor: containerColor,
              focusColor: containerColorSplash,
              alignment: AlignmentDirectional.center,
              underline: Container(),
              hint: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text("Choose ingredient",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: textHeaderColor))),
              value: currentValue,
              onChanged: (val) => setState(() {
                widget.onChanged(val);
                currentValue = val;
              }),
              items: widget.values
                  .map((String value) => DropdownMenuItem<String>(
                        alignment: AlignmentDirectional.center,
                        value: value,
                        child: Text(
                          value,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: textHeaderColor),
                        ),
                      ))
                  .toList(),
            ))));
  }
}
