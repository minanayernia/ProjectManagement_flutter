import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:my_taskmanagement/data_provider.dart';
import 'dart:math' as math show pi;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'SingleBoard.dart';
import 'Signup.dart';
import 'Login.dart';
import 'package:intl/intl.dart';

class Board {
  Board(this.boardName,
  //  this.background ,
    this.pk);
  int pk ;
  String boardName;
  // Color background;
}
List boardList = [];


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sidebar ui',
      home: Scaffold(
        // body: SidebarPage(),
        body: SignUp(),
        // body: Login(),
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  const SidebarPage({Key? key, required this.pk}) : super(key: key);
  final pk;
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem>? _items;
  String? _headline;

  String? username;
  String? email;
  String? phoneNumber;
  String? about;
  String? pic;
  DateTime? birthday;

  void reload(){
    setState(() {
      updateAllBoards();
      updateDailyCalendar();
      updateWeeklyCalendar();
    });
  }

  TextEditingController usernameController           = TextEditingController();
  TextEditingController emailController              = TextEditingController();
  TextEditingController phoneNumberController        = TextEditingController();
  TextEditingController aboutController              = TextEditingController();
  TextEditingController NewTaskDateController        = TextEditingController();
  TextEditingController NewTaskStartTimeController   = TextEditingController();
  TextEditingController NewTaskEndTimeController     = TextEditingController();
  TextEditingController taskNameController           = TextEditingController();
  TextEditingController newnHoldingDateController    = TextEditingController();
  TextEditingController newHoldingStartTimeController= TextEditingController();
  TextEditingController newHoldingEndTimeController  = TextEditingController();
  TextEditingController newBoardNameController       = TextEditingController();
  TextEditingController newBoardDescriptionController= TextEditingController();
  TextEditingController oldPasswordController        = TextEditingController();
  TextEditingController newPasswordController        = TextEditingController();
  ScrollController      eachBoardMembersController   = ScrollController();
  ScrollController      boardsController             = ScrollController();



  List dailyCalendarList = [];
  List weeklyCalendar = [];
  List todayBoards = [];
  List todayTasks = [];

  Widget _body = Scaffold(
    body: Container(
      child: Text("this is our home"),
    ),
  );
  final AssetImage _avatarImg = const AssetImage('assets/avatar.png');

  @override
  void initState() {
    super.initState();

    updateDailyCalendar();

    updateWeeklyCalendar();

    updateAllBoards();

    _items = _generateItems;
    _headline = _items?.firstWhere((item) => item.isSelected).text;
    DataProvider.profile(widget.pk).then((value) {
      username = value["username"];
      email = value["email"];
      pic = value["pic"];
      about = value["about"];
      phoneNumber = value["phoneNumber"];
      birthday = value["birthday"];
    });
    usernameController = TextEditingController(text: username);
    aboutController = TextEditingController(text: about);
    emailController = TextEditingController(text: email);
    phoneNumberController = TextEditingController(text: phoneNumber);
  }

  void updateDailyCalendar() {
    DataProvider.dailyCalendar(widget.pk).then((value) {
      dailyCalendarList = value;
      for (int j = 0 ; j < dailyCalendarList.length ; j++){
        todayTasks.add({"name" :dailyCalendarList[j]["name"], "is_done":dailyCalendarList[j]["is_done"] });
        if (dailyCalendarList[j]["boardName"] != null){
          if (!todayBoards.contains(dailyCalendarList[j]["boardName"])){
            todayBoards.add(dailyCalendarList[j]["boardName"]);
          }
        }
      }
    });
  }

  void updateWeeklyCalendar() {
    DataProvider.weeklyCalendar(widget.pk).then((value){
      weeklyCalendar = value ;
    });
  }

  void updateAllBoards() {
     DataProvider.allBoards(widget.pk).then((value){
      boardList = value ;
    });
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _body = _home( todayTasks , todayBoards)),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Boards',
        icon: Icons.tab,
        onPressed: () => setState(() => _body = _boards(reload)),
      ),
      CollapsibleItem(
        text: 'time_line',
        icon: Icons.event,
        onPressed: () => setState(() => _body = _timeLine()),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: DataProvider.profile(widget.pk),
      builder: (context , AsyncSnapshot<Map> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          return SafeArea(
        child: CollapsibleSidebar(
          isCollapsed: true,
          items: _items!,
          avatarImg: _avatarImg,
          title: username!,
          onTitleTap: () => setState(() {
            _body = Scaffold(
              body: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.3,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/avatar.png",
                                  fit: BoxFit.fill,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                              // Container(
                              //   height: 200,
                              //   width: 200,
                              //   child: Image(image: AssetImage("assets/avatar.png"),),
                              //   // width: MediaQuery.of(context).size.width*0.2,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle ,
                              //     color: Colors.red
                              //   ),
                              //   // child: Image.asset('assets/avatar.png'),
                              // ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 50,
                                child: RaisedButton(
                                  child: Text('Upload'),
                                  onPressed: () => {},
                                ),
                              )
                            ],
                          ),
                        ),
                        // Container(
    
                        // )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey[100],
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 30, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: const Text("Personal information:"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                                height: 50,
    
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 8),
                                      child: Icon(Icons.person,
                                          color:
                                              Color.fromARGB(255, 115, 138, 141)),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      child: TextField(
                                        controller: usernameController,
                                        decoration: InputDecoration.collapsed(
                                          hintText: username ?? "Name",
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                            child: Container(
                                height: 50,
    
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 8),
                                      child: Icon(Icons.calendar_month_outlined,
                                          color:
                                              Color.fromARGB(255, 115, 138, 141)),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      child: TextField(
                                        decoration: InputDecoration.collapsed(
                                          hintText: "Birth date",
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            child: Text("Contact information:"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                                height: 50,
    
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 8),
                                      child: Icon(Icons.email,
                                          color:
                                              Color.fromARGB(255, 115, 138, 141)),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      child: TextField(
                                        decoration: InputDecoration.collapsed(
                                          hintText: email ?? "E-mail",
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                            child: Container(
                                height: 50,
    
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 8),
                                      child: Icon(Icons.phone,
                                          color:
                                              Color.fromARGB(255, 115, 138, 141)),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      child: TextField(
                                        controller: phoneNumberController,
                                        decoration: InputDecoration.collapsed(
                                          hintText:
                                              phoneNumber ?? "Phone number ",
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            child: Text("About:"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                height: 50,
    
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.29,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 8),
                                      child: Icon(Icons.text_snippet_outlined,
                                          color:
                                              Color.fromARGB(255, 115, 138, 141)),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                      child: TextField(
                                        controller: aboutController,
                                        decoration: InputDecoration.collapsed(
                                          hintText: about ?? "About",
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.29,
                              height: 50,
                              child: RaisedButton(
                                child: Text('Change'),
                                onPressed: () async {
                                  await DataProvider.changeProfile(
                                          widget.pk,
                                          usernameController.text.isEmpty
                                              ? username
                                              : usernameController.text,
                                          birthday,
                                          emailController.text.isEmpty
                                              ? email
                                              : emailController.text,
                                          phoneNumberController.text.isEmpty
                                              ? phoneNumber
                                              : phoneNumberController.text,
                                          aboutController.text.isEmpty
                                              ? about
                                              : aboutController.text)
                                      .then((value) => {});
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child: Text("Password management:"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                                height: 50,
    
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.24,
                                child: Container(
                                  
                                  // padding:EdgeInsets.only(left: 15, right: 8),
                                  width: MediaQuery.of(context).size.width*0.2,
                                  child: 
                                  Padding(
                                    padding: const EdgeInsets.only(left:15.0),
                                    child: TextField(
                                      controller: oldPasswordController,
                                      decoration: InputDecoration(
                                        hintText: "old password"
                                      ),
                                    ),
                                  )
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                width: MediaQuery.of(context).size.width * 0.24,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 8),
                                      child: Icon(Icons.text_snippet_outlined,
                                          color:
                                              Color.fromARGB(255, 115, 138, 141)),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.19,
                                      child: TextField(
                                        controller:newPasswordController,
                                        decoration: InputDecoration.collapsed(
                                          hintText: "New password",
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.24,
                              height: 50,
                              child: RaisedButton(
                                child: Text('Change'),
                                onPressed: ()async{
                                  print("in change");
                                  await DataProvider.changePassword(widget.pk , oldPasswordController.text , newPasswordController.text).then((value){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value["msg"])));
                                  });
                                  oldPasswordController.clear();
                                  newPasswordController.clear();
    
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
            );
          }),
          // body: _body(size, context),
          body: _body,
          backgroundColor: Colors.black,
          selectedTextColor: Colors.limeAccent,
          textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          titleStyle: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          toggleTitleStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          sidebarBoxShadow: const [
            BoxShadow(
              color: Colors.indigo,
              blurRadius: 20,
              spreadRadius: 0.01,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: Colors.green,
              blurRadius: 50,
              spreadRadius: 0.01,
              offset: Offset(3, 3),
            ),
          ],
        ),
      );
      }else{
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
      }
  );
  }

  // Widget _body(Size size, BuildContext context) {
  //   return Container(
  //     height: double.infinity,
  //     width: double.infinity,
  //     color: Colors.blueGrey[50],
  //     child: Center(
  //       child: Transform.rotate(
  //         angle: math.pi / 2,
  //         child: Transform.translate(
  //           offset: Offset(-size.height * 0.3, -size.width * 0.23),
  //           child: Text(
  //             _headline!,
  //             style: Theme.of(context).textTheme.headline1,
  //             overflow: TextOverflow.visible,
  //             softWrap: false,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _home(List todayTasks , List todayBoards) {
    int _selectedBoard = -1;
    final List<String> boards = [
      // "network",
      // "compiler",
      // "network",
      // "compiler",
      // "network",
      // "compiler"
    ];
    final List<String> tasks = [
      // "hw1 network", "project compiler"
      ];
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
                            dataSource: MeetingDataSource(
                                _getDataSource(widget.pk, dailyCalendarList)),
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
                                  itemCount: todayBoards.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      // style: ListTileStyle(),
                                      title: Text(todayBoards[index]),
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
                                  itemCount: todayTasks.length,
                                  itemBuilder: (context, index) {
                                    print("here we are");
                                    print(todayTasks);
                                    return ListTile(
                                      title: Text(todayTasks[index]["name"]),
                                      onTap: (){

                                      },
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
                                  TextField(
                                    controller: taskNameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Task name '),
                                  ),
                                  DateTimePicker(
                                    controller: NewTaskDateController,
                                    // initialValue: '',
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
                                    controller: NewTaskStartTimeController,
                                    // initialValue: '',
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
                                    controller: NewTaskEndTimeController,
                                    // initialValue: '',
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
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 20),
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
                                      )),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      onPressed: () async {
                                        await DataProvider.addTaskDailyCalendar(
                                            widget.pk,
                                            taskNameController.text,
                                            NewTaskStartTimeController.text,
                                            NewTaskEndTimeController.text,
                                            NewTaskDateController.text);
                                            setState((){
                                              print("in set state");
                                              reload();
                                            });
                                            Navigator.pop(context,true);

                                      },
                                      child: const Text(
                                        "ADD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
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
            child: const Center(
                child: Text(
              "+",
              style: TextStyle(fontSize: 30),
            )),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _boards(reload) {
    List<String> members = [];
    List<String> times = [];
    TextEditingController _controller = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.05,
              child: RaisedButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          backgroundColor: Colors.lightBlue[50],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                        child: Text(
                                      "Adding new board",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  TextField(
                                    controller: newBoardNameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Board name"),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20)),
                                  TextField(
                                    controller: newBoardDescriptionController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "description"),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20)),
                                  TextField(
                                    controller: _controller,
                                    onSubmitted: (value) => setState(() => {
                                          members.add(value),
                                          _controller.clear()
                                        }),
                                    textInputAction: TextInputAction.go,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Add members email/username"),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 20)),
                                  SizedBox(
                                    height: 60,
                                    // width: 200,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: members.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Center(
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(members[index]),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 184, 181, 181),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  RaisedButton(
                                      shape: RoundedRectangleBorder(),
                                      color: Colors.green[100],
                                      child: Text("Pick weekly scheduled time"),
                                      onPressed: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                         return AlertDialog(
                                            backgroundColor:Colors.lightBlue[50],
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            content: StatefulBuilder(builder: (context, setState2) {
                                              return Container(
                                                // color: Colors.red,
                                                // width: MediaQuery.of(context).size.width*0.3,
                                                height: MediaQuery.of(context).size.height*0.4,
                                                child: Column(
                                                  children: [
                                                    DateTimePicker(
                                    controller: newnHoldingDateController,
                                    // initialValue: '',
                                    type: DateTimePickerType.date,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'Scheduled Date',
                                    // timeLabelText: 'Start time',
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      // print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                  DateTimePicker(
                                    controller: newHoldingStartTimeController,
                                    // initialValue: '',
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
                                    controller: newHoldingEndTimeController,
                                    // initialValue: '',
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
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:20.0),
                                                            child: RaisedButton(
                                                              color: Colors.green,
                                                              child: Text("save"),
                                                              onPressed: (){
                                                                
                                                                setState(() {
                                                                  String text = "day: " + newnHoldingDateController.text + ", startTime: " + newHoldingStartTimeController.text + ", endTime: " + newHoldingEndTimeController.text ;
                                                                times.add(text);
                                                                print("scheduled :");
                                                                print(text);
                                                                newnHoldingDateController.clear();
                                                                newHoldingStartTimeController.clear();
                                                                newHoldingEndTimeController.clear();
                                                                Navigator.pop(context, true);
                                                                });
                                                              
                                                              }
                                                              ),
                                                          )
                                                  ],
                                                ),

                                              );
                                            }));});
                                        
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height*0.15,
                                      // width: 200,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: times.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(times[index]),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 184, 181, 181),
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                  RaisedButton(
                                    child: Text("Create"),
                                    color: Colors.green,
                                    onPressed: ()async{
                                      
                                      await DataProvider.addNewBoard(widget.pk, newBoardNameController.text, members, times , newBoardDescriptionController.text);
                                      setState((){
                                        times.clear();
                                        members.clear();
                                        newBoardNameController.clear();
                                        newBoardDescriptionController.clear();
                                        Navigator.pop(context);
                                        reload();
                                      });
                                    })
                                ],
                              ),
                            );
                          }));
                    }),
                child: const Text("Create new Board +"),
              ),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //     borderRadius: BorderRadius.circular(20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Your boards : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              child: GridView.builder(
                controller: boardsController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: boardList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SingleBoard(pk :boardList[index]["pk"] , personpk: widget.pk,)))
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          // color: boardList[index].background,
                          // color: Colors.red[200],
                          color: Color.fromARGB(255, 57, 226, 248),
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(boardList[index]["boardName"] , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),) ,
                          Text("description: " + ( boardList[index]["description"] == null? "": boardList[index]["description"] ) ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("members:"),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.1,
                                  height: 30,
                                  child: ListView.builder(
                                    controller: eachBoardMembersController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (boardList[index]["members"].length),
                                    itemBuilder: (BuildContext context, int i){
                                      return Text((boardList[index]["members"][i]) + ", ");
                                    }),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _timeLine() {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: SfCalendar(
            view: CalendarView.week,
            // onSelectionChanged: ,
            // onTap: showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         int _selectedBoard = -1;
            //         return AlertDialog()}
            // ),
            firstDayOfWeek: 6,
            dataSource:
                MeetingDataSource(_getDataSourceWeek(widget.pk, weeklyCalendar)),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        ),
      ),
    );
  }

  Widget _Notification() {
    return Scaffold(
      body: Container(
        child: Text("this is notification page"),
      ),
    );
  }
}

List<Meeting> _getDataSource(int pk, List dailyCalendarList) {
  List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  print("dailycalendar in getdatasource");
  for (int i = 0; i < dailyCalendarList.length; i++) {
    String start_hour = dailyCalendarList[i]["startTime"][0] +
        dailyCalendarList[i]["startTime"][1];
    String start_minute = dailyCalendarList[i]["startTime"][3] +
        dailyCalendarList[i]["startTime"][4];
    String end_hour =
        dailyCalendarList[i]["endTime"][0] + dailyCalendarList[i]["endTime"][1];
    String end_minute =
        dailyCalendarList[i]["endTime"][3] + dailyCalendarList[i]["endTime"][4];

    final DateTime startTime = DateTime(today.year, today.month, today.day, int.parse(start_hour), int.parse(start_minute), 0);
    final DateTime endTime = DateTime(today.year, today.month, today.day,int.parse(end_hour), int.parse(end_minute), 0);
    print("StartTime is:");
    print(startTime);
    print("endTime is:");
    print(endTime);
    meetings.add(Meeting(dailyCalendarList[i]["name"], startTime, endTime,
        const Color(0xFF0F8644), false));
  }

  // final DateTime endTime = startTime.add(const Duration(hours: 2));
  // meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), true));
  // meetings.add(Meeting('dentist', startTime, endTime, Color.fromARGB(255, 14, 40, 128), true));
  return meetings;
}

List<Meeting> _getDataSourceWeek(int pk, List dailyCalendarList) {
  List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  print("dailycalendar in getdatasource");
  for (int i = 0; i < dailyCalendarList.length; i++) {
    String start_hour = dailyCalendarList[i]["startTime"][0] +
        dailyCalendarList[i]["startTime"][1];
    String start_minute = dailyCalendarList[i]["startTime"][3] +
        dailyCalendarList[i]["startTime"][4];
    String end_hour =
        dailyCalendarList[i]["endTime"][0] + dailyCalendarList[i]["endTime"][1];
    String end_minute =
        dailyCalendarList[i]["endTime"][3] + dailyCalendarList[i]["endTime"][4];

    // final DateTime startTime = DateTime(today.year, today.month, today.day, int.parse(start_hour), int.parse(start_minute), 0);
    // final DateTime endTime = DateTime(today.year, today.month, today.day, int.parse(end_hour), int.parse(end_minute), 0);

    
    final DateTime startTime = DateTime( DateTime.parse(dailyCalendarList[i]["day"]).year, DateTime.parse(dailyCalendarList[i]["day"]).month, DateTime.parse(dailyCalendarList[i]["day"]).day, int.parse(start_hour), int.parse(start_minute), 0);
    final DateTime endTime = DateTime(DateTime.parse(dailyCalendarList[i]["day"]).year, DateTime.parse(dailyCalendarList[i]["day"]).month, DateTime.parse(dailyCalendarList[i]["day"]).day, int.parse(end_hour), int.parse(end_minute), 0);

    print("StartTime is:");
    print(startTime);
    print("endTime is:");
    print(endTime);
    meetings.add(Meeting(dailyCalendarList[i]["name"], startTime, endTime,
        const Color(0xFF0F8644), false));
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
