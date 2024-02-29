part of ai;

class AIPluginTypeDropdown extends StatefulWidget {
  const AIPluginTypeDropdown({
    super.key,
    required this.label,
    required this.onChanged,
    this.isRequired = false,
  });

  final String label;
  final bool isRequired;
  final void Function(AIPluginType? pluginType) onChanged;

  @override
  State<AIPluginTypeDropdown> createState() => _AIPluginTypeDropdownState();
}

class _AIPluginTypeDropdownState extends State<AIPluginTypeDropdown> {
  bool isLoading = true;
  late final List<AIPluginType> dctTypes;
  AIPluginType? selectedPluginType;

  @override
  void initState() {
    super.initState();
    () async {
      dctTypes = await AIRepository().getPluginTypes();
      selectedPluginType = dctTypes.first;
      widget.onChanged(selectedPluginType);
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
    return DropdownButtonFormField<AIPluginType>(
      iconEnabledColor: AppColors.dropdownFieldFillColor,
      iconDisabledColor: AppColors.dropdownFieldFillColor,
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
      value: selectedPluginType,
      items: dctTypes.map((AIPluginType pluginType) {
        return DropdownMenuItem<AIPluginType>(
          value: pluginType,
          child: Text(pluginType.name),
        );
      }).toList(),
      onChanged: widget.onChanged,
      validator: widget.isRequired
          ? (AIPluginType? value) {
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
