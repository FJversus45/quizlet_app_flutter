import 'package:flutter/foundation.dart';

class Endpoints {
  static const baseUrl =
      kDebugMode
          // ? "https://todo-app-vxgd.onrender.com"
          // : "https://todo-app-vxgd.onrender.com";
          ? "https://todo-app-graphql.onrender.com/graphql"
          : "https://todo-app-graphql.onrender.com/graphql";

  static const register = '/auth/register';
  static const login = '/auth/login';
  static const createTodo = '/todo-features/createtodo';
  static const updateTodo = '/todo-features/updatetodo';
  static const deleteTodo = '/todo-features/deletetodo';
  static const viewTodo = '/todo-features/viewtodo';
  static const viewAllTodo = '/todo-features/viewalltodo';
}
