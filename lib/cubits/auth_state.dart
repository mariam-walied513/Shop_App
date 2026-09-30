abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final String name;
  final String email;
  final String phone;

  AuthLoaded({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}