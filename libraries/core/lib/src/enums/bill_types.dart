enum BillTypes {
  percentageTax(name: "Porcentagem", value: "percentage-tax", ),
  fixedTax(name: "Taxa de Entrega", value: "fixed-tax",),
  withoutTax(name: "Sem Taxa", value: "without-tax", );

  const BillTypes({required this.name, required this.value});

  final String name;
  final String value;

}
