package com.karottenkameraden.petConnect;

import com.karottenkameraden.petConnect.models.account.Account;
import com.karottenkameraden.petConnect.models.account.AccountRepository;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class PetConnectApplication {

	public static void main(String[] args) {
		SpringApplication.run(PetConnectApplication.class, args);
	}

	@Bean
    CommandLineRunner init(AccountRepository accountRepository) {
        return args -> {
			// Account account1 = new Account("peter", "p@p.de", "pw");
			// Account account2 = new Account("hans", "h@h.de", "pw2");
			// accountRepository.save(account1);
			// accountRepository.save(account2);
		};

	}

}
