import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';

import 'di.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit()
void configureDependencies() => serviceLocator.init();

