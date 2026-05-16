package com.Trieu.QuanLyDoTet.model;

import jakarta.persistence.*;

@Entity
@Table(name = "dodung")
public class DoDung {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String ten;
    private double gia;

    public DoDung() {}
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }
    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }
}