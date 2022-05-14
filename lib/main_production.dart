// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:ips_events_manager/bootstrap.dart';
import 'package:ips_events_manager/initializer.dart';
import 'package:meta_components/meta_components.dart';

void main() {
  MetaCollection().initDev();
  bootstrap(initializeApp);
}
