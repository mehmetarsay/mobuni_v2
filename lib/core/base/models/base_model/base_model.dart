abstract class BaseModel<T> {
  Map<String, T> toJson();
  T fromJson(Map<String, dynamic> json);
}
