/// Form field validators for amTips.
class Validators {
  Validators._();

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required.';
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email address.';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required.';
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';
    if (value.length < 8) return 'Password must be at least 8 characters.';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please confirm your password.';
    if (value != original) return 'Passwords do not match.';
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required.';
    if (value.trim().length < 2) return 'Full name must be at least 2 characters.';
    if (!value.trim().contains(' ')) return 'Please enter your first and last name.';
    return null;
  }

  static String? tipAmount(String? value, {int min = 100, int max = 1000000}) {
    if (value == null || value.trim().isEmpty) return 'Amount is required.';
    final amount = int.tryParse(value.replaceAll(',', '').trim());
    if (amount == null) return 'Enter a valid amount.';
    if (amount < min) return 'Minimum amount is $min.';
    if (amount > max) return 'Maximum amount is $max.';
    return null;
  }

  static String? withdrawalAmount(
    String? value, {
    required int availableBalance,
    int min = 1000,
    int max = 1000000,
  }) {
    if (value == null || value.trim().isEmpty) return 'Amount is required.';
    final amount = int.tryParse(value.replaceAll(',', '').trim());
    if (amount == null) return 'Enter a valid amount.';
    if (amount < min) return 'Minimum withdrawal is $min.';
    if (amount > max) return 'Maximum withdrawal is $max.';
    if (amount > availableBalance) return 'Insufficient balance.';
    return null;
  }

  static String? message(String? value, {int maxLength = 200}) {
    if (value == null || value.isEmpty) return null; // Optional
    if (value.length > maxLength) {
      return 'Message cannot exceed $maxLength characters.';
    }
    return null;
  }

  static String? restaurantName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Restaurant name is required.';
    return null;
  }
}
