part of ai;

typedef AIPluginDialogOnSubmit = Future<bool> Function(
    String pluginName, AIPluginType pluginType);

class AddPluginDialog extends StatefulWidget {
  const AddPluginDialog({
    super.key,
    this.onSubmit,
    required this.pipeline,
  });

  final AIPluginDialogOnSubmit? onSubmit;
  final AIPipeline pipeline;

  @override
  State<AddPluginDialog> createState() => _AddPluginDialogState();

  static Future<AIPluginType?> show({
    required BuildContext context,
    required AIPipeline pipeline,
    AIPluginDialogOnSubmit? onSubmit,
  }) {
    return showDialog<AIPluginType?>(
      context: context,
      builder: (BuildContext context) {
        return AddPluginDialog(
          onSubmit: onSubmit,
          pipeline: pipeline,
        );
      },
    );
  }
}

class _AddPluginDialogState extends State<AddPluginDialog> {
  final TextEditingController nameController = TextEditingController();
  List<AIPluginInstanceReference> pluginInstances =
      <AIPluginInstanceReference>[];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AIPluginType? selectedPluginType;

  Future<void> onSelectedPluginTypeChanged(AIPluginType? pluginType) async {
    selectedPluginType = pluginType;
    if (selectedPluginType == null) {
      return;
    }

    final String suggestedName = getSuggestedName(pluginType!);
    pluginName = suggestedName;
    nameController.text = suggestedName;
    setState(() {});
  }

  bool isLoading = false;
  String pluginName = '';

  String getSuggestedName(AIPluginType pluginType) {
    final List<AIPluginInstanceReference> typeInstances = pluginInstances
        .where((AIPluginInstanceReference element) =>
            element.signature == pluginType.signature)
        .toList();

    final List<String> usedNames =
        typeInstances.map((AIPluginInstanceReference e) => e.name).toList();
    int index = 1;
    String suggestedName = '${pluginType.name} $index';
    while (usedNames.contains(suggestedName)) {
      index++;
      suggestedName = '${pluginType.name} $index';
    }
    return suggestedName;
  }

  @override
  void initState() {
    super.initState();
    () async {
      setState(() {
        isLoading = true;
      });
      pluginInstances = await AIRepository().getPluginInstances(
        boxName: widget.pipeline.boxName,
        pipelineName: widget.pipeline.name,
      );
          setState(() {
        isLoading = false;
      });
    }.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: Colors.black12,
            ),
          ),
          titleTextStyle: TextStyle(color: AppColors.textPrimaryColor),
          backgroundColor: Colors.black12,
          title: const Text('Add plugin'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: AIPluginTypeDropdown(
                          label: 'Plugin type',
                          onChanged: onSelectedPluginTypeChanged,
                        ),
                      ),
                    ],
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
                          pluginName = value;
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

                    final bool canCloseDialog = await widget.onSubmit!
                        .call(pluginName, selectedPluginType!);

                    setState(() {
                      isLoading = false;
                    });

                    if (!canCloseDialog) {
                      return;
                    }
                  }

                  if (context.mounted) {
                    Navigator.of(context).pop(selectedPluginType);
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
