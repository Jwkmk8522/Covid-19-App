import 'package:covid_19_app/View/Detail_screen.dart';
import 'package:covid_19_app/View_Modal/world_state_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesStateScreen extends StatefulWidget {
  const CountriesStateScreen({super.key});

  @override
  State<CountriesStateScreen> createState() => _CountriesStateScreenState();
}

class _CountriesStateScreenState extends State<CountriesStateScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldStateApi api = WorldStateApi();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  hintText: 'Search Countries ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: api.fetchCountriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                            height: 10, width: 80, color: Colors.blue),
                        subtitle: Container(
                            height: 10, width: 80, color: Colors.blue),
                        leading: Container(
                            height: 50, width: 50, color: Colors.blue),
                      );
                    },
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'];
                    if (_searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      countryName: snapshot.data![index]
                                          ['country'],
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      test: snapshot.data![index]['tests'],
                                      totadayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      totalCases: snapshot.data![index]
                                          ['cases'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'])));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          ),
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase())) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  countryName: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  test: snapshot.data![index]['tests'],
                                  totadayRecovered: snapshot.data![index]
                                      ['todayRecovered'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]
                                      ['recovered'])));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ))
        ],
      )),
    );
  }
}
