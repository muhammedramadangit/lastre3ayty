import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/User/screens/Auth/Confirm_Forget_Password/Bloc/Confirm_Forget_State.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmForgetCubit extends Cubit<ConfirmForgetState>{
  ConfirmForgetCubit() : super(ConfirmForgetInitState());

  static ConfirmForgetCubit get(context) => BlocProvider.of(context);

  Dio dio = Dio();
  String code;

  Future<void> postConfirmForget() async {
    emit(ConfirmForgetLoadingState());

    try{
      print("code : $code");
      final url = "https://mycare.pro/api/verify-forget-password";
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final phone = _pref.getString("phone");

      dio.options.headers = {
        "Accept" : "application/json",
      };

      FormData formData = FormData.fromMap({
        "phone" : phone,
        "code" : code,
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(ConfirmForgetSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(ConfirmForgetErrorState(response.data["msg"]));
      }

    }catch(e){
      if(e.response != null){
        emit(ConfirmForgetErrorState(e));
      }

    }
  }
}