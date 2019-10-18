class Responsibles {
  String _codigo;
  String _nome;

  Responsibles(this._codigo, this._nome);

  String get codigo => _codigo;

  String get nome => _nome;

  set codigo(String newCodigo) {
    this._codigo = newCodigo;
  }

  set nome(String newNome) {
    this._nome = newNome;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['codigo'] = _codigo;
    map['nome'] = _nome;
    return map;
  }

  Responsibles.fromMapObject(Map<String, dynamic> map) {
    this._codigo = map['codigo'].toString();
    this._nome = map['nome'];
  }
}
