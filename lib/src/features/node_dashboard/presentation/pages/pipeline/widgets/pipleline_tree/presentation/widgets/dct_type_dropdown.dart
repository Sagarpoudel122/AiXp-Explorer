part of ai;

class DCTTypeDropdown extends StatefulWidget {
  const DCTTypeDropdown({
    super.key,
    required this.label,
    required this.onChanged,
    this.isRequired = false,
  });

  final String label;
  final bool isRequired;
  final void Function(AIDCTListItem? dctType) onChanged;

  @override
  State<DCTTypeDropdown> createState() => _DCTTypeDropdownState();
}

class _DCTTypeDropdownState extends State<DCTTypeDropdown> {
  bool isLoading = true;
  late final List<AIDCTListItem> dctTypes;
  AIDCTListItem? selectedDCT;

  @override
  void initState() {
    super.initState();
    () async {
      dctTypes = await AIRepository().getDCTTypes();
      selectedDCT = dctTypes.first;
      widget.onChanged(selectedDCT);
      setState(() {
        isLoading = false;
      });
    }.call();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return DropdownButtonFormField<AIDCTListItem>(
      iconEnabledColor: AppColors.dropdownFieldFillColor,iconDisabledColor: AppColors.dropdownFieldFillColor,
      style: TextStyles.body(),
      dropdownColor: AppColors.dropdownFieldFillColor,
      decoration: InputDecoration(
        fillColor: AppColors.inputFieldFillColor,
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: defaultBorder,
        focusedErrorBorder: defaultBorder,
        labelText: widget.label,
      ),
      value: selectedDCT,
      items: dctTypes.map((AIDCTListItem dctType) {
        return DropdownMenuItem<AIDCTListItem>(
          value: dctType,
          child: Text(dctType.name),
        );
      }).toList(),
      onChanged: widget.onChanged,
      validator: widget.isRequired
          ? (AIDCTListItem? value) {
              if (value == null) {
                return 'Please select an option';
              }
              return null;
            }
          : null,
    );
  }

  OutlineInputBorder get defaultBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.inputFieldBorderRadius),
        borderSide: BorderSide.none,
      );
}
