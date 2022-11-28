
class User {
  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });
  late final String id;
  late final String name;
  late final String imageUrl;
  late final String isOnline;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageUrl'] = imageUrl;
    _data['isOnline'] = isOnline;
    return _data;
  }
}

List<User> UserList = [
  currentUser,
  ironMan,
  captainAmerica,
  hulk,
  scarletWitch,
  spiderMan,
  blackWindow,
  thor,
  captainMarvel
];


final User currentUser = User(
  id: '0',
  name: 'Nick Fury',
  imageUrl: 'assets/images/nick-fury.jpg',
  isOnline: 'true',
);

// USERS
final User ironMan = User(
  id: '1',
  name: 'Iron Man',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'true',
);
final User captainAmerica = User(
  id: '2',
  name: 'Captain America',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'true',
);
final User hulk = User(
  id: '3',
  name: 'Hulk',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'false',
);
final User scarletWitch = User(
  id: '4',
  name: 'Scarlet Witch',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'false',
);
final User spiderMan = User(
  id: '5',
  name: 'Spider Man',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'true',
);
final User blackWindow = User(
  id: '6',
  name: 'Black Widow',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'false',
);
final User thor = User(
  id: '7',
  name: 'Thor',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'false',
);
final User captainMarvel = User(
  id: '8',
  name: 'Captain Marvel',
  imageUrl: 'images/icons/steelo.png',
  isOnline: 'false',
);