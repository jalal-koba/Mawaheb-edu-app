bool boolConverter(dynamic value) {
  
  
  return value == 1 ||
          value == '1' ||
          value == 'yes' ||
          value == 'Yes' ||
          value == 'YES' ||
          value == 'ok' ||
          value == 'Ok' ||
          value == 'OK' ||
          value == 'true' ||
          value == true
      ? true
      : false;
}
