part of ai;

Widget _buildField(AIDCTField field, AIDCTFieldOnChange onChange) {
  switch (field.type) {
    case 'boolean':
       return Text("statefulTitledCheckbox");
      // return StatefulTitledCheckbox(
      //   title: field.label,
      //   value: field.defaultValue != null && (field.defaultValue as bool?)!,
      //   onChanged: (bool? value) {
      //     onChange(field, value);
      //   },
      // );
    case 'integer':
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(field.label),
          ),
          TextFormField(
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            initialValue: field.defaultValue != null ? '${field.defaultValue}' : '',
            //decoration: InputDecoration(labelText: field.label),
            onChanged: (String value) {
              onChange(field, int.parse(value));
            },
            keyboardType: TextInputType.number,
            validator: field.required == true
                ? (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final int? isDigitsOnly = int.tryParse(value);
                    if (isDigitsOnly == null) {
                      return 'Please enter a valid integer';
                    }
                    return null;
                  }
                : null,
          ),
        ],
      );
    case 'string':
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(field.label),
          ),
          TextFormField(
            initialValue: field.defaultValue != null ? field.defaultValue as String : '',
            //decoration: InputDecoration(labelText: field.label),
            onChanged: (String value) {
              onChange(field, value);
            },
            validator: field.required == true
                ? (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a string';
                    }
                    return null;
                  }
                : null,
          ),
        ],
      );
    default:
      return Text('${field.key} - ${field.type}');
  }
}
