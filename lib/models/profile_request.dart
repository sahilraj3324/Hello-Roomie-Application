class ProfileRequest {
  final String contactNumber;
  final String password;
  final String fullName;
  final int age;
  final String gender;
  final String profileType;
  final String maritalStatus;
  final String profilePicUrl;
  final String introduction;
  final String personality;
  final List<String> interests;
  final String hometown;
  final String city;
  final String address;
  final String foodPreference;
  final String drinking;
  final String smoking;
  final String pets;
  final String roomCleaning;
  final String workSchedule;
  final bool isActive;

  ProfileRequest({
    required this.contactNumber,
    required this.password,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.profileType,
    required this.maritalStatus,
    required this.profilePicUrl,
    required this.introduction,
    required this.personality,
    required this.interests,
    required this.hometown,
    required this.city,
    required this.address,
    required this.foodPreference,
    required this.drinking,
    required this.smoking,
    required this.pets,
    required this.roomCleaning,
    required this.workSchedule,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'contactNumber': contactNumber,
      'password': password,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'profileType': profileType,
      'maritalStatus': maritalStatus,
      'profilePicUrl': profilePicUrl,
      'introduction': introduction,
      'personality': personality,
      'interests': interests,
      'hometown': hometown,
      'city': city,
      'address': address,
      'foodPreference': foodPreference,
      'drinking': drinking,
      'smoking': smoking,
      'pets': pets,
      'roomCleaning': roomCleaning,
      'workSchedule': workSchedule,
      'isActive': isActive,
    };
  }

  factory ProfileRequest.fromJson(Map<String, dynamic> json) {
    return ProfileRequest(
      contactNumber: json['contactNumber'] ?? '',
      password: json['password'] ?? '',
      fullName: json['fullName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      profileType: json['profileType'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      profilePicUrl: json['profilePicUrl'] ?? '',
      introduction: json['introduction'] ?? '',
      personality: json['personality'] ?? '',
      interests: List<String>.from(json['interests'] ?? []),
      hometown: json['hometown'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      foodPreference: json['foodPreference'] ?? '',
      drinking: json['drinking'] ?? '',
      smoking: json['smoking'] ?? '',
      pets: json['pets'] ?? '',
      roomCleaning: json['roomCleaning'] ?? '',
      workSchedule: json['workSchedule'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }
}
