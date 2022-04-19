import 'package:flutter/cupertino.dart';
import 'package:teste_api/src/model/Todo.dart';


import 'package:teste_api/src/repositories/todo_repository.dart';

class HomeController{

  List<TodoModel> todos = [];
  var  repository = TodoRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future<List<TodoModel>> getAll() async{

    return repository.obterTodos();
  }

  Future start() async{
    state.value = HomeState.loading;
    try {
      todos = (await repository.obterTodos()).cast<TodoModel>();
      state.value = HomeState.sucess;
    } catch (e) {
      state.value = HomeState.error;
    }
    state.value = HomeState.sucess;
  }
}

enum HomeState {start,loading,sucess,error}