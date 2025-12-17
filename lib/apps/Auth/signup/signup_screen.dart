import 'package:flutter/material.dart';
import '../../../apis/api_service.dart';
import '../../../models/profile_request.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hometownController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _personalityController = TextEditingController();

  // Dropdown/Selection Values
  String _gender = 'male';
  String _profileType = 'individual';
  String _maritalStatus = 'single';
  String _foodPreference = 'both';
  String _drinking = 'no';
  String _smoking = 'no';
  String _pets = 'no';
  String _roomCleaning = 'self';
  String _workSchedule = 'day';
  final List<String> _interests = [];

  // Options
  final List<String> _interestOptions = [
    'Reading',
    'Gaming',
    'Cooking',
    'Traveling',
    'Music',
    'Sports',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _hometownController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _introductionController.dispose();
    _personalityController.dispose();
    super.dispose();
  }

  Future<void> _submitProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final request = ProfileRequest(
      contactNumber: _phoneController.text,
      password: _passwordController.text,
      fullName: _fullNameController.text,
      age: int.tryParse(_ageController.text) ?? 18,
      gender: _gender,
      profileType: _profileType,
      maritalStatus: _maritalStatus,
      profilePicUrl: 'https://example.com/placeholder.jpg', // Placeholder
      introduction: _introductionController.text,
      personality: _personalityController.text,
      interests: _interests,
      hometown: _hometownController.text,
      city: _cityController.text,
      address: _addressController.text,
      foodPreference: _foodPreference,
      drinking: _drinking,
      smoking: _smoking,
      pets: _pets,
      roomCleaning: _roomCleaning,
      workSchedule: _workSchedule,
      isActive: true,
    );

    try {
      await _apiService.registerProfile(request);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile created successfully! Please login.'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error creating profile: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Profile')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 3) {
              setState(() => _currentStep += 1);
            } else {
              _submitProfile();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : details.onStepContinue,
                      child: Text(
                        _currentStep == 3
                            ? (_isLoading ? 'Creating...' : 'Submit')
                            : 'Next',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading ? null : details.onStepCancel,
                        child: const Text('Back'),
                      ),
                    ),
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('Account Info'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (v) => v!.length < 6 ? 'Min 6 chars' : null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Age'),
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _gender,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                          ),
                          items: ['male', 'female', 'other']
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _gender = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _maritalStatus,
                    decoration: const InputDecoration(
                      labelText: 'Marital Status',
                    ),
                    items: ['single', 'married', 'divorced', 'widowed']
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _maritalStatus = v!),
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Profile & Bio'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _introductionController,
                    decoration: const InputDecoration(
                      labelText: 'Introduction',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _personalityController,
                    decoration: const InputDecoration(labelText: 'Personality'),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _profileType,
                    decoration: const InputDecoration(
                      labelText: 'Profile Type',
                    ),
                    items: ['individual', 'shared']
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _profileType = v!),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Interests',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _interestOptions.map((interest) {
                      final isSelected = _interests.contains(interest);
                      return FilterChip(
                        label: Text(interest),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _interests.add(interest);
                            } else {
                              _interests.remove(interest);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Location'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _hometownController,
                    decoration: const InputDecoration(labelText: 'Hometown'),
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Current City',
                    ),
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Full Address',
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text('Habits & Preferences'),
              content: Column(
                children: [
                  _buildDropdown(
                    'Food Preference',
                    _foodPreference,
                    ['veg', 'non-veg', 'both'],
                    (v) => setState(() => _foodPreference = v!),
                  ),
                  _buildDropdown('Drinking', _drinking, [
                    'yes',
                    'no',
                    'occasionally',
                  ], (v) => setState(() => _drinking = v!)),
                  _buildDropdown('Smoking', _smoking, [
                    'yes',
                    'no',
                  ], (v) => setState(() => _smoking = v!)),
                  _buildDropdown('Pets', _pets, [
                    'yes',
                    'no',
                  ], (v) => setState(() => _pets = v!)),
                  _buildDropdown(
                    'Room Cleaning',
                    _roomCleaning,
                    ['self', 'maid'],
                    (v) => setState(() => _roomCleaning = v!),
                  ),
                  _buildDropdown(
                    'Work Schedule',
                    _workSchedule,
                    ['day', 'night', 'rotational'],
                    (v) => setState(() => _workSchedule = v!),
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: options
            .map(
              (e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
