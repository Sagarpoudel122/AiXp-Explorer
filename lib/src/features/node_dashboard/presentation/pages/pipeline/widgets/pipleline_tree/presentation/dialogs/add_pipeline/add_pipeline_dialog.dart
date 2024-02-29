part of ai;

typedef AIDCTFieldOnChange = void Function(AIDCTField field, dynamic value);
typedef AIDCTDialogOnSubmit = Future<bool> Function(
    String pipelineName, String dctType, AIDCTValues values);

class AddPipelineDialog extends StatefulWidget {
  const AddPipelineDialog({
    super.key,
    this.onSubmit,
    required this.boxName,
  });

  final AIDCTDialogOnSubmit? onSubmit;
  final String boxName;

  @override
  State<AddPipelineDialog> createState() => _AddPipelineDialogState();

  static Future<AIDCTValues?> show({
    required BuildContext context,
    AIDCTDialogOnSubmit? onSubmit,
    required String boxName,
  }) {
    return showDialog<AIDCTValues>(
      context: context,
      builder: (BuildContext context) {
        return AddPipelineDialog(
          onSubmit: onSubmit,
          boxName: boxName,
        );
      },
    );
  }
}

class _AddPipelineDialogState extends State<AddPipelineDialog> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Widget> fieldsList = <Widget>[];
  AIDCTValues values = <String, dynamic>{};
  AIDCTListItem? selectedDCTType;
  List<AIPipelineDTO> hostPipelines = <AIPipelineDTO>[];

  bool areFieldsLoading = true;

  @override
  void initState() {
    super.initState();
    () async {
      setState(() {
        isLoading = true;
      });

      hostPipelines =
          await AIRepository().getPipelinesForBox(boxName: widget.boxName);
      setState(() {
        isLoading = false;
      });
    }.call();
  }

  void handleFieldChange(AIDCTField field, dynamic value) {
    values[field.key] = value;
  }

  String getSuggestedName(AIDCTListItem dctType) {
    final List<String> usedNames =
        hostPipelines.map((AIPipelineDTO e) => e.name).toList();
    int index = 1;
    String suggestedName = '${dctType.name} $index';
    while (usedNames.contains(suggestedName)) {
      index++;
      suggestedName = '${dctType.name} $index';
    }
    return suggestedName;
  }

  Future<void> onSelectedDCTChanged(AIDCTListItem? dctType) async {
    selectedDCTType = dctType;
    if (selectedDCTType == null) {
      setState(() {
        areFieldsLoading = false;
        fieldsList = <Widget>[];
      });
      return;
    }

    final String suggestedName = getSuggestedName(dctType!);
    pipelineName = suggestedName;
    nameController.text = suggestedName;

    final AIDCT dct =
        await AIRepository().getDCTForType(dctType: selectedDCTType!.type);

    values = <String, dynamic>{};
    fieldsList = dct.fields.map(
      (AIDCTField field) {
        if (field.defaultValue != null) {
          values[field.key] = field.defaultValue;
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildField(field, handleFieldChange),
        );
      },
    ).toList();

    setState(() {
      areFieldsLoading = false;
    });
  }

  bool isLoading = false;

  String pipelineName = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: Colors.black45,
            ),
          ),
          titleTextStyle: TextStyle(color:  Colors.black45),
          backgroundColor:  Colors.black45,
          title: const Text('Add pipeline'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DCTTypeDropdown(
                      label: 'DCT Type',
                      onChanged: onSelectedDCTChanged,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Name'),
                      ),
                      TextFormField(
                        controller: nameController,
                        onChanged: (String value) {
                          pipelineName = value;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  if (!areFieldsLoading)
                    Column(
                        key: ValueKey<String>(selectedDCTType!.name),
                        children: <Widget>[...fieldsList])
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 12),
              child: TextButton(
                child: const Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  if (widget.onSubmit != null) {
                    setState(() {
                      isLoading = true;
                    });
                    final bool canCloseDialog = await widget.onSubmit!.call(
                      pipelineName,
                      selectedDCTType!.type,
                      values,
                    );
                    setState(() {
                      isLoading = false;
                    });
                    if (!canCloseDialog) {
                      return;
                    }
                  }

                  if (context.mounted) {
                    Navigator.of(context).pop(values);
                  }
                },
              ),
            ),
          ],
        ),
        if (isLoading)
          const ColoredBox(
            color: Colors.transparent,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
