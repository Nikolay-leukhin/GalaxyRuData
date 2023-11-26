part of '../api_service.dart';

enum MethodsEnum { get, post, delete, update, put }

const Map methods = {
  MethodsEnum.get: 'GET',
  MethodsEnum.post: 'POST',
  MethodsEnum.delete: 'DELETE',
  MethodsEnum.update: 'UPDATE',
  MethodsEnum.put: 'PUT',
};
