import 'package:e_commerce/controllers/controllers.dart';
import 'package:e_commerce/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import 'screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileFormController controller = ProfileFormController();

  handleSignOut(BuildContext context) async {
    bool? ok = await showConfirmationDialog(
      context,
      title: 'SignOut?',
      content: "Are you sure you want to sign out?",
    );

    if (ok != null && ok) {
      await FirebaseAuth.instance.signOut();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<LauncherProvider>(context, listen: false).changeIndex(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Provider.of<LauncherProvider>(context, listen: false).changeIndex(0);
        }),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileForm(controller: controller),
              ],
            ),
          ),
          const Spacer(),
          CustomGradientButton(
              onPressed: () => handleSignOut(context),
              width: MediaQuery.of(context).size.width,
              height: 45,
              text: 'Sign Out'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ProfileForm extends StatefulFormWidget<ProfileFormValue> {
  const ProfileForm({
    super.key,
    required ProfileFormController super.controller,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> with FormMixin {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).userData;
    if (user != null) {
      userNameTextEditingController.text = user?.displayName ?? '';
      widget.controller.value.userName = user?.displayName ?? '';
      emailTextEditingController.text = user!.email;
    }
  }

  handleUserNameUpdate() async {
    if (await widget.controller.validate() && user!.displayName != userNameTextEditingController.text) {
      try {
        locate<ProgressIndicatorController>().show();

        await AuthController().updateUserName(userName: widget.controller.value.userName!);

        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Update User Name",
            subtitle: "The User Name has been updated successfully.",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
        if (mounted) {
          Provider.of<UserProvider>(context, listen: false).updateUserModel(context, user!.uid);
        }
      } catch (err) {
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Something went wrong",
            subtitle: "Sorry, something went wrong here",
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
      } finally {
        locate<ProgressIndicatorController>().hide();
      }
    }
  }

  handlePasswordResetLinkSend() async {
    bool? ok = await showConfirmationDialog(
      context,
      title: 'Reset Password?',
      content: "Are you sure you want to\nreset password?",
    );
    if (ok != null && ok) {
      try {
        locate<ProgressIndicatorController>().show();

        await AuthController().sendPasswordResetEmail(email: emailTextEditingController.text);

        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Password Reset Link Sent",
            subtitle: "Please Check Your Emails",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
      } catch (err) {
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Something went wrong",
            subtitle: "Sorry, something went wrong here",
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
      } finally {
        locate<ProgressIndicatorController>().hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, formValue, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border:
                      Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                  child: TextField(
                    controller: userNameTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    style: GoogleFonts.lato(color: const Color(0xFF000000)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Add User Name",
                      hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                      errorText: formValue.getError("uName"),
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                      ),
                    ),
                    onChanged: (value) => widget.controller.setValue(
                      widget.controller.value..userName = value,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border:
                      Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                  child: TextField(
                    controller: emailTextEditingController,
                    maxLines: 1,
                    scrollPhysics: const AlwaysScrollableScrollPhysics(),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                    style: GoogleFonts.lato(color: const Color(0xFF000000)),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomGradientButton(
                onPressed: () => handleUserNameUpdate(),
                width: MediaQuery.of(context).size.width,
                height: 45,
                text: 'Update User Name'),
            CustomGradientButton(
                onPressed: () => handlePasswordResetLinkSend(),
                width: MediaQuery.of(context).size.width,
                height: 45,
                text: 'Reset Password'),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            CustomGradientButton(
                onPressed: () => CustomNavigator().goTo(
                      context,
                      const AddProducts(),
                    ),
                width: MediaQuery.of(context).size.width,
                height: 45,
                text: 'Add Product'),
            CustomGradientButton(
                onPressed: () => CustomNavigator().goTo(
                  context,
                  const MyOrders(),
                ),
                width: MediaQuery.of(context).size.width,
                height: 45,
                text: 'My Orders'),
          ],
        );
      },
    );
  }
}

class ProfileFormValue extends FormValue {
  String? userName;

  ProfileFormValue({this.userName});
}

class ProfileFormController extends FormController<ProfileFormValue> {
  ProfileFormController() : super(initialValue: ProfileFormValue(userName: ''));
  @override
  Future<bool> validate() async {
    value.errors.clear();

    String? uName = value.userName;

    if (FormValidators.isEmpty(uName)) {
      value.errors.addAll({"uName": "User Name is required"});
    }

    setValue(value);
    return value.errors.isEmpty;
  }
}
