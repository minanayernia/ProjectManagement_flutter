import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_taskmanagement/data_provider.dart';

Future<dynamic>? handleClick(String value , context) {
  TextEditingController _controller = TextEditingController();
  List members = [] ;
    switch (value) {
      case 'Add member':
        return showDialog(context: context, 
                      builder:(BuildContext context){
                        return AlertDialog(
                          backgroundColor: Colors.lightBlue[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            content: StatefulBuilder(
                              builder: (context, setState){
                                return Container(
                                  child: Column(
                                    children: [
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
                                    ],
                                  ),
                                );
                              } 
                              )
                          );
                      } 
                      );
      case 'Delete board':
        break;
    }
}

// List<String> lists = ["list1" , "list2" , "list2" , "list2" , "list2" , "list2" , "list2" , "list2" , ];

class SingleBoard extends StatefulWidget {
  final int? pk ;
  final int? personpk;
  const SingleBoard({@required this.pk , @required this.personpk});
  

  @override
  _SingleBoardState createState() => _SingleBoardState();
}

class _SingleBoardState extends State<SingleBoard> {
  String boardName = "" ;
  List members = [] ;
  List lists = [] ;
  TextEditingController listNameController = TextEditingController();
  TextEditingController listDescriptionControler = TextEditingController();



  @override
  void initState(){
    DataProvider.singleBoard(widget.pk).then((value){
    boardName = value["boardName"];
    print("board name");
    print(boardName);
    members = value["members"];
    lists = value["lists"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(boardName);
    return FutureBuilder(
      future: DataProvider.singleBoard(widget.pk),
      builder: (context , AsyncSnapshot<Map> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          return Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data!["boardName"]),
            backgroundColor: Color.fromARGB(255, 44, 148, 161,),
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  onSelected: handleClick;
                  return {'Add member', 'Delete board'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                )
            ],
            ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              // width: MediaQuery.of(context).size.width*9,
              height: MediaQuery.of(context).size.height*95,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Container(
                      height: MediaQuery.of(context).size.height*95,
                      width: MediaQuery.of(context).size.width,   
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!["lists"].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              
                            },
                            child: ListCard(personPk : widget.personpk ,listPk:snapshot.data!["lists"][index]["listPk"] ,Listname: snapshot.data!["lists"][index]["listName"],tasks: snapshot.data!["lists"][index]["tasks"] , members :snapshot.data!["members"]));
                        }),
                    ),
                    // ListCard()
                  ],
                ),
              ),
            ),

          ),
          floatingActionButton: Container(

                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed:(){
                      showDialog(context: context, 
                      builder:(BuildContext context){
                        return AlertDialog(
                          backgroundColor: Colors.lightBlue[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            content: StatefulBuilder(
                              builder: (context, setState){
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Column(
                                    children: [
                                      Padding(padding: EdgeInsets.all(10) , 
                                        child:TextField(
                                          controller: listNameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "list name"),
                                         ) ,),
                                         Padding(padding: EdgeInsets.all(10) , 
                                        child:TextField(
                                          controller: listDescriptionControler,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "description"),
                                         ) ,),
                                         Container(
                                           padding: EdgeInsets.only(top: 20),
                                           width: MediaQuery.of(context).size.width*0.15,
                                           child: RaisedButton(
                                             color: Colors.green,
                                             child: Text("Add"),
                                             onPressed: ()async{
                                               await DataProvider.addNewList(widget.pk, listNameController.text, listDescriptionControler.text);
                                               listNameController.clear();
                                               listDescriptionControler.clear();
                                               Navigator.pop(context , true);
                                             }),
                                         )
                                    ],
                                  ),
                                );
                              } 
                              )
                          );
                      } 
                      );
                    },
                    child: Center(child: Text("New\nList"),),
                     
                  ),
                ),
              ),
        );
        }else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
      }
    );
  }
}

// List members = ["mina" , "zahra" , "mitra"];

class ListCard extends StatefulWidget {
  final String Listname ;
  final int? personPk;
  final int listPk ;
  final List tasks ;
  final List members ;
  const ListCard({ Key? key  , required this.personPk, required this.Listname , required this.tasks , required this.members , required this.listPk}) : super(key: key);
  
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  TextEditingController taskNameControler = TextEditingController();
  TextEditingController taskDescriptionControler = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  List addedMembers = [] ;

  @override
  Widget build(BuildContext context) {
    print("personpk is:");
    print(widget.personPk);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*0.9,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.all(10),
                  child: Text(widget.Listname),),
                  Icon(Icons.edit)
                ],
              ),
              
              Container(
                height: MediaQuery.of(context).size.height*0.77,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListView.builder(
                  itemCount: widget.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(widget.tasks[index]["taskName"]);
                  })),
              Container(
                width: 200,
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  onPressed: () {
                    showDialog(context: context, 
                    builder: (BuildContext context){
                      return AlertDialog(
                        backgroundColor: Colors.lightBlue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          content: StatefulBuilder(
                            builder: (context, setState){
                              return Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.height*0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: taskNameControler,
                                      decoration: InputDecoration(
                                        hintText: "task name",
                                        border: OutlineInputBorder()
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    TextField(
                                      controller: taskDescriptionControler,
                                      decoration: InputDecoration(
                                        hintText: "task description",
                                        border: OutlineInputBorder()
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),

                                    DateTimePicker(
                                      controller: dateController,
                                      // initialValue: '',
                                      type: DateTimePickerType.date,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      dateHintText: "date",
                                    ),

                                    Padding(padding: EdgeInsets.only(top: 10)),

                                    DateTimePicker(
                                      controller: startTimeController,
                                      // initialValue: '',
                                      type: DateTimePickerType.time,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      // dateHintText: "date",
                                      timeHintText: "Start time",
                                      
                                    ),

                                    Padding(padding: EdgeInsets.only(top: 10)),

                                    DateTimePicker(
                                      controller: endTimeController,
                                      // initialValue: '',
                                      type: DateTimePickerType.time,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      // dateHintText: "date",
                                      timeHintText: "End time",
                                    ),

                                    Padding(padding: EdgeInsets.only(top:20 , bottom: 10),
                                      child: Text("Members :" , style: TextStyle(fontWeight: FontWeight.w400),),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      // width: 200,
                                      child: SingleChildScrollView(
                                        child: Wrap(
                                          spacing: 10,
                                          runSpacing: 8,
                                          children: List.generate(
                                              widget.members.length,
                                              (index) => Container(
                                                    decoration: BoxDecoration(
                                                        color: addedMembers.contains(widget.members[index]["pk"]) ? Colors.green : Colors.grey,
                                                        borderRadius:
                                                            BorderRadius.circular(10)),
                                                    child: InkWell(
                                                      onTap: () => setState(() {
                                                        // _selectedBoard = index;
                                                        // print(_selectedBoard);
                                                        if (addedMembers.contains(widget.members[index]["pk"]) ){
                                                          addedMembers.remove(widget.members[index]["pk"]);
                                                        }else{
                                                          addedMembers.add(widget.members[index]["pk"]);
                                                        }
                                                      }),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(10),
                                                        child: Text(
                                                            widget.members[index]["name"].toString()),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      )
                                      ),
                                      Center(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.15,
                                          child: RaisedButton(
                                            color: Colors.green,
                                            onPressed:()async{
                                              await DataProvider.addNewTask(widget.personPk ,widget.listPk, taskNameControler.text, taskDescriptionControler.text, dateController.text, startTimeController.text, endTimeController.text, addedMembers);
                                              print("why not working");
                                              taskDescriptionControler.clear();
                                              taskDescriptionControler.clear();
                                              dateController.clear();
                                              startTimeController.clear();
                                              endTimeController.clear();
                                              addedMembers.clear();
                                              Navigator.pop(context, true);
                                            },
                                            child: Text("Add task"), ),
                                        ),
                                      )
                                      
                                  ],
                                ),
                              );
                            },
                          ),
                      );
                    });
                  },
                  child: Text("+ Add new task"),
                ),
              )
            ],
          ),
        ),
        
      ),
    );
  }
}
// List<String> tasks = ["task1" , "python" , "python" , "python" , "python" , "python" , "python" , "python" , "python" , "python" , "python" , "python" , "python"];

class TaskCard extends StatefulWidget {
  const TaskCard(this.taskName);
  final String taskName ;

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),

          ),
          height: 70,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.taskName),
              ),
              // Icon(Icons.edit)
            ],
          ),
        ),
      ),
    );
  }
}

