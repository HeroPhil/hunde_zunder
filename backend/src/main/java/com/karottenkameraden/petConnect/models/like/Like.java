package com.karottenkameraden.petConnect.models.like;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
public class Like {

    @Id
    @GeneratedValue
    @NotNull
    private Long id;

    private Long senderId;

    private Long adresseeId;
}
