import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('યાર્ડ ભાવ')),
          backgroundColor: Colors.green,
        ),
        body: const YardScreen(),
      ),
    ),
  );
}

class YardScreen extends StatefulWidget {
  const YardScreen({super.key});

  @override
  State<YardScreen> createState() => _YardScreenState();
}

class _YardScreenState extends State<YardScreen> {
  List<Map<int, String>> cityNameId = [
    {1: 'ભુજ'},
    {2: 'રાપર'},
    {3: 'અંજાર'},
    {4: 'ભચાઉ'},
    {5: 'ભુજ ફ્રૂટ'},
    {6: 'જામનગર'},
    {8: 'મોરબી'},
    {9: 'હળવદ'},
    {11: 'જૂનાગઢ'},
    {12: 'તળાજા'},
    {13: 'રાજકોટ'},
    {14: 'બોટાદ'},
    {15: 'રાજકોટ શાક'},
    {16: 'કોડીનાર'},
    {17: 'ભાવનગર'},
    {18: 'અમરેલી'},
    {19: 'ધ્રોલ'},
    {21: 'જામજોધપુર'},
    {22: 'વિસાવદર'},
    {24: 'પોરબંદર'},
    {25: 'સાવરકુંડલા'},
    {26: 'અમરેલી શાક'},
    {27: 'જસદણ'},
    {29: 'કાલાવડ'},
    {30: 'વાંકાનેર'},
    {33: 'વેરાવળ'},
    {34: 'બાબરા'},
    {35: 'મેંદરડા'},
    {36: 'ધોરાજી'},
    {39: 'અમરેલી ફ્રૂટ'},
    {40: 'ગોંડલ ફ્રૂટ'},
    {41: 'ગોંડલ શાક'},
    {44: 'ઊંઝા'},
    {54: 'વિજાપુર'},
    {55: 'વિજાપુર શાક'},
    {59: 'કુકરવાડા'},
    {64: 'ગોઝારીયા'},
    {91: 'કપડવંજ'},
    {108: 'દહેગામ'},
    {109: 'દાહોદ'},
    {110: 'દાહોદ શાક'},
    {111: 'સુરત શાક'},
    {113: 'ઉપલેટા'},
    {114: 'ચોટીલા'},
    {118: 'ભેંસાણ'},
    {119: 'રાજુલા'},
    {120: 'બગસરા'},
    {121: 'લાલપુર'},
    {122: 'ધારી'},
    {123: 'ધ્રાંગધ્રા'},
    {124: 'કપડવંજ શાકભાજી'},
    {126: 'પાલીતાણા'},
  ];
  List<Map<String, dynamic>> dataList = [];
  String username = 'Agrizes@2486';
  String password = 'Zesagri@2684';
  String formattedDate = '';
  String cityName = '';
  int id = 0;
  bool isEnable = false;
  bool show = true;
  var date = '';

  void searchId() {
    for (var city in cityNameId) {
      if (city.containsValue(cityName)) {
        id = city.keys.first;
      }
    }
  }

  Future<void> fetchData() async {
    String apiUrl =
        "https://test.aajnabajarbhav.com/index.php/user/product?yard=$id";
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'authorization': basicAuth},
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          dataList = responseData.map<Map<String, dynamic>>((item) {
            date = item['time_stamp'];
            return {
              'product_name': item['product_name'],
              'low_price': item['low_price'],
              'high_price': item['high_price'],
              'time_stamp': item['time_stamp'],
              'region_name': item['region_name'],
              'region_id': item['region_id'],
              'marketyard_name': item['marketyard_name'],
              'name': item['name'],
            };
          }).toList();
          isEnable = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SearchField<String>(
                  hint: 'અહીં શોધો',
                  searchInputDecoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.green,
                      size: 30,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightGreen.withOpacity(0.8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  itemHeight: 50,
                  maxSuggestionsInViewPort: 10,
                  suggestionsDecoration: SuggestionDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suggestions: cityNameId
                      .map(
                        (e) => SearchFieldListItem<String>(
                          e.values.first,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(e.values.first),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onSubmit: (e) {
                    setState(() {
                      show = false;
                      cityName = e;
                      isEnable = true;
                      searchId();
                      fetchData();
                    });
                  },
                  textInputAction: TextInputAction.search,
                ),
              ),
              show
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 200),
                      child: Center(
                          child: Text(
                        'યાર્ડ શોધો',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                    )
                  : //searchbar
                  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'ગામ :  ',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cityName,
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'તા: ${date.toString()}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '20 કિલોનો ભાવ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ), // date & cityName
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: const [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'ઉત્પાદન',
                                                style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'નિચા',
                                                style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'ઊંચા',
                                                style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ), // table
                            isEnable
                                ? const Center(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 1000,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: dataList.length,
                                      itemBuilder: (context, index) {
                                        var name =
                                            dataList[index]['product_name'];
                                        var lowPrice =
                                            dataList[index]['low_price'];
                                        var highPrice =
                                            dataList[index]['high_price'];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white70,
                                            ),
                                            child: Table(
                                              defaultVerticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              children: [
                                                TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            lowPrice,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            highPrice,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
              // listview
            ],
          ),
        ),
      ),
    );
  }
}
