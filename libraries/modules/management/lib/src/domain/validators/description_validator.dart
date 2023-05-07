String? validateDescription(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  if (value.length < 6) {
    return "Description too small";
  }

  return null;
}
