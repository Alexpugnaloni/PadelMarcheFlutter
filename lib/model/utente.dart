class Utente{
  String email;
  String nome;
  String cognome;
  String datadinascita;
  String cellulare;
  String sesso;

  Utente({
    required this.email,
    required this.nome,
    required this.cognome,
    required this.datadinascita,
    required this.cellulare,
    required this.sesso,
});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'datadinascita': datadinascita,
      'cellulare': cellulare,
      'sesso': sesso,
    };
  }
  static Utente fromMap(Map<String, Object?> json) => Utente(
    email: json['email'] as String,
    nome: json['nome'] as String,
    cognome: json['cognome'] as String,
    datadinascita: json['datadinascita'] as String,
    cellulare: json['cellulare'] as String,
    sesso: json['sesso'] as String,
  );
}