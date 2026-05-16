package com.Trieu.QuanLyDoTet.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.Date;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import com.Trieu.QuanLyDoTet.model.Account;
import com.Trieu.QuanLyDoTet.model.DonHang;
import com.Trieu.QuanLyDoTet.repository.AccountRepository;
import com.Trieu.QuanLyDoTet.repository.DonHangRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class TetController {

    @Autowired private AccountRepository accountRepo;
    @Autowired private DonHangRepository donHangRepo;

    private final DecimalFormat df = new DecimalFormat("#,###");

    private String getMonDatNhat(List<DonHang> list) {
        return list.stream().max(Comparator.comparingDouble(DonHang::getGia))
                   .map(dh -> dh.getTenMon() + " (" + df.format(dh.getGia()) + " đ)")
                   .orElse("Chưa có đồ");
    }

    private String getMonMuaNhieuNhat(List<DonHang> list) {
        if (list.isEmpty()) return "Chưa có đồ";
        return list.stream()
                   .collect(Collectors.groupingBy(DonHang::getTenMon, Collectors.summingInt(DonHang::getSoLuong)))
                   .entrySet().stream().max(Map.Entry.comparingByValue())
                   .map(entry -> entry.getKey() + " (SL: " + entry.getValue() + ")")
                   .orElse("Chưa có đồ");
    }

    private double getTongTienHnay(List<DonHang> list) {
        LocalDate today = LocalDate.now();
        return list.stream().filter(dh -> {
            if (dh.getNgayDat() == null) return false;
            LocalDate orderDate = dh.getNgayDat().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            return orderDate.equals(today);
        }).mapToDouble(item -> item.getGia() * item.getSoLuong()).sum();
    }

    @GetMapping("/")
    public String trangChuBanDau() { return "redirect:/login"; }

    @GetMapping("/login")
    public String showLogin() { return "login"; }

    @PostMapping("/login")
    public String processLogin(@RequestParam String username, @RequestParam String password, HttpSession session) {
        Optional<Account> acc = accountRepo.findById(username);
        if (acc.isPresent() && acc.get().getPassword().equals(password)) {
            Account user = acc.get();
            session.setAttribute("userSession", user);
            if (user.getRole() == 1) return "redirect:/admin/customers";
            else return "redirect:/sam-tet";
        }
        return "redirect:/login?error";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userSession");
        session.invalidate();
        return "redirect:/login";
    }

    // ================= QUẢN LÝ DÀNH CHO USER =================
    @GetMapping("/sam-tet")
    public String index(@RequestParam(defaultValue = "0") int page, 
                        @RequestParam(defaultValue = "") String keyword, 
                        @RequestParam(required = false) Double minPrice, 
                        @RequestParam(required = false) Double maxPrice,
                        @RequestParam(required = false) String fromDate,
                        @RequestParam(required = false) String toDate,
                        @RequestParam(defaultValue = "ngayDat-desc") String sortOption, 
                        Model model, HttpSession session) {
        Account user = (Account) session.getAttribute("userSession");
        if (user == null) return "redirect:/login";

        double min = (minPrice != null) ? minPrice : 0;
        double max = (maxPrice != null) ? maxPrice : 10000000000D;

        Date start = null; Date end = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            if (fromDate != null && !fromDate.isEmpty()) start = sdf.parse(fromDate + " 00:00:00");
            else start = new SimpleDateFormat("yyyy-MM-dd").parse("2000-01-01");
            
            if (toDate != null && !toDate.isEmpty()) end = sdf.parse(toDate + " 23:59:59");
            else end = new SimpleDateFormat("yyyy-MM-dd").parse("2099-12-31");
        } catch (Exception e) {}

        Sort sort = Sort.by("ngayDat").descending();
        if (sortOption.equals("ngayDat-asc")) sort = Sort.by("ngayDat").ascending();
        else if (sortOption.equals("gia-desc")) sort = Sort.by("gia").descending();
        else if (sortOption.equals("gia-asc")) sort = Sort.by("gia").ascending();

        Pageable pageable = PageRequest.of(page, 10, sort);
        Page<DonHang> donHangPage = donHangRepo.filterItems(user.getUsername(), keyword, min, max, start, end, pageable);
        
        List<DonHang> all = donHangRepo.findByUsername(user.getUsername());
        double tong = all.stream().mapToDouble(item -> item.getGia() * item.getSoLuong()).sum();

        model.addAttribute("list", donHangPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", donHangPage.getTotalPages());
        
        model.addAttribute("tong", tong);
        model.addAttribute("tongHomNay", getTongTienHnay(all));
        model.addAttribute("max", getMonDatNhat(all));
        model.addAttribute("topBuy", getMonMuaNhieuNhat(all));
        
        model.addAttribute("keyword", keyword);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("sortOption", sortOption);
        
        return "sam-tet";
    }

    // ================= QUẢN LÝ DÀNH CHO ADMIN =================
    @GetMapping("/admin/customers")
    public String listCustomers(@RequestParam(defaultValue = "0") int page, Model model, HttpSession session) {
        Account admin = (Account) session.getAttribute("userSession");
        if (admin == null || admin.getRole() != 1) return "redirect:/login";

        Pageable pageable = PageRequest.of(page, 10);
        Page<Account> customerPage = accountRepo.findByRole(0, pageable);

        List<DonHang> allSystemItems = donHangRepo.findAll();
        double totalRevenue = allSystemItems.stream().mapToDouble(item -> item.getGia() * item.getSoLuong()).sum();

        model.addAttribute("customers", customerPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", customerPage.getTotalPages());
        
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("systemTongHomNay", getTongTienHnay(allSystemItems));
        model.addAttribute("systemMax", getMonDatNhat(allSystemItems));
        model.addAttribute("systemTopBuy", getMonMuaNhieuNhat(allSystemItems));

        return "admin-home";
    }

    // [CẬP NHẬT] Thêm tính năng lọc nâng cao cho Admin
    @GetMapping("/admin/detail/{username}")
    public String customerDetail(@PathVariable String username, 
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "") String keyword, 
                                 @RequestParam(required = false) Double minPrice, 
                                 @RequestParam(required = false) Double maxPrice,
                                 @RequestParam(required = false) String fromDate,
                                 @RequestParam(required = false) String toDate,
                                 @RequestParam(defaultValue = "ngayDat-desc") String sortOption,
                                 Model model, HttpSession session) {
        Account admin = (Account) session.getAttribute("userSession");
        if (admin == null || admin.getRole() != 1) return "redirect:/login";

        double min = (minPrice != null) ? minPrice : 0;
        double max = (maxPrice != null) ? maxPrice : 10000000000D;

        Date start = null; Date end = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            if (fromDate != null && !fromDate.isEmpty()) start = sdf.parse(fromDate + " 00:00:00");
            else start = new SimpleDateFormat("yyyy-MM-dd").parse("2000-01-01");
            
            if (toDate != null && !toDate.isEmpty()) end = sdf.parse(toDate + " 23:59:59");
            else end = new SimpleDateFormat("yyyy-MM-dd").parse("2099-12-31");
        } catch (Exception e) {}

        Sort sort = Sort.by("ngayDat").descending();
        if (sortOption.equals("ngayDat-asc")) sort = Sort.by("ngayDat").ascending();
        else if (sortOption.equals("gia-desc")) sort = Sort.by("gia").descending();
        else if (sortOption.equals("gia-asc")) sort = Sort.by("gia").ascending();

        Pageable pageable = PageRequest.of(page, 10, sort);
        // Gọi hàm lọc y hệt User
        Page<DonHang> itemsPage = donHangRepo.filterItems(username, keyword, min, max, start, end, pageable);
        
        // Vẫn giữ danh sách FULL để tính Thống kê trên Header cho chuẩn
        List<DonHang> allUserItems = donHangRepo.findByUsername(username);

        model.addAttribute("items", itemsPage.getContent());
        model.addAttribute("targetUser", username);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", itemsPage.getTotalPages());
        
        model.addAttribute("userTongHomNay", getTongTienHnay(allUserItems));
        model.addAttribute("userMax", getMonDatNhat(allUserItems));
        model.addAttribute("userTopBuy", getMonMuaNhieuNhat(allUserItems));

        // Trả tham số về View để giữ form
        model.addAttribute("keyword", keyword);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("sortOption", sortOption);

        return "customer-detail";
    }

    @PostMapping("/admin/add-item")
    public String adminAddItem(@RequestParam String username, @RequestParam String tenMon, @RequestParam double gia, @RequestParam int soLuong) {
        if (gia <= 5000 || gia >= 10000000000D || gia % 1000 != 0 || soLuong <= 0) {
            return "redirect:/admin/detail/" + username + "?error=invalid-price";
        }
        donHangRepo.save(new DonHang(username, tenMon, gia, soLuong));
        return "redirect:/admin/detail/" + username;
    }

    @PostMapping("/admin/edit-item")
    public String adminEditItem(@RequestParam Long id, @RequestParam String username, @RequestParam String tenMon, @RequestParam double gia, @RequestParam int soLuong) {
        if (gia <= 5000 || gia >= 10000000000D || gia % 1000 != 0 || soLuong <= 0) {
            return "redirect:/admin/detail/" + username + "?error=invalid-price";
        }
        Optional<DonHang> opt = donHangRepo.findById(id);
        if (opt.isPresent()) {
            DonHang dh = opt.get();
            dh.setTenMon(tenMon);
            dh.setGia(gia);
            dh.setSoLuong(soLuong);
            donHangRepo.save(dh); 
        }
        return "redirect:/admin/detail/" + username;
    }

    @GetMapping("/admin/delete-item/{id}")
    public String adminDeleteItem(@PathVariable Long id) {
        Optional<DonHang> dh = donHangRepo.findById(id);
        if (dh.isPresent()) {
            String username = dh.get().getUsername();
            donHangRepo.deleteById(id);
            return "redirect:/admin/detail/" + username;
        }
        return "redirect:/admin/customers";
    }

    @GetMapping("/admin/print-invoice/{username}")
    public String printInvoice(@PathVariable String username, Model model, HttpSession session) {
        Account admin = (Account) session.getAttribute("userSession");
        if (admin == null || admin.getRole() != 1) return "redirect:/login";

        List<DonHang> allUserItems = donHangRepo.findByUsername(username);
        double total = allUserItems.stream().mapToDouble(item -> item.getGia() * item.getSoLuong()).sum();

        model.addAttribute("items", allUserItems);
        model.addAttribute("targetUser", username);
        model.addAttribute("total", total);
        model.addAttribute("printDate", new Date());

        return "invoice";
    }

    @GetMapping("/register")
    public String showRegister() { return "register"; }

    @PostMapping("/register")
    public String processRegister(@RequestParam String username, @RequestParam String password) {
        if (accountRepo.existsById(username)) return "redirect:/register?error=exists";
        accountRepo.save(new Account(username, password, 0));
        return "redirect:/login?success=true";
    }
}