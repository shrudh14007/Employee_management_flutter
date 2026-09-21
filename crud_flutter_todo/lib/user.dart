class User{
  final int id;
  final String name;
  final String profession;

  User(
    this.id,
    this.name,
    this.profession
  );
}

List<User> users = [
  User(1,'Shrudhir', 'Developer'),
  User(2,'Dhoni', 'Keeper'),
  User(3,'Sundar Pichai', 'CEO'),
];