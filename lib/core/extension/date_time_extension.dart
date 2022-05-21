import 'package:date_format/date_format.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime {
  String get formatDateToTime => formatDate(
        this,
        [HH, ':', nn],
        locale: TurkishDateLocale(),
      );
  String get customFormatDate => formatDate(
        this,
        [dd, ' ', MM, ' ', yyyy, '  ', HH, ':', nn],
        locale: TurkishDateLocale(),
      );
  String get customFormatDate2 => formatDate(
        this,
        [dd, ' ', MM, ' ', yyyy],
        locale: TurkishDateLocale(),
      );

  String get customFormatDate3 => formatDate(
        this,
        [dd, '.', mm, '.', yyyy],
        locale: TurkishDateLocale(),
      );
      
  String get customFormatDate4 => timeago.format(this);
}
