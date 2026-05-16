package com.Trieu.QuanLyDoTet.repository;

import com.Trieu.QuanLyDoTet.model.DonHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.Date;
import java.util.List;

public interface DonHangRepository extends JpaRepository<DonHang, Long> {
    List<DonHang> findByUsername(String username);
    Page<DonHang> findByUsername(String username, Pageable pageable);

    // [CẬP NHẬT] Bộ lọc nâng cao: Từ khóa + Khoảng giá + Khoảng thời gian
    @Query("SELECT d FROM DonHang d WHERE d.username = ?1 " +
           "AND LOWER(d.tenMon) LIKE LOWER(CONCAT('%', ?2, '%')) " +
           "AND d.gia >= ?3 AND d.gia <= ?4 " +
           "AND d.ngayDat >= ?5 AND d.ngayDat <= ?6")
    Page<DonHang> filterItems(String username, String keyword, double minPrice, double maxPrice, Date fromDate, Date toDate, Pageable pageable);
}