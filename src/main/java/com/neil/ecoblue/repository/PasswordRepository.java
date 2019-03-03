package com.neil.ecoblue.repository;

import com.neil.ecoblue.model.Account;
import com.neil.ecoblue.model.Password;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PasswordRepository extends JpaRepository<Password,Integer> {
    //naka auto na dito yung mga save, delete, findAll kapag nag extend ka nyan na JpaRepository
    Password findByPasswordId(int passwordId);
}
