import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_firebase_educational/core/common/views/page_under_construction.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';
import 'package:ttd_firebase_educational/core/services/injection_container.dart';
import 'package:ttd_firebase_educational/src/auth/data/models/user_model.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/views/sign_in_screen.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/views/sign_up_screen.dart';
import 'package:ttd_firebase_educational/src/dashboard/presentation/views/dashboard.dart';
import 'package:ttd_firebase_educational/src/on_boarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/views/on_boarding_screen.dart';

part 'router_main.dart';
