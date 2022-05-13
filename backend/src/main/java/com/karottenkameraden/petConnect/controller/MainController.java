package com.karottenkameraden.petConnect.controller;

import java.util.List;

import com.karottenkameraden.petConnect.auth.models.User;
import com.karottenkameraden.petConnect.models.account.Account;
import com.karottenkameraden.petConnect.models.account.AccountRepository;
import com.karottenkameraden.petConnect.models.match.Match;
import com.karottenkameraden.petConnect.models.profile.Profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

    @Autowired
    AccountRepository accountRepository;

    @GetMapping("/me")
    public ResponseEntity<Account> me() {
        Account account = getAccount(SecurityContextHolder.getContext());
        return ResponseEntity.ok(account);
    }

    @GetMapping("/profiles")
    public ResponseEntity<List<Profile>> getProfiles() {
        Account account = getAccount(SecurityContextHolder.getContext());
        List<Profile> profiles = account.getProfiles();
        return ResponseEntity.ok(profiles);
    }

    @GetMapping("/profiles/{profileId}")
    public ResponseEntity<Profile> getProfile(@PathVariable String profileId) {
        Account account = getAccount(SecurityContextHolder.getContext());
        Profile profile = getProfile(account, profileId);
        if (profile != null) {
            return ResponseEntity.ok(profile);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/profiles/{profileId}/matches")
    public ResponseEntity<String> getMatches(@PathVariable String profileId){
        Account account = getAccount(SecurityContextHolder.getContext());
        Profile profile = getProfile(account, profileId);
        // List<Match> matches = profile.getMatches();
        return ResponseEntity.ok(
            // matches
            "Matches from " + profile.getId()
            );
    }




    @GetMapping("/profiles/{profileId}/matches/{matchId}")
    public ResponseEntity<Match> getMatch(@PathVariable String profileId, @PathVariable String matchId) {
        Account account = getAccount(SecurityContextHolder.getContext());
        Profile profile = getProfile(account, profileId);
        Match match = getMatch(profile, matchId);
        if (match != null) {
            return ResponseEntity.ok(match);
        } else {
            return ResponseEntity.notFound().build();
        }
    }




    public Account getAccount(SecurityContext secCon) {
        User user = (User)secCon.getAuthentication().getPrincipal();
        if (user == null) {
            System.out.println("could not get authentication data");
            return null;
        }
        Account account = accountRepository.findById(user.getUid());
        if (account == null) {
            account = register(user);
        }
        return account;
    } 

    public Profile getProfile(Account account, String profileId){
        System.out.println("searched " + profileId);
        List<Profile> profiles = account.getProfiles();
        for (Profile profile : profiles) {
            System.out.println(profile.getId());
            if (profile.getId() == profileId) {
                return profile;
            }
        }
        return null;
    }

    public Match getMatch(Profile profile, String matchId){
        // List<Match> matches = profile.getMatches();
        // for (Match match : matches) {
        //     if (match.getId() == matchId) {
        //         return match;
        //     }
        // }
        return null;
    }

    public Account register(User user) {
        System.out.println("registering new user");
        String name = user.getName() == null ? "MissingUsername" : user.getName();
        Account account = new Account(user.getUid(), name, user.getEmail());
        
        accountRepository.save(account);
        return account;
    }






    @GetMapping("/debug")
    public ResponseEntity<String> debug() {
        String response = "SUCCESS <br/>";
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User)authentication.getPrincipal();
        response += "Uid: " + user.getUid() + "<br/>";
        response += "Name: " + user.getName() + "<br/>";
        response += "Email: " + user.getEmail() + "<br/>";
        response += "isEmailVerified: " + user.isEmailVerified() + "<br/>";
        response += "Issuer: " + user.getIssuer() + "<br/>";
        response += "Picture: " + user.getPicture() + "<br/>";
        return ResponseEntity.ok(response);
    }

}
