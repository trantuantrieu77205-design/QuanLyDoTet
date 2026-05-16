package com.Trieu.QuanLyDoTet.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "donhang")
public class DonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String username;
    
    @Column(name = "ten_mon")
    private String tenMon;
    
    private double gia;

    @Column(name = "so_luong")
    private int soLuong; // THÊM CỘT SỐ LƯỢNG
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ngay_dat")
    private Date ngayDat = new Date();

    public DonHang() {}

    // Cập nhật hàm khởi tạo
    public DonHang(String username, String tenMon, double gia, int soLuong) {
        this.username = username;
        this.tenMon = tenMon;
        this.gia = gia;
        this.soLuong = soLuong;
    }

    // Các Getter và Setter cũ (giữ nguyên)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getTenMon() { return tenMon; }
    public void setTenMon(String tenMon) { this.tenMon = tenMon; }
    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }
    public Date getNgayDat() { return ngayDat; }
    public void setNgayDat(Date ngayDat) { this.ngayDat = ngayDat; }

    // THÊM Getter và Setter cho Số lượng
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
}