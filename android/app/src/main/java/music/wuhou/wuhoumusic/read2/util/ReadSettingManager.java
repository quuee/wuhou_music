package music.wuhou.wuhoumusic.read2.util;


import music.wuhou.wuhoumusic.read2.page.PageBGStyle;
import music.wuhou.wuhoumusic.read2.page.PageMode;

/**
 * 阅读器的配置管理
 */
public class ReadSettingManager {
    /*************实在想不出什么好记的命名方式。。******************/
    public static final int READ_BG_DEFAULT = 0;
    public static final int READ_BG_1 = 1;
    public static final int READ_BG_2 = 2;
    public static final int READ_BG_3 = 3;
    public static final int READ_BG_4 = 4;
    public static final int NIGHT_MODE = 5;

    public static final String SHARED_READ_BG = "shared_read_bg";
    public static final String SHARED_READ_BRIGHTNESS = "shared_read_brightness";
    public static final String SHARED_READ_IS_BRIGHTNESS_AUTO = "shared_read_is_brightness_auto";
    public static final String SHARED_READ_TEXT_SIZE = "shared_read_text_size";
    public static final String SHARED_READ_IS_TEXT_DEFAULT = "shared_read_text_default";
    public static final String SHARED_READ_PAGE_MODE = "shared_read_mode";
    public static final String SHARED_READ_NIGHT_MODE = "shared_night_mode";
    public static final String SHARED_READ_VOLUME_TURN_PAGE = "shared_read_volume_turn_page";
    public static final String SHARED_READ_FULL_SCREEN = "shared_read_full_screen";
    public static final String SHARED_READ_CONVERT_TYPE = "shared_read_convert_type";

    private static volatile ReadSettingManager sInstance;

//    private SharedPreUtils sharedPreUtils;

    public static ReadSettingManager getInstance() {
        if (sInstance == null) {
            synchronized (ReadSettingManager.class) {
                if (sInstance == null) {
                    sInstance = new ReadSettingManager();
                }
            }
        }
        return sInstance;
    }

//    private ReadSettingManager() {
//        sharedPreUtils = SharedPreUtils.getInstance();
//    }

    private int pageStyleOrdinal;
    public void setPageStyle(PageBGStyle pageStyle) {
//        sharedPreUtils.putInt(SHARED_READ_BG, pageStyle.ordinal());
        pageStyleOrdinal = pageStyle.ordinal();
    }
    public PageBGStyle getPageStyle() {
//        int style = sharedPreUtils.getInt(SHARED_READ_BG, PageBGStyle.BG_0.ordinal());
        return PageBGStyle.values()[pageStyleOrdinal];
    }

    private int brightness = 40;
    public void setBrightness(int progress) {
//        sharedPreUtils.putInt(SHARED_READ_BRIGHTNESS, progress);
        brightness = progress;
    }
    public int getBrightness() {
//        return sharedPreUtils.getInt(SHARED_READ_BRIGHTNESS, 40);
        return brightness;
    }

    private Boolean autoBrightness = false;
    public void setAutoBrightness(boolean isAuto) {
//        sharedPreUtils.putBoolean(SHARED_READ_IS_BRIGHTNESS_AUTO, isAuto);
        autoBrightness = isAuto;
    }
    public boolean isBrightnessAuto() {
//        return sharedPreUtils.getBoolean(SHARED_READ_IS_BRIGHTNESS_AUTO, false);
        return autoBrightness;
    }

    public void setDefaultTextSize(boolean isDefault) {
//        sharedPreUtils.putBoolean(SHARED_READ_IS_TEXT_DEFAULT, isDefault);
    }
    public boolean isDefaultTextSize() {
//        return sharedPreUtils.getBoolean(SHARED_READ_IS_TEXT_DEFAULT, false);
        return false;
    }

    private Integer textSize = 28;
    public void setTextSize(int textSize) {
//        sharedPreUtils.putInt(SHARED_READ_TEXT_SIZE, textSize);
        this.textSize = textSize;
    }
    public int getTextSize() {

        return textSize;
    }

    public void setPageMode(PageMode mode) {
//        sharedPreUtils.putInt(SHARED_READ_PAGE_MODE, mode.ordinal());
    }
    public PageMode getPageMode() {
//        int mode = sharedPreUtils.getInt(SHARED_READ_PAGE_MODE, PageMode.SIMULATION.ordinal());
        return PageMode.values()[0];
    }
    private Boolean isNight = false;
    public void setNightMode(boolean isNight) {
//        sharedPreUtils.putBoolean(SHARED_READ_NIGHT_MODE, isNight);
        this.isNight = isNight;
    }
    public boolean isNightMode() {
//        return sharedPreUtils.getBoolean(SHARED_READ_NIGHT_MODE, false);
        return isNight;
    }


    public void setVolumeTurnPage(boolean isTurn) {
//        sharedPreUtils.putBoolean(SHARED_READ_VOLUME_TURN_PAGE, isTurn);
    }

    public boolean isVolumeTurnPage() {
//        return sharedPreUtils.getBoolean(SHARED_READ_VOLUME_TURN_PAGE, false);
        return false;
    }

    public void setFullScreen(boolean isFullScreen) {
//        sharedPreUtils.putBoolean(SHARED_READ_FULL_SCREEN, isFullScreen);
    }

    public boolean isFullScreen() {
//        return sharedPreUtils.getBoolean(SHARED_READ_FULL_SCREEN, false);
        return true;
    }
//
    public void setConvertType(int convertType) {
//        sharedPreUtils.putInt(SHARED_READ_CONVERT_TYPE, convertType);
    }

    public int getConvertType() {
//        return sharedPreUtils.getInt(SHARED_READ_CONVERT_TYPE, 0);
        return 0;
    }
}
