package com.laonstory.linenseoul.presentation.login;

import android.util.Log;

import com.google.gson.Gson;
import com.laonstory.data.model.ErrorResponse;
import com.laonstory.data.model.Login;
import com.laonstory.data.repository.UserRepository;


public class LoginPresenter implements LoginContract.Presenter{

    private LoginContract.View view;
    private UserRepository userRepository;

    public LoginPresenter(LoginContract.View view) {
        this.view = view;
        this.userRepository = new UserRepository();
    }

    @Override
    public void login(String id, String pw) {
        if (id.isEmpty() || pw.isEmpty()) {
            view.onLoginError("아이디 혹은 비밀번호를 입력해주세요.");
            return;
        }

        userRepository.login(id, pw, new UserRepository.LoginCallback() {
            @Override
            public void onSuccess(Login loginResponse) {
                view.onLoginSuccess(loginResponse);
            }

            @Override
            public void onError(String errorMessage) {
                Log.v("로그인",errorMessage);
                view.onLoginError(errorMessage);
//                if(!errorMessage.isEmpty()){
//                    Gson gson = new Gson();
//                    ErrorResponse error = gson.fromJson(errorMessage, ErrorResponse.class);
//                    view.onLoginError(error.getMessage());
//                }else{
//                    view.onLoginError("에러가 발생했습니다.");
//                }
            }
        });
    }

}
