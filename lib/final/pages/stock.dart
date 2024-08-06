import 'package:flutter/material.dart';
import '../localDataBase/MedecinDB.dart';
import '../localDataBase/localUserDB.dart';
import 'Drawer.dart';
import 'addMedicine.dart';
import 'homePage.dart';
import 'loginPage.dart';


class Stock extends StatefulWidget {
  final Map<String, dynamic> userData;
  final UserDB userDB;

  const Stock({required this.userData, required this.userDB, Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  late MedicineDB userDatabaseStock;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    userDatabaseStock = MedicineDB();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await userDatabaseStock.CreateDatabaseAndTables();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    await _initializeDatabase();
  }

  void logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(userDB: widget.userDB, userData: widget.userData, onLogout: logout),
      appBar: AppBar(
        title: Text("Stock", style: TextStyle(color: Colors.black)),
        actions: [
          InkWell(
            onTap: () async {
              bool? dataChanged = await Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                return AddMedicine();
              }));
              if (dataChanged == true) {
                _refreshData(); // Refresh data if it changed
              }
            },
            child: Icon(Icons.more_vert_sharp, color: Colors.white),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Map<dynamic, dynamic>>>(
        future: userDatabaseStock.showData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final medicines = snapshot.data ?? [];
            return ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(medicine['medicine_name']),
                            Text(medicine['medicine_effective']),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Price: ${medicine['medicine_price'].toString()}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Quantity: ${medicine['medicine_quantity'].toString()}'),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
