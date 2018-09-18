import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'user.dart';
import 'user_service.dart';
import 'route_paths.dart';
import 'list_user_component.dart';

@Component(
  selector: 'my-user',
  templateUrl: 'edit_user_component.html',
  styleUrls: ['edit_user_component.css'],
  directives: [
               coreDirectives,
               formDirectives,
               ListUserComponent,
               routerDirectives,
               ],
)
class EditUserComponent implements OnActivate {
  
  User user;

  final UserService _userService;
  Map<String, dynamic> error_message = {};
  final Location _location;
  final Router _router;
  
  EditUserComponent(this._userService, this._location, this._router);
  
  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);    
    if (id != null) {
      var response = await _userService.get(id);
      if (response is User) {
          user = response;
      } else {
          response.forEach((dict) =>
                             error_message[dict['name']] = dict['description']);
          user = null;
      }
    }
  }

  void goBack() => _location.back();

  void save() async {
       var response = await _userService.update(user);
       if (response == null) {
           goBack();
       } else {
           response.forEach((dict) =>
                            error_message[dict['name']] = dict['description']);
       }
  }
}
	
