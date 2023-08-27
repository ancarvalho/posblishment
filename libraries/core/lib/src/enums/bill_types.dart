enum BillTypes {
  percentageTax(name: "Porcentagem", value: "percentage-tax"),
  deliveryTax(name: "Taxa de Entrega", value: "delivery-tax"),
  withoutTax(name: "Sem Taxa", value: "without-tax");

  const BillTypes({required this.name, required this.value});

  final String name;
  final String value;
}
