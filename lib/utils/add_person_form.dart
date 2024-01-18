import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uas_flutter/model/person.dart';

class AddPersonForm extends StatefulWidget {
  const AddPersonForm({Key? key}) : super(key: key);

  @override
  _AddPersonFormState createState() =>
      _AddPersonFormState();
}

class _AddPersonFormState extends
State<AddPersonForm> {
  final _namaController = TextEditingController();
  final _jadwalController = TextEditingController();
  final _kodeController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  //ADD INFO TO PEOPLE BOX
  _addInfo() async{
    Person newPerson = Person(
      nama: _namaController.text,
      kode: _kodeController.text,
      jadwal:_jadwalController.text,
    );

    box.add(newPerson);
    print('Info added to box!');
  }

  @override
  void initState() {
    super.initState();
    //Get reference to an already opened box
    box = Hive.box('peopleBox');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Mata Kuliah'),
          TextFormField(
            controller: _namaController,
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
          Spacer(),
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
                    _addInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}