import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cache_helper.dart';
import 'appStates.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIniState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null){
      isDark = fromShared;

      emit(AppChangeModeState());
    }
     else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }

  }


}
