import 'package:flutter/material.dart';

class Exercise2 extends StatefulWidget {
  const Exercise2({super.key});
  @override
  State<Exercise2> createState() => _Exercise2State();
}

class _Exercise2State extends State<Exercise2> {
  double _sliderVal = 20.0;
  bool _switchVal = false;
  int _radioVal = 1;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Slider Value: ${_sliderVal.round()}'),
            Slider(value: _sliderVal, min: 0, max: 100, onChanged: (v) => setState(() => _sliderVal = v)),
            SwitchListTile(
                title: const Text('Kích hoạt Switch'),
                value: _switchVal,
                onChanged: (v) => setState(() => _switchVal = v)
            ),
            RadioListTile(title: const Text('Lựa chọn 1'), value: 1, groupValue: _radioVal, onChanged: (v) => setState(() => _radioVal = v as int)),
            RadioListTile(title: const Text('Lựa chọn 2'), value: 2, groupValue: _radioVal, onChanged: (v) => setState(() => _radioVal = v as int)),
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2030));
                if (date != null) setState(() => _selectedDate = date);
              },
              child: const Text('Chọn ngày'),
            ),
            if (_selectedDate != null) Text('Ngày đã chọn: ${_selectedDate.toString().split(' ')[0]}'),
          ],
        ),
      ),
    );
  }
}