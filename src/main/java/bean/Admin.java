package bean;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class Admin {
    private int id;
    private String username;
    private String password;
    private String email;
    private Timestamp createdTime;
}
