import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../controllers/controllers.dart';
import '../screens/screens.dart';
import '../utils/utils.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  List<String> _favItems = [];
  List<CarModel> _favouriteItems = [];

  UserModel? get userData => _user;
  List<String> get favItems => _favItems;
  List<CarModel> get favouriteItems => _favouriteItems;
  // Check User State
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  void checkAuthState(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!context.mounted) return; // Ensures context is valid
        FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {
            if (!context.mounted) return; // Double-checking context validity

            if (user == null) {
              CustomNavigator().goTo(context, const SignInScreen());
              Logger().e('User is currently Sign Out!');
            } else {
              fetchData(user.uid, context).then((value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  CustomNavigator().goTo(
                    context,
                    const LauncherScreen(),
                  );
                });
                Logger().i('User is signed in! --- $user');
              });
            }
          },
        );
      },
    );
  }

  Future<void> fetchData(uid, context) async {
    _user = await AuthController().getUserData(uid);
    // List<String> list = await HomeSliderController().getSliderImages();
    // Logger().e(list);
    // Provider.of<HomeSliderProvider>(context ,listen: false).updateSliderImageList(list);
    _favItems = _user?.favourite ?? [];
    notifyListeners();
  }

  void updateUserModel(BuildContext context, uid) async {
    _user = await AuthController().getUserData(uid);
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          _user = UserModel(
              displayName: user.displayName ?? '',
              email: user.email!,
              uid: user.uid,
              favourite: _favItems = _user!.favourite);
        }
      },
    );
    notifyListeners();
  }

  void addToFavourite(BuildContext context, CarModel car) {
    _favItems.add(car.id);
    _favouriteItems.add(car);
    users.doc(_user!.uid).update({"favourite": _favItems}).then((value) {
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Product added to Favourite",
          subtitle: "Product added to Favourite successfully",
          color: Colors.green,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 5),
      );
    });
    notifyListeners();
  }

  void removeFromFavourite(BuildContext context, CarModel car) {
    _favItems.remove(car.id);
    _favouriteItems.remove(car);
    users.doc(_user!.uid).update({"favourite": _favItems}).then((value) {
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Product removed from Favourite",
          subtitle: "Product removed from Favourite successfully",
          color: Colors.green,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 5),
      );
    });
    notifyListeners();
  }

  void filterFavouriteItems(List<CarModel> cars) {
    List<CarModel> filteredList = [];
    for (var car in cars) {
      if (_favItems.contains(car.id) && !_favouriteItems.contains(car)) {
        filteredList.add(car);
      }
    }
    _favouriteItems = filteredList;
    notifyListeners();
  }
}
