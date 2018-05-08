package com.jiuqi.jqwatermark;


import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.facebook.react.ReactActivity;

/**
 * Created by ggx
 */

public class WatermarkUtil{
    private static ReactActivity activity;

    public static void setActivity(ReactActivity activity) {
        WatermarkUtil.activity = activity;
        init();
    }

    protected static IWatermarkInterface iWatermarkInterface;

    private static View watermarkV;

    private static void init(){
        if (watermarkV == null)
            watermarkV = new View(activity);
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        watermarkV.setLayoutParams(layoutParams);
        ViewGroup rootView = (ViewGroup) activity.findViewById(android.R.id.content);
        rootView.addView(watermarkV, rootView.getChildCount());
        WatermarkUtil.iWatermarkInterface = new IWatermarkInterface() {
            @Override
            public void setWatermark(String label, int degress, int fontSize, String color, int horizentalSpace, int verSpace) {
                final WaterMarkBg waterMarkBg = new WaterMarkBg(activity, label, degress, fontSize, color, horizentalSpace, verSpace);
                waterMarkBg.setAlpha(0x33);
                watermarkV.post(new Runnable() {
                    @Override
                    public void run() {
                        watermarkV.setBackgroundDrawable(waterMarkBg);
                    }
                });
            }
        };
    }
}
