package com.karottenkameraden.petConnect.models.profile;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.karottenkameraden.petConnect.models.account.Account;
import com.karottenkameraden.petConnect.models.match.Match;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "profiles")
public class Profile {

    @Id
    @NotNull
    private String id;

    @Column(nullable = false, length = 40)
    private String name;

    @Enumerated(EnumType.STRING)
    private ProfileType type;

    @Column(nullable = false)
    private String race;

    @Transient 
    private Integer age;

    @Temporal(TemporalType.DATE)
    private Date birthDate;

    @Column
    private String description;

    @Enumerated(EnumType.STRING)
    private ProfileGender gender;

    @Column
    private String interests;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "account_id", nullable = false)
    private Account account;

    // @JsonManagedReference
    // @OneToMany(mappedBy = "profile", cascade = CascadeType.ALL)
    // private List<Match> matches = new ArrayList<>();

    // private List<String> imagePaths;
}


