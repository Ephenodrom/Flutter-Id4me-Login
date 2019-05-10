# Basic Utils

A dart package for many helper methods fitting different situations.

## Table of Contents

1. [Install](#install)
   * [pubspec.yaml](#pubspec.yaml)
2. [Import](#import)
3. [Usage](#usage)
   * [Button Paremeters](#button-parameters)
4. [Changelog](#changelog)
5. [Copyright and license](#copyright-and-license)

## Install

### pubspec.yaml

Update pubspec.yaml and add the following line to your dependencies.

```yaml
dependencies:
  flutter_id4me_login: ^0.3.0
```

## Import

Import the package with :

```dart
import 'package:flutter_id4me_login/flutter_id4me_login.dart';
```

## Usage

To integrate the Id4me login into your app, add the [Id4meLoginButton](lib/src/Id4meLoginButton.dart) inside your app.

```dart
Id4meLoginButton(
  properties,
  claimsParameters,
  "assets/img/id4meloginbtn.png",
  (Map<String, dynamic> userInfo) => Navigator.push(context,MaterialPageRoute(builder: (context) => Home(userInfo))),
  () => print("Error while login")
)
```

The tap on the button will trigger a small dialog/modal with a input field for the id4me login data. The tap on the "Login" button will then trigger the id4me login flow.

### Button parameters

| Name             | Type                          | Required | Description                                      |
|------------------|-------------------------------|:--------:|--------------------------------------------------|
| properties       | Map<String,dynamic>           |     X    | The Id4me properties                             |
| claimsParameters | Map<String,dynamic>           |     X    | The Id4me claimsparameters                       |
| imageLocation    | String                        |     X    | The location of the image for the button         |
| onSuccess        | Function(Map<String,dynamic>) |     X    | Function to call after successfull login         |
| onError          | Function()                    |     X    | Function to call after failed login              |
| height           | double                        |          | The height of the button. Default = 45           |
| inputDecoration  | InputDecoration               |          | The InputDecoration for domain input widget      |
| loginBtnText     | String                        |          | The text for the login button. Default = Login   |
| cancelBtnText    | String                        |          | The text for the cancel button. Default = Cancel |
| modalHintText    | String                        |          | An additional hint text, displayed in the modal  |

## Changelog

For a detailed changelog, see the [CHANGELOG.md](CHANGELOG.md) file

## Copyright and license

View [LICENSE](LICENSE)