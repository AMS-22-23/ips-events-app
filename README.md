# IPS Events Manager

by: 
 - Edgar Santos
 - Henoch Vitureira
 - António Rosa

An awesome app.

# HOW TO RUN APP

## 1- Install Dependencies

### Option 1- Scripts [RUN IN UNIX - Git bash or Linux]

```shell
bash scripts/ci.sh --get
```
#### Flags

--clean : runs <b>flutter clean</b> in all packages

--get : runs <b>flutter pub get</b> in all packages

### Option 2 - Install via Very_Good CLI

- Run: *dart pub global activate very_good_cli*
- Run with the very_good cli: *very_good packages get -r* (installs all packages recursively)





## Create a module

flutter create --template=package some_feature_module

## Generate build scripts (json serialize, retrofit, etc)

after navigating to target dir:
flutter pub run build_runner build --delete-conflicting-outputs

### Translations

## Step 1

Update .json files on localizations_sdk/translations

## Step 2

Navigate to localizations_sdk/

## Step 3

Generate static keys:
flutter pub run easy_localization:generate -S assets/i18n -f keys -o localizations_sdk_keys.g.dart

## Usage

import the package:

```dart
import 'package:core_components/core_components.dart';
```

Use the translations:

```dart
Text(t(LocaleKeys.keyname));
```

# Fix iOS build (untested)

Install the required ffi version (does not fix anything and pretty sure this is not required, also it might be unsafe):

```shell
sudo gem install ffi --version 1.15.4
```

Install cocoapods (unsure if required):

```shell
brew install cocoapods
```

The real fix (unsure if any other step is required).
Run this on `ios` project folder:

```shell
sudo arch -x86_64 gem install ffi
arch -x86_64 pod install
```

Alternative fix (untested):
`uninstalling the cocoapods package through gem (sudo gem uninstall cocoapods) and reinstalling it with homebrew (brew install cocoapods) fixed my problem.`

# Rename bundleId

Install helper packages:

```shell
flutter pub global activate change_app_package_name
flutter pub global activate rename
```

First use the `change_app_package_name` package which changes Android folders structure:

```shell
flutter pub global run change_app_package_name:main <new_package_name>
```

Then use `rename` package:

```shell
flutter pub global run rename --bundleId <new_package_name>
```
