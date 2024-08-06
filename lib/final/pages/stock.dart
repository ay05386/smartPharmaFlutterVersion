import 'package:flutter/material.dart';
import 'loginPage.dart';
import '../localDataBase/MedecinDB.dart';
import 'addMedicine.dart';
import 'homePage.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

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

  void _logout() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("User Email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("U"),
              ),
              decoration: BoxDecoration(color: Colors.orange),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: Text("Stock"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: _logout,
            ),
          ],
        ),
      ),
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
