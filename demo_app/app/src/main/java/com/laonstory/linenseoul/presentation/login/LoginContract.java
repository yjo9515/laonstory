package com.laonstory.linenseoul.presentation.login;


import com.laonstory.data.model.Login;

// view와 presenter 계약 정의
public class LoginContract {
    interface View{
        void onLoginSuccess(Login login);
        void onLoginError(String message);
    }

    interface Presenter{
        void login(String id, String pw);

    }
}
