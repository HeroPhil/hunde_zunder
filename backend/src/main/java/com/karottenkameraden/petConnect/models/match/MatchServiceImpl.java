package com.karottenkameraden.petConnect.models.match;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MatchServiceImpl implements MatchService{
    
    @Autowired
    MatchRepository matchRepository;

}