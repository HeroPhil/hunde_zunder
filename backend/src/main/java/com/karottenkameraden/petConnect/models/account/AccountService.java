package com.karottenkameraden.petConnect.models.account;

import java.util.List;

public interface AccountService {

    List<Account> findAllAccounts();
    Account findMyAccount(String email);
}
