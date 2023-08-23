class CurrentRoute {
  final String route;
  final String routeName;

  CurrentRoute({this.route = "/", this.routeName = "Splash"});

    static CurrentRoute fromMap(dynamic map) {
    return CurrentRoute(
      route: map["route"],
      routeName: map["route_name"],
     
    );
  }
    static Map<String, dynamic> toJson(CurrentRoute establishment) {
    return {
      "route": establishment.route,
      "route_name": establishment.routeName,

    };
  }
}
