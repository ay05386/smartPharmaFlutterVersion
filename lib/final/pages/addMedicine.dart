import 'package:flutter/material.dart';

import '../localDataBase/MedecinDB.dart';
import '../localDataBase/localMedicineDB.dart';
import '../localDataBase/localUserDB.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  late MedicineDB userDatabaseAddMedicine;
  TextEditingController name = TextEditingController();
  TextEditingController effective = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController sold = TextEditingController();
  TextEditingController user_id = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDatabaseAddMedicine = MedicineDB();
    userDatabaseAddMedicine.CreateDatabaseAndTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Medicine')),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.account_box),
                  hintText: 'write medicine name',
                  label: Text('name',style: TextStyle(color: Colors.black,fontSize: 30),)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: effective,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.description),
                  hintText: 'write medicine description',
                  label: Text('description',style: TextStyle(color: Colors.black,fontSize: 30),)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: price,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.numbers),
                  hintText: 'write medicine price',
                  label: Text('price',style: TextStyle(color: Colors.black,fontSize: 30),)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: quantity,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.numbers),
                  hintText: 'write medicine quantity',
                  label: Text('quantity',style: TextStyle(color: Colors.black,fontSize: 30),)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: sold,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.numbers),
                  hintText: 'write medicin sold',
                  label: Text('sold',style: TextStyle(color: Colors.black,fontSize: 30),)
              ),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              await userDatabaseAddMedicine.insertMedicine(
                  name: name.text,
                  effective: effective.text,
                  quantity: int.parse(quantity.text),
                  sold: int.parse(sold.text),
                  price: int.parse(price.text));
              Navigator.of(context).pop(true); // Indicate that data has changed
            },
            child: Text("Add",style: TextStyle(color: Colors.black,fontSize: 25),),
          ),
        ],
      ),
    );
  }
}
