import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:healtish_app/model/ordinal_chart.dart';
import 'package:healtish_app/services/auth.dart';
import 'package:healtish_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key key}) : super(key: key);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final AuthService _auth = AuthService();
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0XFF200087),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    final DatabaseService databaseService = DatabaseService();
    var userWeightData =
        databaseService.getCurrentUserWeightData(_auth.getCurrentUser());
    var userSportData =
        databaseService.getCurrentUserSportData(_auth.getCurrentUser());
    var correlationCoefficient =
        databaseService.getCorrelationCoefficient(_auth.getCurrentUser());
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('calorie').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            } else {
              return FutureBuilder(
                  future: Future.wait(
                      [userWeightData, userSportData, correlationCoefficient]),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: RefreshProgressIndicator(),
                      );
                    } else {
                      // User Weight
                      List<OrdinalChart> userWeight = [];
                      for (int i = 0; i < snapshot.data[0].length; i++)
                        userWeight.add(
                            OrdinalChart(i.toString(), snapshot.data[0][i]));
                      // User Sport
                      List<OrdinalChart> userSport = [];
                      for (int i = 0; i < snapshot.data[1].length; i++)
                        userSport.add(
                            OrdinalChart(i.toString(), snapshot.data[1][i]));
                      // Correlation
                      List<OrdinalChart> correlation = [];
                      for (int i = 0; i < snapshot.data[1].length; i++)
                        correlation
                            .add(OrdinalChart(i.toString(), snapshot.data[2]));

                      List<charts.Series<dynamic, String>> seriesList = [
                        new charts.Series<OrdinalChart, String>(
                            id: 'Weight',
                            colorFn: (_, __) =>
                                charts.MaterialPalette.blue.shadeDefault,
                            domainFn: (OrdinalChart sales, _) => sales.year,
                            measureFn: (OrdinalChart sales, _) => sales.value,
                            data: userWeight,
                            labelAccessorFn: (OrdinalChart sales, _) =>
                                '\$Weight'),
                        new charts.Series<OrdinalChart, String>(
                            id: 'Sport',
                            colorFn: (_, __) =>
                                charts.MaterialPalette.red.shadeDefault,
                            domainFn: (OrdinalChart sales, _) => sales.year,
                            measureFn: (OrdinalChart sales, _) => sales.value,
                            data: userSport,
                            labelAccessorFn: (OrdinalChart sales, _) =>
                                '\$Sport'),
                        new charts.Series<OrdinalChart, String>(
                            id: 'CorrelationCoefficient',
                            colorFn: (_, __) =>
                                charts.MaterialPalette.green.shadeDefault,
                            domainFn: (OrdinalChart sales, _) => sales.year,
                            measureFn: (OrdinalChart sales, _) => sales.value,
                            data: correlation,
                            labelAccessorFn: (OrdinalChart sales, _) =>
                                '\$CorrelationCoefficient')
                          ..setAttribute(charts.rendererIdKey, 'customLine'),
                      ];
                      return Container(
                        margin: const EdgeInsets.all(20.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)), //here
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                 // offset: Offset(-5, 0),
                                  blurRadius: 20.0)
                            ]),
                        child: Stack(
                          children: [
                            new charts.OrdinalComboChart(seriesList,
                                animate: true,
                                defaultRenderer: new charts.BarRendererConfig(
                                    groupingType:
                                        charts.BarGroupingType.grouped),
                                customSeriesRenderers: [
                                  new charts.LineRendererConfig(
                                      customRendererId: 'customLine')
                                ]),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue),
                                  ),
                                  Text('   Weight'),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                  ),
                                  Text('   Sport'),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                  ),
                                  Text('   Correlation Coefficient'),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  });
            }
          }),
    );
  }
}
