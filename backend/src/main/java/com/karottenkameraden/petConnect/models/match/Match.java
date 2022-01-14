package com.karottenkameraden.petConnect.models.match;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
public class Match {

    @Id
    @GeneratedValue
    @NotNull
    private Long id;    

}