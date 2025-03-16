package util;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

@Data
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
public class Page<T> {
    private int pageNo=1;
    private int pageSize=10;

    private int totalPage;//总共多少页
    private int totalRow=0;//总共多少条

    private List<T> list=new ArrayList<>();//layui 返回结果 data 求出的内容


}
