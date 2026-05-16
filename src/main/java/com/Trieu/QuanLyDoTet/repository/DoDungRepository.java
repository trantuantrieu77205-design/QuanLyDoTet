package com.Trieu.QuanLyDoTet.repository;

import com.Trieu.QuanLyDoTet.model.DoDung;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DoDungRepository extends JpaRepository<DoDung, Long> {}