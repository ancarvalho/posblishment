String? validateID(String? value) {
  if (value == null || value.isEmpty || value.length != 36) {
    return "Invalid Category";
  }

  return null;
}
