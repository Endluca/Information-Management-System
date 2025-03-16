package bean;

import lombok.Data;

import java.util.Date;

@Data
public class Role {

    private int id;
    private String roleName;
    private String description;
    private Date createdTime;
}
