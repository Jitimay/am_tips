import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../bloc/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _restaurantController;
  late final TextEditingController _cityController;
  late final TextEditingController _countryController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    final profile = state is ProfileLoaded ? state.profile : null;
    _nameController = TextEditingController(text: profile?.fullName);
    _restaurantController =
        TextEditingController(text: profile?.restaurantName);
    _cityController = TextEditingController(text: profile?.city);
    _countryController = TextEditingController(text: profile?.country);
    _messageController =
        TextEditingController(text: profile?.personalMessage);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _restaurantController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80, maxWidth: 512);
    if (image != null && mounted) {
      context
          .read<ProfileBloc>()
          .add(ProfileAvatarUpdated(image.path));
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(
          ProfileUpdated(
            fullName: _nameController.text.trim(),
            restaurantName: _restaurantController.text.trim(),
            city: _cityController.text.trim(),
            country: _countryController.text.trim(),
            personalMessage: _messageController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          SnackBarUtils.showSuccess(context, 'Profile updated!');
          context.pop();
        } else if (state is ProfileError) {
          SnackBarUtils.showError(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final profile = state is ProfileLoaded
                ? state.profile
                : state is ProfileUpdating
                    ? state.profile
                    : null;
            final isLoading =
                state is ProfileUpdating || state is ProfileLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Avatar
                    Center(
                      child: Stack(
                        children: [
                          AvatarWidget(
                            name: _nameController.text.isNotEmpty
                                ? _nameController.text
                                : 'You',
                            imageUrl: profile?.avatarUrl,
                            radius: 44,
                            onTap: _pickAvatar,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickAvatar,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt_rounded,
                                    size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppTextField(
                      controller: _nameController,
                      label: 'Full name',
                      validator: Validators.fullName,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.person_outline_rounded,
                          size: 20),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _restaurantController,
                      label: 'Restaurant name',
                      validator: Validators.restaurantName,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.restaurant_outlined,
                          size: 20),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _cityController,
                            label: 'City',
                            validator: (v) =>
                                Validators.required(v, fieldName: 'City'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            controller: _countryController,
                            label: 'Country',
                            validator: (v) =>
                                Validators.required(v, fieldName: 'Country'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _messageController,
                      label: 'Personal message (optional)',
                      hint: 'Thank you for supporting my work ❤️',
                      maxLines: 3,
                      maxLength: 200,
                      validator: Validators.message,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      label: 'Save Changes',
                      onPressed: _submit,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
