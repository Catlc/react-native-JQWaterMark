package com.jiuqi.jqwatermark;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;


import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

/**
 * Created by ggx
 */

public class WatermarkModel extends ReactContextBaseJavaModule {

    public WatermarkModel(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @ReactMethod
    public void markWithName(String name, ReadableMap jobj) {
//        int degress = (int) (Float.parseFloat(jobj.getString("cg_transform_rotation")) * 360);
        int degress = -30;
        int fontSize = Integer.parseInt(jobj.getString("mark_font"));
        String color = jobj.getString("mark_color");
        int horSpzce = Integer.parseInt(jobj.getString("horizontal_apace"));
        int verSpace = Integer.parseInt(jobj.getString("vertical_space"));
        if (WatermarkUtil.iWatermarkInterface != null)
            WatermarkUtil.iWatermarkInterface.setWatermark(name, degress, fontSize, color, horSpzce, verSpace);
    }

    @ReactMethod
    public  void  hiddenWaterMark() {

//        WatermarkUtil.watermarkV == null;

    }

    @Override
    public String getName() {
        return "JQWaterMark";
    }
}
