import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Basket Ball Live Score",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("basket_ball")
            .doc("yDgsH9vlaJRQyP5y40Iu").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return const Text("No data available."); // Handle the case when data is not available
          }

          final data = snapshot.data!.data()!; // Get the data map

          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  data["match_name"],
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          data["team_a_score"].toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          data["team_name_a"],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Text("VS"),
                    Column(
                      children: [
                        Text(
                          data["team_b_score"].toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          data["team_name_b"],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // update value
          FirebaseFirestore.instance
              .collection("basket_ball")
              .doc("yDgsH9vlaJRQyP5y40Iu").update({"match_name":" Ind vs Pak"});

          //delete document
          // FirebaseFirestore.instance.collection("basket_ball")
          //     .doc("yDgsH9vlaJRQyP5y40Iu").delete();


        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



