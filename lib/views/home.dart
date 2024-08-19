import 'dart:convert';

import 'package:ai_bharata/views/each_tile.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WebSocketChannel channel;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = WebSocketChannel.connect(
        Uri.parse('ws://prereg.ex.api.ampiy.com/prices'));

    channel.sink.add(json.encode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1
    }));
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "COINS  ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff6148AA),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search Coin',
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      Map<String, dynamic> response = jsonDecode(snapshot.data);
                      List data = response['data'] ?? [];
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            String c = data[index]['c'];
                            String p = data[index]['p'];
                            String s = data[index]['s'];

                            if (searchController.text.isEmpty) {
                              return EachTile(
                                c: c,
                                p: p,
                                s: s,
                                tileColor: (index % 2 == 0)
                                    ? Colors.white
                                    : Colors.grey.withOpacity(0.1),
                              );
                            } else if (s.toLowerCase().startsWith(
                                searchController.text.toLowerCase())) {
                              return EachTile(
                                c: c,
                                p: p,
                                s: s,
                              );
                            } else {
                              return Container();
                            }
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
