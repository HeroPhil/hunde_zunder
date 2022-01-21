package com.karottenkameraden.petConnect.models.match;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.karottenkameraden.petConnect.models.profile.Profile;

@Getter
@Setter
@Entity
public class Match {

    @Id
    @NotNull
    private String id;    

    @ManyToOne
    @JoinColumn(name = "profile_id", nullable = false)
    private Profile profile;
}