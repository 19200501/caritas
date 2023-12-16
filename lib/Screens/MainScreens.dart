
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../Constant/const.dart';
import '../Screens/EditPage.dart';
import '../Screens/Login.dart';
import 'package:another_flushbar/flushbar.dart';
import '../Models/Motivasi_Model.dart';
import '../Screens/Mainscreen/main_screen.dart';
import 'package:flutter_auth/Screens/header_drawer.dart';

class MainScreens extends StatefulWidget {
  final String? nama;
  final String? iduser;

  const MainScreens({Key? key, this.nama,this.iduser
  }) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
String baseurl = "http://localhost/vigenesia/";


String? id;
var dio = Dio();
  TextEditingController titleController = TextEditingController();

  Future<dynamic> sendMotivasi(String Motivasi) async {
    Map<String, dynamic> body = {"isi_motivasi": Motivasi,"iduser": widget.iduser //?? '' //sudah ok
      //"iduser": widget.iduser
    };

    try {
      final response= await dio.post("$baseurl/api/dev/POSTmotivasi/",data: body,
          options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
           
          
      return response;
    } catch (e) {
      print("Error di -> $e");
    }
    
  }
List<MotivasiModel>listproduk=[];

  Future<List<MotivasiModel>> getData() async {
    var response = await dio.get('$baseurl/api/Get_motivasi');

    print(" ${response.data}");
    if (response.statusCode == 200) {
      var getUsersData = response.data as List;
      var listUsers =
          getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load');
    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
  }

    Future<dynamic>deletePost(String id) async{
      dynamic data={
        "id":id,
      };
      var response = await dio.delete('$baseurl/api/dev/DELETEmotivasi',data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Content-type":"application/json"}
      ));
      print("${response.data}");
      var resbody=jsonDecode(response.data);
      return resbody;
    }

  Future<void> _getData() async {
    setState(() {
      _getData();
    });
  }

  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  const MyHeaderDrawer(),
                  SizedBox(
                    height: 40,
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hallo  ${widget.nama}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        child: Icon(Icons.logout),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    controller: isiController,
                    name: "isi_motivasi",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        await sendMotivasi(isiController.text.toString())
                            .then((value) => {
                                  if (value != null)
                                    {
                                      Flushbar(
                                        message: "Berhasil Submit",
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.greenAccent,
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context)
                                    },
                                  _getData(),
                                  print("Sukses"),
                                });
                      },
                      child: Text("Submit"),
                    ),
                  ),
                  SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {
                        _getData();
                      },
                    ),
                    FutureBuilder(
                        future: getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<MotivasiModel>> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                for (var item in snapshot.data!)
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(item.isiMotivasi.toString()),
                                              Row(
                                                children: [
                                                  TextButton(
                                                    child: Icon(Icons.settings),
                                                    onPressed: () {
                                                      String id;
                                                      String isi_motivasi;
                                                      
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                EditPage(
                                                                    id: item.id,
                                                                    isi_motivasi:
                                                                        item.isiMotivasi),
                                                          ));
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Icon(Icons.delete),
                                                    onPressed: () {
                                                      deletePost(item.id!)
                                                          .then((value) => {
                                                                if (value !=
                                                                    null)
                                                                  {
                                                                    Flushbar(
                                                                      message:
                                                                          "Berhasil Delete",
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                      backgroundColor:
                                                                          const Color.fromARGB(255, 82, 220, 255),
                                                                      flushbarPosition:
                                                                          FlushbarPosition
                                                                              .TOP,
                                                                    ).show(
                                                                        context)
                                                                  }
                                                              });
                                                      _getData();
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isEmpty) {
                            return Text("No Data");
                          } else {
                            return CircularProgressIndicator();
                          }
                        })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

