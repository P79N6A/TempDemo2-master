package cn.tsign.esign.quicksignsdkdemo;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import org.json.JSONObject;

import cn.tsign.esign.tsignsdk2.TESeal;
import cn.tsign.esign.tsignsdk2.custom.Custom;
import cn.tsign.esign.tsignsdk2.custom.DialogCustom;
import cn.tsign.esign.tsignsdk2.enums.EnumServer;
import cn.tsign.esign.tsignsdk2.enums.EnumTipMsgGravity;
import cn.tsign.esign.tsignsdk2.enums.EnumWindow;
import cn.tsign.esign.tsignsdk2.util.extend.Callback;
import cn.tsign.esign.tsignsdk2.util.extend.JSONUtils;
import cn.tsign.network.enums.EnumHandSignColor;

public class Main2Activity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        Button mBtnInit = (Button) findViewById(R.id.btn_init);
        final Button mBtnQuickToSign = (Button) findViewById(R.id.btn_dialog);
        final Button mBtnFullScreen = (Button) findViewById(R.id.btn_full_screen);
        final ImageView image = (ImageView) findViewById(R.id.image);

        final TextView tvLog = (TextView) findViewById(R.id.tv_log);

        mBtnInit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    TESeal.getInstance().init(getApplicationContext(), "1111563562", "612c09869b978d3f642242c79439aaaa", EnumServer.simulation);  //模拟环境
//                  TESeal.createInstance(getApplicationContext(), "1111563766", "c4f49388ec51092d305cbc738c95ae4b", EnumServer.official);  //正式环境

                    setCustomStyle();
                    tvLog.setText("sdk初始化");
                    mBtnQuickToSign.setEnabled(true);
                    mBtnFullScreen.setEnabled(true);
                } catch (Exception ex) {
                    tvLog.setText(ex.getLocalizedMessage());
                }

            }
        });


        //快捷签  弹出框
        mBtnQuickToSign.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TESeal.getInstance().quickToSign(Main2Activity.this, "123456", EnumWindow.Dialog, new Callback() {


                    @Override
                    public void didSignBackImage(String id, String sealImagePath) {
                        tvLog.setText(String.format("id=%s\r\nsealImagePath=%s", id, sealImagePath));
                        loadImage(image, sealImagePath);
                    }

                    @Override
                    public void onError(JSONObject json) {
                        tvLog.setText("手绘签名失败:" + JSONUtils.getString(json, "msg", ""));
                    }

                    @Override
                    public void onCancel(JSONObject json) {
                        tvLog.setText("取消手绘签名");
                    }
                });
            }
        });
        //快捷签    全屏
        mBtnFullScreen.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TESeal.getInstance().quickToSign(Main2Activity.this, "123456", EnumWindow.FullScreen, new Callback() {

                    @Override
                    public void didSignBackImage(String id, String sealImagePath) {
                        tvLog.setText(String.format("id=%s\r\nsealImagePath=%s", id, sealImagePath));
                        loadImage(image, sealImagePath);
                    }

                    @Override
                    public void onError(JSONObject json) {
                        tvLog.setText("手绘签名失败:" + JSONUtils.getString(json, "msg", ""));
                    }

                    @Override
                    public void onCancel(JSONObject json) {
                        tvLog.setText("取消手绘签名");
                    }
                });


            }
        });


    }

    // 对SDK里的页面做一些样式设置
    private void setCustomStyle() {
        //对SDK做个性化设置
        Custom custom = new Custom();
        //设置标题的背景颜色
        custom.setTitleBackgroundColor(R.color.black);
        //设置标题的文字颜色
        custom.setTitleTextColor(R.color.red);
        //设置标题文本
        custom.setTitleText(R.string.sign_title);
        //设置手绘签名前的提示语
        custom.setTipMsg("自定义提示语");
        //设置提示语对齐方向
        custom.setTipMsgGravity(EnumTipMsgGravity.center);
        //设置手绘的签署提供的颜色,只能是红,黑,蓝
        custom.getHandColor().add(EnumHandSignColor.Blue);
        custom.getHandColor().add(EnumHandSignColor.Black);
        custom.getHandColor().add(EnumHandSignColor.Red);

        //快捷签弹出式对话框的样式
        DialogCustom dialogCustom = new DialogCustom();
        dialogCustom.setCancelResourceId(R.drawable.tsign_quick_sign_dialog_cancel);
        dialogCustom.setFullScreenResourceId(R.drawable.tsign_quick_sign_dialog_full_screen);
        dialogCustom.setClearResourceId(R.drawable.tsign_quick_sign_dialog_clear);
        dialogCustom.setConfirmResourceId(R.drawable.tsign_quick_sign_dialog_confirm);
        custom.setDialogCustom(dialogCustom);

        TESeal.getInstance().setmCustom(custom);
    }


    /**
     * 加载图片
     *
     * @param imageView
     * @param imagePath
     */
    public void loadImage(ImageView imageView, String imagePath) {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inSampleSize = 2;//图片的长宽都是原来的1/8
        Bitmap bm = BitmapFactory.decodeFile(imagePath, options);
        imageView.setImageBitmap(bm);
    }
}
