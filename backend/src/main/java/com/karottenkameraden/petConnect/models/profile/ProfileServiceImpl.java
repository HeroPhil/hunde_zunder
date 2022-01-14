package com.karottenkameraden.petConnect.models.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProfileServiceImpl implements ProfileService{
    
    @Autowired
    ProfileRepository profileRepository;

}