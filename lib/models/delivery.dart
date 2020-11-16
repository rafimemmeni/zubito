
class Delivery {
  String id;
  String location;
  String charge;

  Delivery(
      {this.id,
      this.location,
      this.charge
      });

  Delivery.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    location = data['location'];
    charge = data['charge'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'charge': charge
    };
  }
}
