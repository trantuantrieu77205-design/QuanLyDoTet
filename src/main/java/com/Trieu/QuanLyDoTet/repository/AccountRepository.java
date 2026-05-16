package com.Trieu.QuanLyDoTet.repository;

import com.Trieu.QuanLyDoTet.model.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepository extends JpaRepository<Account, String> {
    // Tìm tài khoản theo quyền (Role) và phân trang
    Page<Account> findByRole(int role, Pageable pageable);
}