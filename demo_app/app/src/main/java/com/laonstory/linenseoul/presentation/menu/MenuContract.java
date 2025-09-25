package com.laonstory.linenseoul.presentation.menu;

public class MenuContract {
    interface View{
        void onBackPressed();
    }

    interface Presenter{
        void login(String id, String pw);

    }
}
