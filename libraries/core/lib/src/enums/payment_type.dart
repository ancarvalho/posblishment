//TODO maybe change to a table
enum PaymentType {
  creditCard(name: "Cartão de Credito", value: "credit-card"),
  debitCard(name: "Cartão de Debito", value: "debit-card"),
  cash(name: "Dinheiro", value: "cash"),
  pix(name: "PIX", value: "pix");

  const PaymentType({required this.name, required this.value});
  final String name;
  final String value;
}
