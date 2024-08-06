
import 'package:first/final/pages/stock.dart';
import 'package:flutter/material.dart';
import '../localDataBase/MedecinDB.dart';
import '../localDataBase/localUserDB.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MedicineDB userDatabase;
  bool isDatabaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    userDatabase = MedicineDB();
    await userDatabase.CreateDatabaseAndTables();
    // Add a small delay to ensure all operations are complete
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isDatabaseInitialized = true;
    });
  }

  Future<List<Map<String, dynamic>>> fetchLowQuantityMeds() async {
    try {
      List<Map> meds = await userDatabase.showData();
      List<Map<String, dynamic>> typedMeds = List<Map<String, dynamic>>.from(meds);
      typedMeds.sort((a, b) => a['medicine_quantity'].compareTo(b['medicine_quantity']));
      return typedMeds.take(10).toList();
    } catch (e) {
      print('Error fetching low quantity meds: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchMostSoldMeds() async {
    try {
      List<Map> meds = await userDatabase.showData();
      List<Map<String, dynamic>> typedMeds = List<Map<String, dynamic>>.from(meds);
      typedMeds.sort((a, b) => b['medicine_sold'].compareTo(a['medicine_sold']));
      return typedMeds.take(10).toList();
    } catch (e) {
      print('Error fetching most sold meds: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.black, fontSize: 25)),
        backgroundColor: Colors.orange,
      ),
      body: isDatabaseInitialized
          ? Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Low Quantity', style: TextStyle(color: Colors.black, fontSize: 25)),
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchLowQuantityMeds(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final med = snapshot.data![index];
                            return ListTile(
                              title: Text(med['medicine_name']),
                              subtitle: Text('Quantity: ${med['medicine_quantity']}'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Most Sold', style: TextStyle(color: Colors.black, fontSize: 25)),
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchMostSoldMeds(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final med = snapshot.data![index];
                            return ListTile(
                              title: Text(med['medicine_name']),
                              subtitle: Text('Sold: ${med['medicine_sold']}'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (c){
              return Stock();
            }),

            );
          },
            child: Text("stock"),
          )
        ],
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}