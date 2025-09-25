package com.laonstory.linenseoul.util;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Pattern;

public class CustomFormat {

    @RequiresApi(api = Build.VERSION_CODES.O)
    public static String toDateFromISO(String date) {
        LocalDateTime localDateTime = LocalDateTime.parse(date, DateTimeFormatter.ISO_DATE_TIME);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        return formatter.format(localDateTime);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public static String toDate(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime newDate = LocalDateTime.parse(date, formatter);
        DateTimeFormatter newFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        return newDate.format(newFormatter);
    }

    public static String getDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.getDefault());
        return formatter.format(Calendar.getInstance().getTime());
    }

    public static boolean isAfterAMonth(String date) {
        Calendar calendar = Calendar.getInstance();
        Date currentDate = calendar.getTime();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.getDefault());
        try {
            calendar.setTime(formatter.parse(date));
            calendar.add(Calendar.DAY_OF_MONTH, 30);
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }

        Date compareDate = calendar.getTime();
        return compareDate.before(currentDate);
    }

    public static String toTwoDigits(int num) {
        if (num < 10) {
            return "0" + num;
        }
        return Integer.toString(num);
    }

    public static boolean isTagValid(String tag) {
        String regex = "^[A-F0-9]{24,32}$";
        return Pattern.matches(regex, tag);
    }
}
