// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:repositories/repositories.dart';
import 'package:repository_collection/repository_collection.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  Future<void> login(BuildContext context) async {
    final repo = RepositoryCollection.instance
        .retrieve<AuthenticationRepository>() as AuthenticationRepository;
    await repo.performLogin(context: context);
  }
}
