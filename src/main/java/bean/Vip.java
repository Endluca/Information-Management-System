package bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Vip {
    private int id;
    private String username;
    private String gender;
    private String phone;
    private String email;
    private String address;
    private Timestamp createdTime;
    private String isDeleted;
}
