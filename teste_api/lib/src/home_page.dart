import 'package:flutter/material.dart';
import 'package:teste_api/src/controller/home_controller.dart';
import 'package:teste_api/src/model/Todo.dart';
import 'package:teste_api/src/repositories/todo_repository.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final controller = HomeController();

  _sucess() {
    return FutureBuilder<List<TodoModel>>(
        future: controller.getAll(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting)
            return Center(child:  CircularProgressIndicator(),);
          return ListView.builder(
              itemCount: data.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(data.data![index].id.toString()),
                  subtitle: Text(data.data![index].title.toString()),
                );
              });
        });
  }

  _error() {
    return Center(
      child: TextButton(
        onPressed: () {
          controller.start();
        },
        child: Text('Tentar Novamente'),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.sucess:
        return _sucess();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Lista Todos'),
        ),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}
