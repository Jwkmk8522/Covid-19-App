import 'package:covid_19_app/View/world_state_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String countryName;
  final String image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      totadayRecovered,
      test;
  const DetailScreen({
    super.key,
    required this.countryName,
    required this.image,
    required this.active,
    required this.critical,
    required this.test,
    required this.totadayRecovered,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Card(
                    child: Column(
                  children: [
                    ReuseAbleRow(
                        title: 'Cases', value: widget.totalCases.toString()),
                    ReuseAbleRow(
                        title: 'Deaths', value: widget.totalDeaths.toString()),
                    ReuseAbleRow(
                        title: 'Today Recovered',
                        value: widget.totadayRecovered.toString()),
                    ReuseAbleRow(
                        title: 'Active', value: widget.active.toString()),
                    ReuseAbleRow(
                        title: 'Critical', value: widget.critical.toString()),
                    ReuseAbleRow(
                        title: 'Today Recovered',
                        value: widget.totadayRecovered.toString()),
                    ReuseAbleRow(title: 'Tests', value: widget.test.toString()),
                  ],
                )),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
