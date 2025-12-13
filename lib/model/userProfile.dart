class Userprofile {
    int? id;
    String? firstName;
    String? lastName;
    String? maidenName;
    int? age;
    String? gender;
    String? email;
    String? phone;
    String? username;
    String? password;
    String? birthDate;
    String? image;
    String? bloodGroup;
    double? height;
    double? weight;
    String? eyeColor;
    Hair? hair;
    String? ip;
    Address? address;
    String? macAddress;
    String? university;
    Bank? bank;
    Company? company;
    String? ein;
    String? ssn;
    String? userAgent;
    Crypto? crypto;
    String? role;

    factory Userprofile.fromJson(Map<String, dynamic> json) {
      return Userprofile(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        maidenName: json['maidenName'],
        age: json['age'],
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        username: json['username'],
        password: json['password'],
        birthDate: json['birthDate'],
        image: json['image'],
        bloodGroup: json['bloodGroup'],
        height: json['height'].toDouble(),
        weight: json['weight'].toDouble(),
        eyeColor: json['eyeColor'],
        hair: Hair.fromJson(json['hair']),
        ip: json['ip'],
        address: Address.fromJson(json['address']),
        macAddress: json['macAddress'],
        university: json['university'],
        bank: Bank.fromJson(json['bank']),
        company: Company.fromJson(json['company']),
        ein: json['ein'],
        ssn: json['ssn'],
        userAgent: json['userAgent'],
        crypto: Crypto.fromJson(json['crypto']),
        role: json['role'],
      );
    }

    Userprofile({
      this.id,
      this.firstName,
      this.lastName,
      this.maidenName,
      this.age,
      this.gender,
      this.email,
      this.phone,
      this.username,
      this.password,
      this.birthDate,
      this.image,
      this.bloodGroup,
      this.height,
      this.weight,
      this.eyeColor,
      this.hair,
      this.ip,
      this.address,
      this.macAddress,
      this.university,
      this.bank,
      this.company,
      this.ein,
      this.ssn,
      this.userAgent,
      this.crypto,
      this.role,
    });


}

class Address {
    String? address;
    String? city;
    String? state;
    String? stateCode;
    String? postalCode;
    Coordinates? coordinates;
    String? country;

    factory Address.fromJson(Map<String, dynamic> json) {
      return Address(
        address: json['address'],
        city: json['city'],
        state: json['state'],
        stateCode: json['stateCode'],
        postalCode: json['postalCode'],
        coordinates: Coordinates.fromJson(json['coordinates']),
        country: json['country'],
      );
    }

    Address({
      this.address,
      this.city,
      this.state,
      this.stateCode,
      this.postalCode,
      this.coordinates,
      this.country,
    });

}

class Coordinates {
    double? lat;
    double? lng;

    factory Coordinates.fromJson(Map<String, dynamic> json) {
      return Coordinates(
        lat: json['lat'].toDouble(),
        lng: json['lng'].toDouble(),
      );
    }

    Coordinates({
      this.lat,
      this.lng,
    });

}

class Bank {
    String? cardExpire;
    String? cardNumber;
    String? cardType;
    String? currency;
    String? iban;

    factory Bank.fromJson(Map<String, dynamic> json) {
      return Bank(
        cardExpire: json['cardExpire'],
        cardNumber: json['cardNumber'],
        cardType: json['cardType'],
        currency: json['currency'],
        iban: json['iban'],
      );
    }

    Bank({
      this.cardExpire,
      this.cardNumber,
      this.cardType,
      this.currency,
      this.iban,
    });

}

class Company {
    String? department;
    String? name;
    String? title;
    Address? address;

    factory Company.fromJson(Map<String, dynamic> json) {
      return Company(
        department: json['department'],
        name: json['name'],
        title: json['title'],
        address: Address.fromJson(json['address']),
      );
    }

    Company({
      this.department,
      this.name,
      this.title,
      this.address,
    });

}

class Crypto {
    String? coin;
    String? wallet;
    String? network;

    factory Crypto.fromJson(Map<String, dynamic> json) {
      return Crypto(
        coin: json['coin'],
        wallet: json['wallet'],
        network: json['network'],
      );
    }

    Crypto({
      this.coin,
      this.wallet,
      this.network,
    });

}

class Hair {
    String? color;
    String? type;

    factory Hair.fromJson(Map<String, dynamic> json) {
      return Hair(
        color: json['color'],
        type: json['type'],
      );
    }

    Hair({
      this.color,
      this.type,
    });

}