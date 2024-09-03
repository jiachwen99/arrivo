class ValidationHelper {
  //===========================================================//
  //                 Validation For Empty
  //===========================================================//
  static validateNotEmpty(dynamic value, [String label=""]) {
    final thisLabel = (label == "") ? "This field" : label;
    if (value == null || value == "") {
      return "$thisLabel is required";
    }
    return null;
  }

  //===========================================================//
  //               Validation For Email
  //===========================================================//
  static validateEmail(String value, [String label=""]) {
    String patttern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(patttern);
    final thisLabel = (label == "") ? "This field" : label;

    if ((value.isEmpty)) {
      return "$thisLabel is required";
    } 
    else if (!(regExp.hasMatch(value))){
      return "$thisLabel is invalid";
    }
    else {
      return null;
    }
  }
}