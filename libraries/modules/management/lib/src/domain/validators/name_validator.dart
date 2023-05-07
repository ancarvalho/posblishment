String? validateNome(String? value) {
  if (value == null || value.isEmpty || value.length < 6) {
    return 'Invalid Name';
  }

  return null;
}
