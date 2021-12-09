package com.karottenkameraden.petConnect.models.account;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountServiceImpl implements AccountService{
    
    @Autowired
    AccountRepository accountRepository;

    @Override
    public List<Account> findAllAccounts() {
        List<Account> accounts = accountRepository.findAll();
        List<Account> accountResponses = new ArrayList<>();
        accounts.forEach(account -> accountResponses.add(account));
        return accountResponses;
    }

}
