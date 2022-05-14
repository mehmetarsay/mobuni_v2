import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class QuestionService {
  List<QuestionModel>? questions = [
    QuestionModel(
      id: 1,
      userId: '1',
      createdTime: DateTime.now(),
      universityId: 2,
      text: '🌟Mobuni için ikinci faz çalışmaları başlamıştır,🌟 Bu çalışmalara katıldıkları için 👉🏿@FatihDursunUzer \n👉🏿@BilalÖzcan\n teşekkürlerimi\n sunuyorum. Burdan Fatih gayberiye selam söylüyorum',
      image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),
    QuestionModel(
        id: 1,
        userId: '1',
        createdTime: DateTime.now(),
        universityId: 2,
        text: 'Mobuni için ikinci faz çalışmaları başlamıştır',
        image: 'https://ogimgs.apkcombo.org/eyJsb2dvIjoiaHR0cHM6Ly9wbGF5LWxoLmdvb2dsZXVzZXJjb250ZW50LmNvbS9oM3gtOFAwSnpZNFRScTNVUDVCSDBRQnp6V2ZPUkVVSkhHSHZZeXB0WDJXNUdQWmxoTHNXVi1HQUZ5MGE4V3l4T0c3bj1zMjAwIiwidGl0bGUiOiAi2KrYrdmF2YrZhCBNb2JVbmkgQVBLIn0=/thmyl-mobuni-apk'
    ),

  ];
}
