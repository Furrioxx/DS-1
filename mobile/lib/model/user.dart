class User {
    final int id;
    final String firstname;
    final String lastname;
    final String email;
    final String role;

    const User({
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) {
      return User(
        id: json['id'] as int,
        firstname: json['firstname'] as String,
        lastname: json['lastname'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
      );
    }

    @override
    String toString() => 'User($id, $firstname $lastname, $email, $role)';
}