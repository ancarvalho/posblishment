enum ThemesOptions {
  dark(name: "Dark", value: "dark-theme"),
  solarizedDark(name: "Solarized Dark", value: "solarized-dark-theme"),
  solarizedLight(name: "Solarized Light", value: "solarized-light-theme"),
  light(name: "Light", value: "light-theme");

  const ThemesOptions({required this.name, required this.value});

  final String name;
  final String value;
}
