package com.karottenkameraden.petConnect.models.debug;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class debugController {
    
    @GetMapping("/debug")
    public ResponseEntity<String> debug() {
        return ResponseEntity.ok("Success");
    }

    @GetMapping("/public/debug")
    public ResponseEntity<String> publicDebug() {
        return ResponseEntity.ok("Success");
    }

}
