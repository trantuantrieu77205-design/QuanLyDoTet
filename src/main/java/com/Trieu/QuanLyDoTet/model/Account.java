package com.Trieu.QuanLyDoTet.model;

import jakarta.persistence.*;

@Entity
@Table(name = "account")
public class Account {
    @Id
    private String username;
    private String password;
    private int role; // 0: User, 1: Admin

    // 1. Hàm khởi tạo mặc định (Bắt buộc phải có cho JPA/Hibernate)
    public Account() {
    }

    // 2. THÊM HÀM NÀY: Hàm khởi tạo có tham số để dùng trong Controller
    public Account(String username, String password, int role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // Các Getter và Setter giữ nguyên
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }
}