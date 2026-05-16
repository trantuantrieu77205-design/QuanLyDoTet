package com.Trieu.QuanLyDoTet.service;

import com.Trieu.QuanLyDoTet.model.DoDung;
import com.Trieu.QuanLyDoTet.repository.DoDungRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Comparator;
import java.util.List;

@Service
public class DoDungService {
    @Autowired
    private DoDungRepository repo;

    public List<DoDung> getAll() { return repo.findAll(); }
    public void save(DoDung d) { repo.save(d); }
    public void delete(Long id) { repo.deleteById(id); }

    public double tinhTong(List<DoDung> list) {
        return list.stream().mapToDouble(DoDung::getGia).sum();
    }

    public String timMonDatNhat(List<DoDung> list) {
        return list.stream()
                   .max(Comparator.comparingDouble(DoDung::getGia))
                   .map(DoDung::getTen)
                   .orElse("N/A");
    }
}