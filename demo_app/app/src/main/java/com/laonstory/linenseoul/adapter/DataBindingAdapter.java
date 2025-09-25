package com.laonstory.linenseoul.adapter;

import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.databinding.BindingAdapter;
import androidx.lifecycle.MutableLiveData;
import androidx.recyclerview.widget.RecyclerView;


import com.laonstory.data.model.RVTag;
import com.laonstory.data.model.Tag;

import java.util.ArrayList;

public class DataBindingAdapter {

    // 뷰의 visibility를 MutableLiveData<Boolean>의 값에 따라 변경
    @BindingAdapter("ba_visibility")
    public static void setEmptyTextVisibility(View view, MutableLiveData<Boolean> isVisible) {
        Log.e("tag", "화면전환 어뎁터");
        if (isVisible != null) {
            view.setVisibility(isVisible.getValue() ? View.VISIBLE : View.GONE);
            Log.e("tag", "화면전환");
            Log.e("tag", isVisible.getValue().toString());
        } else {
            view.setVisibility(View.GONE);
        }

    }
//
    // RecyclerView의 어댑터에 String 리스트를 바인딩
@BindingAdapter("ba_string_list")
public static void updateStringTagList(RecyclerView view, MutableLiveData<ArrayList<String>> item) {
    Log.e("tag", "어뎁터 실행");
    Log.e("tag", item.toString());
    Log.e("tag", item.getValue().toString());
    Log.e("tag", item.getClass().getName());

    if (item == null) {
        Log.e("tag", "item is null");
        return;
    }
    ArrayList<String> itemList = item.getValue();
//    ArrayList<String> itemList = new ArrayList<>();
//    itemList.add("dd");
    AddTagAdapter adapter = (AddTagAdapter) view.getAdapter();
    if (adapter instanceof AddTagAdapter) {
        if (itemList == null) {
            adapter.notifyDataSetChanged();
            Log.e("tag", "itemList is null");
            return;
        }
        try {
            adapter.setArrTagList(itemList);
            Log.e("tag", "itemList 있음");
            adapter.notifyItemInserted(itemList.size() - 1);
            view.scrollToPosition(itemList.size() - 1);
        } catch (IndexOutOfBoundsException e) {
            e.printStackTrace();
        }
    }

}


    // RecyclerView의 어댑터에 RVTag 리스트를 바인딩
    @BindingAdapter("ba_rv_tag_list")
    public static void updateRVTagList(RecyclerView view, MutableLiveData<ArrayList<RVTag>> item) {
        if (view.getAdapter() instanceof TagAdapter) {
            TagAdapter adapter = (TagAdapter) view.getAdapter();
            if (item.getValue() != null) {
                adapter.setArrTagList(item.getValue());
                adapter.notifyDataSetChanged();
            }
        }
    }

//    // RecyclerView의 어댑터에 Tag.Data 리스트를 바인딩
    @BindingAdapter("ba_tag_list")
    public static void updateTagList(RecyclerView view, MutableLiveData<ArrayList<Tag.Data>> item) {
        RecyclerView.Adapter<?> adapter = view.getAdapter();
        if (adapter != null) {
            if (adapter instanceof EditDeleteTagAdapter) {
                ArrayList<Tag.Data> data = item.getValue();
                if (data != null) {
                    ((EditDeleteTagAdapter) adapter).arrTagList = data;
                    if (data.isEmpty()) {
                        adapter.notifyDataSetChanged();
                    } else {
                        try {
                            adapter.notifyItemInserted(data.size() - 1);
                            view.scrollToPosition(data.size() - 1);
                        } catch (IndexOutOfBoundsException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else if (adapter instanceof CheckTagAdapter) {
                if(item != null){
                    ArrayList<Tag.Data> data = item.getValue();
                    if (data != null) {
                        ((CheckTagAdapter) adapter).arrTagList = data;
                        if (data.isEmpty()) {
                            adapter.notifyDataSetChanged();
                        } else {
                            try {
                                Log.e("tag", data.toString());
                                adapter.notifyItemInserted(data.size() - 1);
                                view.scrollToPosition(data.size() - 1);
                            } catch (IndexOutOfBoundsException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            } else if (adapter instanceof UserTagAdapter) {
                ArrayList<Tag.Data> data = item.getValue();
                if (data != null) {
                    ((UserTagAdapter) adapter).arrTagList = data;
                    if (data.isEmpty()) {
                        adapter.notifyDataSetChanged();
                    } else {
                        try {
                            adapter.notifyItemInserted(data.size() - 1);
                            view.scrollToPosition(data.size() - 1);
                        } catch (IndexOutOfBoundsException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }
//
//    private static void bindTagList(TagAdapter adapter, RecyclerView view, MutableLiveData<ArrayList<Tag.Data>> item) {
//        if (item.getValue() != null) {
//            adapter.arrTagList = item.getValue();
//            if (item.getValue().isEmpty()) {
//                adapter.notifyDataSetChanged();
//            } else {
//                try {
//                    adapter.notifyItemInserted(item.getValue().size() - 1);
//                    view.scrollToPosition(item.getValue().size() - 1);
//                } catch (IndexOutOfBoundsException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//
//    // RecyclerView의 어댑터에 UserTag.Data 리스트를 바인딩
//    @BindingAdapter("ba_user_tag_list")
//    @JvmStatic
//    public static void updateUserTagList(RecyclerView view, MutableLiveData<ArrayList<UserTag.Data>> item) {
//        if (view.getAdapter() instanceof AdminUserCheckTagAdapter) {
//            AdminUserCheckTagAdapter adapter = (AdminUserCheckTagAdapter) view.getAdapter();
//            if (item.getValue() != null) {
//                adapter.arrTagList = item.getValue();
//                if (item.getValue().isEmpty()) {
//                    adapter.notifyDataSetChanged();
//                } else {
//                    try {
//                        adapter.notifyItemInserted(item.getValue().size() - 1);
//                        view.scrollToPosition(item.getValue().size() - 1);
//                    } catch (IndexOutOfBoundsException e) {
//                        e.printStackTrace();
//                    }
//                }
//            }
//        }
//    }
//
//    // RecyclerView의 어댑터에 ResCheck.Response.Check 리스트를 바인딩
//    @BindingAdapter("ba_check_tag_list")
//    @JvmStatic
//    public static void updateCheckTagList(RecyclerView view, MutableLiveData<ArrayList<ResCheck.Response.Check>> item) {
//        if (view.getAdapter() instanceof CheckTagAdapter) {
//            CheckTagAdapter adapter = (CheckTagAdapter) view.getAdapter();
//            if (item.getValue() != null) {
//                adapter.arrTagList = item.getValue();
//                adapter.notifyDataSetChanged();
//            }
//        }
//    }
//
//    // RecyclerView의 어댑터에 ResNotice.Response.Notice 리스트를 바인딩
//    @BindingAdapter("ba_rv_notice_list")
//    @JvmStatic
//    public static void updateNoticeList(RecyclerView view, MutableLiveData<ArrayList<ResNotice.Response.Notice>> item) {
//        if (view.getAdapter() instanceof NoticeAdapter) {
//            NoticeAdapter adapter = (NoticeAdapter) view.getAdapter();
//            if (item.getValue() != null) {
//                adapter.arrNoticeList = item.getValue();
//                adapter.notifyDataSetChanged();
//            }
//        }
//    }

    // TextView에 MutableLiveData<String>를 바인딩
    @BindingAdapter("ba_text")
    public static void setText(TextView view, MutableLiveData<String> item) {
        Log.e("tag", "텍스트");
        if (item != null && item.getValue() != null) {
            view.setText(item.getValue());
        }
    }
}
