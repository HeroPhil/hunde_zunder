package com.karottenkameraden.petConnect.models.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class LikeServiceImpl implements LikeService{
    
    @Autowired
    LikeRepository likeRepository;

}