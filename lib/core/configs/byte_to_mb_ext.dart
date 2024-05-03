extension BytesExtension on int {
  String toMegabytes() {
    if (this <= 0) return "0 MB";

    const int megabyte = 1024 * 1024;
    double mb = this / megabyte;

    // Round the result to two decimal places
    mb = double.parse((mb).toStringAsFixed(2));

    return "$mb MB";
  }
}
