

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/constants/constants.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


// ignore: must_be_immutable
class HomeLayout extends StatelessWidget
{


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
       listener: (context, state) {
         if(state is AppInsertDatabaseState){
           Navigator.pop(context);
         }
       },
       builder: (context, state){
         AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).titles[cubit.currentIndex],
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(

              condition: state is! AppGetDatabaseLoadingState,
            builder: (context) =>cubit.screens[cubit.currentIndex],
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(


            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertDatabase(title: titleController.text,
                      time: timeController.text,
                      date: dateController.text
                  );

                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField
                            (
                            focusedBorderColor:firstColor ,
                            enabledBorderColor: firstColor,
                            context: context,
                            controller: titleController,
                            type: TextInputType.text,
                            keyboardType: TextInputType.text,

                            validate: (value) {
                              if (value.isEmpty) {
                                return "title must Not be Empty!!";
                              }
                              return null;
                            },
                            label: "Task Title",
                            prefix: Icons.title, fillColor: firstColor,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            enabledBorderColor: firstColor,
                            focusedBorderColor: firstColor,
                            fillColor: firstColor,
                            context: context,
                            controller: timeController,
                            keyboardType: TextInputType.datetime,
                            type: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                timeController.text = value!.format(context).toString();

                                print(value.format(context));
                              });
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return "Time must Not be Empty!!";
                              }
                              return null;
                            },
                            label: "Task time",
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField
                            (

                            context: context,
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2030-10-15')).then((value) {
                                dateController.text = DateFormat.yMMMd().format(value!);
                              });
                            },

                            validate: (value) {
                              if (value.isEmpty) {
                                return "Time must Not be Empty!!";
                              }
                              return null;
                            },
                            label: "Task date",
                            prefix: Icons.calendar_today, focusedBorderColor: firstColor, enabledBorderColor: firstColor, fillColor: firstColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 15,
                )
                    .closed
                    .then((value) {
                      cubit.changeBottomSheetState(
                        isShow: false,
                        icon:Icons.add,
                      );
                  //isBottomSheetShown = false;
                  // setState(() {
                  // fabIcon = Icons.edit;
                  // });
                  //
                });
                cubit.changeBottomSheetState(
                  isShow: true,
                  icon:Icons.edit,
                );
                //isBottomSheetShown = true;
                // setState(() {
                // fabIcon = Icons.add;
                // });

              }
            },

            //   try{
            //    var name = await getName();
            //    print(name);
            //    print('osama');
            //   throw('some errorrr');
            //  } catch(error)
            // {
            //   print('error ${error.toString()}');
            // }

            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
            items:  [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(

                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Done',

              ),
              BottomNavigationBarItem(
                icon: Icon(

                  Icons.archive_outlined,
                ),
                label: 'Archive',
              ),
            ],
          ),
        );
      },
      ),
    );
  }


}
