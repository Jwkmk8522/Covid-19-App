import 'package:covid_19_app/Modals/world_state_model.dart';
import 'package:covid_19_app/View_Modal/world_state_api.dart';
import 'package:covid_19_app/View/countries_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];
  late Future<WorldStateModel> _worldStateFuture;
  @override
  void initState() {
    _worldStateFuture = WorldStateApi().fetchWorldStateProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
              ),
              FutureBuilder(
                future: _worldStateFuture,
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        child: SpinKitFadingCircle(
                      controller: _controller,
                      color: Colors.white,
                      size: 50,
                    ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: colorList,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartRadius: MediaQuery.of(context).size.width * .312,
                          // chartRadius: MediaQuery.of(context).size.width / 3.2,
                          animationDuration: const Duration(seconds: 4),
                          chartType: ChartType.ring,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .03),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseAbleRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                ReuseAbleRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReuseAbleRow(
                                    title: 'Death',
                                    value: snapshot.data!.deaths.toString()),
                                ReuseAbleRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReuseAbleRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                ReuseAbleRow(
                                    title: 'Today Death',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CountriesStateScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .15),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  const Center(child: Text('Track Countries')),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseAbleRow extends StatelessWidget {
  final String title, value;
  const ReuseAbleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const Divider(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
