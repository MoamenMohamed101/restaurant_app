import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/constants.dart';
import 'package:restaurant_app/app/dependency_injection.dart';
import 'package:restaurant_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:restaurant_app/presentation/register/viewmodel/register_view_model.dart';
import 'package:restaurant_app/presentation/resources/assets_manager.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/routes_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    _bind();
    super.initState();
  }

  final _viewModel = instance<RegisterViewModel>();
  final _imagePicker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _userNameController = TextEditingController(),
      _mobileNumberController = TextEditingController();

  final _appPreferences = instance<AppPreferences>();
  _bind() {
    _viewModel.start();
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _userNameController.addListener(() => _viewModel.setUserName(_userNameController.text));
    _mobileNumberController.addListener(() => _viewModel.setMobileNumber(_mobileNumberController.text));
    isCredentialsCorrect();
  }

  void isCredentialsCorrect() {
    _viewModel.isUserRegisteredInSuccessfullyStreamController.stream
        .listen((isUserRegisteredInSuccessfully) {
      if (isUserRegisteredInSuccessfully) {
        navigateToMainScreenAndSaveInCacheMemory();
      }
    });
  }

  void navigateToMainScreenAndSaveInCacheMemory() {
    SchedulerBinding.instance.addPostFrameCallback((_) => Navigator.of(context).pushReplacementNamed(Routes.mainRoute));
    _appPreferences.setUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        iconTheme: const IconThemeData(color: ColorManager.primaryColor),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getStateWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() => Container(
        padding: const EdgeInsetsDirectional.only(
          top: AppPadding.p28,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                applicationLogo(),
                heightSize28(),
                userNameFiled(),
                heightSize28(),
                flagAndMobileFiled(),
                heightSize28(),
                emailFiled(),
                heightSize28(),
                passwordField(),
                heightSize28(),
                imagePickerField(),
                heightSize28(),
                registerButton(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: AppPadding.p8,
                    // start: AppPadding.p28,
                    // end: AppPadding.p28,
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      AppStrings.alReadyHaveAccount,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Center flagAndMobileFiled() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            countryFlag(),
            mobileFiled(),
          ],
        ),
      ),
    );
  }

  Expanded mobileFiled() {
    return Expanded(
      flex: 4,
      child: StreamBuilder<String?>(
        stream: _viewModel.outputErrorMobileNumber,
        builder: (context, snapshot) {
          return TextFormField(
            keyboardType: TextInputType.phone,
            controller: _mobileNumberController,
            decoration: InputDecoration(
              errorText: snapshot.data,
              hintText: AppStrings.mobileNumber,
              icon: const Icon(Icons.phone),
            ),
          );
        },
      ),
    );
  }

  Expanded countryFlag() {
    return Expanded(
      flex: 1,
      child: CountryCodePicker(
        onChanged: (country) =>
            _viewModel.setCountryCode(country.dialCode ?? Constants.token),
        initialSelection: '+20',
        favorite: const ['+39', 'FR', "+966"],
        showCountryOnly: true,
        showOnlyCountryWhenClosed: true,
        hideMainText: true,
      ),
    );
  }

  Center applicationLogo() {
    return const Center(
      child: Image(
        image: AssetImage(ImageAssets.splashLogo),
      ),
    );
  }

  SizedBox heightSize28() {
    return const SizedBox(
      height: AppSize.s28,
    );
  }

  Padding emailFiled() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<String?>(
        stream: _viewModel.outputErrorEmail,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.userEmail,
              errorText: snapshot.data,
              hintText: AppStrings.userEmail,
              icon: const Icon(Icons.email),
            ),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          );
        },
      ),
    );
  }

  Padding userNameFiled() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<String?>(
        stream: _viewModel.outputErrorUserName,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              errorText: snapshot.data,
              hintText: AppStrings.userName,
              icon: const Icon(Icons.person),
            ),
            controller: _userNameController,
            keyboardType: TextInputType.name,
          );
        },
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<String?>(
        stream: _viewModel.outputErrorPassword,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.password,
              errorText: snapshot.data,
              hintText: AppStrings.password,
              icon: const Icon(Icons.password),
            ),
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
          );
        },
      ),
    );
  }

  Padding imagePickerField() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: Container(
        height: AppSize.s40,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.grey,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: GestureDetector(
          child: _getMediaImage(),
          onTap: () {
            _showPicker(context);
          },
        ),
      ),
    );
  }

  _getMediaImage() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(AppStrings.profileImage)),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputProfilePicture,
            builder: (context, snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCamera)),
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  Padding registerButton() {
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputAreAllFieldsValid,
        builder: (context, snapshot) {
          return SizedBox(
            height: AppSize.s40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (snapshot.data ?? false)
                  ? () {
                      _viewModel.register();
                    }
                  : null, // if snapshot.data is true, call the register method
              child: const Text(AppStrings.register),
            ),
          );
        },
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.browse_gallery),
                title: const Text(AppStrings.profileImage),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Icon(Icons.camera_alt_outlined),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _viewModel.setProfilePicture(File(image.path));
    }
  }

  void _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _viewModel.setProfilePicture(File(image.path));
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
