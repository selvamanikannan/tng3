import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'user.dart';
import 'user_service.dart';

@Component(
  selector: 'add-user',
  templateUrl: 'add_user_component.html',
  styleUrls: ['add_user_component.css'],
  directives: [routerDirectives, coreDirectives, formDirectives],  
)
class AddUserComponent {
  final UserService _userService;
  final Router _router;
  Map<String, String> _fieldErrors;
  
  bool hasError = false;
  String globalError;

  AddUserComponent(this._userService, this._router);
  
  void add(String name, String age, String emailId) async {
    final resp = await _userService.add(name, age, emailId);
    if (resp) {
      hasError = false;
      var homeRoute = RoutePaths.users.toUrl();
      _router.navigate(homeRoute);
      return;
    }
    hasError = true;
    globalError = _userService.globalError;
    _fieldErrors = _userService.fieldErrors;
  }

  bool hasFieldError(String fieldName) {
    return _fieldErrors.containsKey(fieldName);
  }

  String fieldError(String fieldName) => _fieldErrors[fieldName];
}
