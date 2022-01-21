package com.karottenkameraden.petConnect.models.account;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.karottenkameraden.petConnect.models.profile.Profile;

@Getter
@Setter
@Entity
@Table(name = "accounts")
public class Account {

    @Id
    @NotNull
    private String id;

    @Column(nullable = false, length = 100)
    private String username;

    @Column(name = "email_address")
    private String email;

    // @Column()
    // private String password;

    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<Profile> profiles = new ArrayList<>();

    public Account() {
        super();
    }

    public Account(@NotNull String id, @NotNull String username, String email) {
        this.id = id;
        this.username = username;
        this.email = email;
        // this.password = password;
    }

    public Account(@NotNull String username, String email) {
        this.username = username;
        this.email = email;
        // this.password = password;
    }

    

}