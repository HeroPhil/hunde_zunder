package com.karottenkameraden.petConnect.models.debug;


import java.util.Map;

import com.karottenkameraden.petConnect.auth.models.User;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class debugController {
    
    // @GetMapping("/debug")
    // public ResponseEntity<String> debug() {
    //     String response = "SUCCESS <br/>";
    //     Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    //     User user = (User)authentication.getPrincipal();
    //     response += "Uid: " + user.getUid() + "<br/>";
    //     response += "Name: " + user.getName() + "<br/>";
    //     response += "Email: " + user.getEmail() + "<br/>";
    //     response += "isEmailVerified: " + user.isEmailVerified() + "<br/>";
    //     response += "Issuer: " + user.getIssuer() + "<br/>";
    //     response += "Picture: " + user.getPicture() + "<br/>";
    //     return ResponseEntity.ok(response);
    // }

    // @GetMapping("/public/debug")
    // public ResponseEntity<String> publicDebug() {
    //     String response = "SUCCESS";
    //     return ResponseEntity.ok(response);
    // }

}
