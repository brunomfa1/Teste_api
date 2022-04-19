import 'package:dio/dio.dart';
import 'package:teste_api/src/model/Todo.dart';


class TodoRepository{
  final dio = Dio();
  final url = 'https://jsonplaceholder.typicode.com/todos';


  

  Future<List<TodoModel>> obterTodos() async {

    final response = await dio.get(url);
    //CONVERTENDO PARA JSON 
    final list = response.data as List;
    // DADOS JSON PARA UMA LISTA DO TIPO 'TODO'
    return list.map((json) => TodoModel.fromJson(json)).toList();
  }
}