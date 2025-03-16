package model;

import lombok.Data;

import java.sql.Timestamp;
@Data
public class Picture {
    private int id;
    private String category;
    private String cover;
    private String name;
    private String tags;
    private String updateTime;
    private boolean status;

    // Getters and setters
    // ...
} 