package util;

public class StrUtil {
    public static boolean isBlank(String v){
        if(null==v){
            return true;
        }else if(v.equals("")){
            return true;
        }
        return false;
    }
}
