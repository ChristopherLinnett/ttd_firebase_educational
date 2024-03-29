import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_firebase_educational/src/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ttd_firebase_educational/src/auth/data/data_sources/auth_remote_data_source_implementation.dart';
import 'package:ttd_firebase_educational/src/auth/data/repos/auth_repo_implementation.dart';
import 'package:ttd_firebase_educational/src/auth/domain/repos/auth_repo.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/forgot_password.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/sign_in.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/sign_up.dart';
import 'package:ttd_firebase_educational/src/auth/domain/usecases/update_user.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/repos/on_boarding_repo_implementation.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/cache_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/use_cases/check_if_user_is_first_timer.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

part 'injection_container_main.dart';
