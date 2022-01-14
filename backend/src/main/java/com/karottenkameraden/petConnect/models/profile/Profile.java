package com.karottenkameraden.petConnect.models.profile;

import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
public class Profile {

    @Id
    @GeneratedValue
    @NotNull
    private Long id;

    private String name;

    private String type;

    private String race;

    private int age;

    private String description;

    private String gender;

    private String interests;

    // private List<String> imagePaths;
}