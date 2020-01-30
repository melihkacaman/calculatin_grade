import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variables
  String lessonName = "";
  int credit = 1;
  double letterPoint = 4;
  int lessonCount = 0;
  List<Lesson> lessons;
  var formKey;
  double avg = 0.0;

  @override
  void initState() {
    super.initState();
    lessons = [];
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Not Hesaplama"),
      ),
      body: appBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
          setState(() {
            calculate();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget appBody() {
    return Container(
      padding: EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders adını giriniz...",
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 21),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.length > 0) {
                        return null;
                      } else {
                        return "Ders adı boş geçilemez ! ";
                      }
                    },
                    onSaved: (value) {
                      lessonName = value;
                      setState(() {
                        lessons.add(Lesson(value, credit, letterPoint));
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: getCreditsItems(),
                            value: credit,
                            onChanged: (value) {
                              setState(() {
                                credit = value;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: getLetterPointsItems(),
                            value: letterPoint,
                            onChanged: (value) {
                              setState(() {
                                letterPoint = value;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        (avg == 0) ? "Lütfen ders ekleyiniz..." : "Ortalama: ",
                    style: TextStyle(color: Colors.black, fontSize: 28)),
                TextSpan(
                    text: (avg == 0) ? "" : "${avg.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.purple, fontSize: 28)),
              ]),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
                border: BorderDirectional(
              top: BorderSide(color: Colors.blue, width: 2),
              bottom: BorderSide(color: Colors.blue, width: 2),
            )),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: ListView.builder(
                itemBuilder: myListItem,
                itemCount: lessons.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> getCreditsItems() {
    List<DropdownMenuItem<int>> items = List.generate(
      10,
      (index) => DropdownMenuItem<int>(
        child: Text(
          index.toString() + " Kredi",
          style: TextStyle(fontSize: 20),
        ),
        value: index,
      ),
    );

    return items;
  }

  List<DropdownMenuItem<double>> getLetterPointsItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(
        " AA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FF ",
        style: TextStyle(fontSize: 20),
      ),
      value: 0,
    ));

    return harfler;
  }

  Widget myListItem(BuildContext context, int index) {
    return Dismissible(
      key: GlobalKey(),
      direction: DismissDirection.startToEnd,
      child: Container(
        padding: EdgeInsets.all(1),
        child: Card(
          borderOnForeground: true,
          elevation: 5,
          child: ListTile(
            leading: Icon(
              Icons.golf_course,
              color: Colors.blue,
              size: 40,
            ),
            title: Text(lessons[index].name),
            subtitle: Text(lessons[index].credit.toString() +
                " kredi, Notu:" +
                lessons[index].letterPoint.toString()),
          ),
        ),
      ),
      onDismissed: (DismissDirection d) {
        setState(() {
          lessons.removeAt(index);
          calculate();
        });
      },
    );
  }

  void calculate() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oankiDers in lessons) {
      var kredi = oankiDers.credit;
      var harfDegeri = oankiDers.letterPoint;

      toplamNot = toplamNot + (harfDegeri * kredi);
      toplamKredi += kredi;
    }

    avg = toplamNot / toplamKredi;
  }
}

class Lesson {
  String name;
  double letterPoint;
  int credit;

  Lesson(this.name, this.credit, this.letterPoint);
}
