package com.karottenkameraden.petConnect.models.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/matchingProfile")
public class MatchingProfileController {

    @Autowired
    ProfileService profileService;

}