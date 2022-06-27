import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:my_taskmanagement/Models/Meeting.dart';
import 'package:date_time_picker/date_time_picker.dart';

class _home extends StatefulWidget {
  const _home({ Key? key }) : super(key: key);
  

  @override
  __homeState createState() => __homeState();
}

class __homeState extends State<_home> {
  @override
  Widget build(BuildContext context) {
    int _selectedBoard = -1;
    final List<String> boards = [
      "network",
      "compiler",
      "network",
      "compiler",
      "network",
      "compiler"
    ];
    final List<String> tasks = ["hw1 network", "project compiler"];
    int tag = 1;
    int? _value;
    List<String> options = [
      'News',
      'Entertainment',
      'Politics',
      'Automotive',
      'Sports',
      'Education',
      'Fashion',
      'Travel',
      'Food',
      'Tech',
      'Science',
    ];
    Color _selectedColor = Colors.green;
    return Scaffold(
      // backgroundColor: Colors.red,
      // appBar: ,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        // color: Colors.red,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, bottom: 30),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height*0.1,
                  // color: Colors.red,
                  child: const Text(
                    "Daily Calendar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.blue,
                          // color: Colors.white,
                          // boxShadow: [
                          //   BoxShadow(color: Colors.green, spreadRadius: 3),
                          // ],
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: SfCalendar(
                            // view: CalendarView.month,
                            dataSource: MeetingDataSource(_getDataSource()),
                            monthViewSettings: MonthViewSettings(
                                appointmentDisplayMode:
                                    MonthAppointmentDisplayMode.appointment),
                          ),

                          // color: Colors.red,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      // height: MediaQuery.of(context).size.height*0.8,
                      // color: Colors.yellowAccent,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30, bottom: 20),
                            child: Container(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.25,
                              // height: MediaQuery.of(context).size.height*0.,
                              child: Text(
                                "Today boards : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.blue,
                                // color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(color: Colors.green, spreadRadius: 3),
                                // ],
                              ),
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  itemCount: boards.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      // style: ListTileStyle(),
                                      title: Text(boards[index]),
                                    );
                                  },
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 30, bottom: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              // height: MediaQuery.of(context).size.height*0.1,
                              child: const Text(
                                "Today tasks : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.blue,
                                // color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(color: Colors.green, spreadRadius: 3),
                                // ],
                              ),
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: boards.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(boards[index]),
                                    );
                                  },
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    int _selectedBoard = -1;
                    return AlertDialog(
                        backgroundColor: Colors.lightBlue[50],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: StatefulBuilder(builder: (context, setState) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Center(
                                        child: Text(
                                      "Adding new task",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  const TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Task name '),
                                  ),
                                  DateTimePicker(
                                    initialValue: '',
                                    type: DateTimePickerType.date,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'Date',
                                    // timeLabelText: 'Start time',
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      // print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                  DateTimePicker(
                                    initialValue: '',
                                    type: DateTimePickerType.time,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    // dateLabelText: 'End Date',
                                    timeLabelText: 'Start time',
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      // print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                  DateTimePicker(
                                    initialValue: '',
                                    type: DateTimePickerType.time,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    // dateLabelText: 'End Date',
                                    timeLabelText: 'End time',
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      // print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 30, bottom: 20),
                                    child: Text("which borad ?"),
                                  ),
                                  SizedBox(
                                      height: 200,
                                      // width: 200,
                                      child: SingleChildScrollView(
                                        child: Wrap(
                                          spacing: 10,
                                          runSpacing: 8,
                                          children: List.generate(
                                              options.length,
                                              (index) => Container(
                                                    decoration: BoxDecoration(
                                                        color: _selectedBoard ==
                                                                index
                                                            ? Colors.green
                                                            : Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: InkWell(
                                                      onTap: () => setState(() {
                                                        _selectedBoard = index;
                                                        // print(_selectedBoard);
                                                      }),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(
                                                            options[index]
                                                                .toString()),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      )

                                      // GridView.builder(
                                      //   itemCount: options.length,
                                      //   itemBuilder: (context, index) {
                                      //     return ChoiceChip(
                                      //       labelStyle:TextStyle(color: Colors.black87, fontFamily: 'Futura', fontSize: 13),
                                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      //       backgroundColor: Colors.grey[600]?.withOpacity(0.7),
                                      //       label: Text(options[index]),
                                      //       disabledColor: Colors.black,
                                      //       selected: _value == index,
                                      //       selectedColor: _selectedColor,
                                      //       onSelected: (bool selected) {

                                      //         setState(() {
                                      //           // _value = selected ? index : null;
                                      //           // _selectedColor = Colors.green ;
                                      //         });
                                      //       },
                                      //     );
                                      //   },
                                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      //     mainAxisSpacing: 0,
                                      //     crossAxisSpacing: 1,
                                      //     crossAxisCount:2,),),
                                      ),

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      onPressed: () {},
                                      child: const Text("ADD" , style: TextStyle(fontWeight: FontWeight.w700),),
                                      shape: RoundedRectangleBorder(
                                      
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          ),
                                    ),
                                  )
                                ]),
                          );
                        }));
                  });
            },
            child: const Center(child: Text("+" , style: TextStyle(fontSize: 30),)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), true));
  meetings.add(Meeting(
      'dentist', startTime, endTime, Color.fromARGB(255, 14, 40, 128), true));
  return meetings;
}