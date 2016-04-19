package com.aquarii.jacobwilson.rocklunch;

import android.content.Context;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebView;
import android.widget.Button;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.util.Calendar;

public class MainActivity extends AppCompatActivity {

    String p = "<!DOCTYPE html> <html lang=\"en\"> <head> <meta charset=\"utf-8\" /> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /> <title>Rock Lunch</title> <link href='https://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'> <style> body { margin: 0; background: white; font-family: 'Open Sans', sans-serif; } h4 { text-align: left; } #content { width: 100%; } /*Auto-Generated Styling*/ .category-value { } .item-value { color: darkgray; } .period-value { display: none; } .no-print { display: none; } #table_calendar_week { width: 100%; } table { text-align: center; } td { display: list-item; margin-top: 10px; margin-left: 10px; margin-right: 10px; border-bottom: #f2f2f2 solid 1px; } .calendar-nav-month { display: none; } .daily-offerings { display: none; } </style> </head> <body> <div id=\"content\">";

    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        context = this;
        new GetMenu().execute();
    }



    private class GetMenu extends AsyncTask<Void, Void, String> {

        protected String doInBackground(Void... params) {
            URL url = null;
            try {
                url = new URL("http://myschooldining.com/Rockhurst%20High%20School/calendarWeek");
            } catch (MalformedURLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            URLConnection con = null;
            try {
                con = url.openConnection();
            } catch (IOException e) {
                e.printStackTrace();
            }
            HttpURLConnection http = (HttpURLConnection)con;
            try {
                http.setRequestMethod("POST");
            } catch (ProtocolException e) {
                e.printStackTrace();
            }
            http.setDoOutput(true);
            byte[] out = getParams().getBytes(StandardCharsets.UTF_8);
            int length = out.length;
            http.setFixedLengthStreamingMode(length);
            http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            try {
                http.connect();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try(OutputStream os = http.getOutputStream()) {
                os.write(out);
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                return convertStreamToString(http.getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "err";
        }

        protected void onPostExecute(String result) {
            WebView webView = (WebView) findViewById(R.id.mWebView);
            webView.getSettings().setJavaScriptEnabled(true);
            webView.loadData(p + result, "text/html", null);
        }

    }

    // http://stackoverflow.com/questions/309424/read-convert-an-inputstream-to-a-string
    static String convertStreamToString(java.io.InputStream is) {
        java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");
        return s.hasNext() ? s.next() : "";
    }

    public static String getParams() {
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH);
        int day = now.get(Calendar.DAY_OF_MONTH);
        String date = year + "-" + month + "-" + day;
        String params = "current_day=" + date + "&adj=3";
        return params;
    }

    private String loadAssetTextAsString(Context context, String name) {
        BufferedReader in = null;
        try {
            StringBuilder buf = new StringBuilder();
            InputStream is = context.getAssets().open(name);
            in = new BufferedReader(new InputStreamReader(is));

            String str;
            boolean isFirst = true;
            while ( (str = in.readLine()) != null ) {
                if (isFirst)
                    isFirst = false;
                else
                    buf.append('\n');
                buf.append(str);
            }
            return buf.toString();
        } catch (IOException e) {
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                }
            }
        }

        return null;
    }

}
