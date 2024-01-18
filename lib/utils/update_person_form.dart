import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uas_flutter/model/person.dart';

class UpdatePersonForm extends StatefulWidget {
  final int index;
  final Person person;
  const UpdatePersonForm({
    required this.index,
    required this.person,
  });

  @override
  _UpdatePersonFormState createState() =>
      _UpdatePersonFormState();
}

class _UpdatePersonFormState extends State<UpdatePersonForm> {
  final _personFormKey = GlobalKey<FormState>();
  late final _nameController;
  late final _kodeController;
  late final _jadwalController;
  late final Box box;
  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  //Update info of people box
  _updateInfo() {
    Person newPerson = Person(
      nama: _nameController.text,
      kode: _kodeController.text,
      jadwal: _jadwalController.text,
    );
    box.putAt(widget.index, newPerson);
    print('Info updated in box!');
  }

  @override
  void initState() {
    super.initState();
    //Get reference to an already opened box
    box = Hive.box('peopleBox');
    _nameController = TextEditingController(text:
    widget.person.nama);
    _kodeController = TextEditingController(text:
    widget.person.kode);
    _jadwalController = TextEditingController(text:
    widget.person.kode);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personFormKey,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text('Nama Mata Kuliah'),
          TextFormField(
            controller: _nameController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('Kode Mata Kuliah'),
          TextFormField(
            controller: _kodeController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('Jadwal Kuliah'),
          TextFormField(
            controller: _jadwalController,
            validator: _fieldValidator,
          ),

          Padding(
            padding: const
            EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if
                  (_personFormKey.currentState!.validate()) {
                    _updateInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Update'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}