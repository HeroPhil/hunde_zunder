package com.karottenkameraden.petConnect.models.profile;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ProfileRepository extends JpaRepository<Profile, Long> {

    Profile findByName(String name);
    Profile findById(long id);

}