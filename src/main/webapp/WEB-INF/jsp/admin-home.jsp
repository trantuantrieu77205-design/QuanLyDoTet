<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Bảng Điều Khiển Admin | Hệ thống Đồ Tết 2026</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            /* Tông màu Tết trầm ấm */
            --tet-red-dark: #8a0303;
            --tet-red-light: #d63031;
            --tet-gold-dark: #d35400;
            --tet-gold-light: #f1c40f;
            
            --primary-gradient: linear-gradient(135deg, var(--tet-red-dark) 0%, var(--tet-red-light) 100%);
            --gold-gradient: linear-gradient(135deg, var(--tet-gold-dark) 0%, var(--tet-gold-light) 100%);
            
            --bg-main: #fcf9f2; /* Trắng kem ấm */
        }
        body { 
            background-color: var(--bg-main); 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            color: #4a4a4a;
        }
        
        /* Navbar Tết */
        .navbar-admin {
            background-image: var(--primary-gradient) !important;
            box-shadow: 0 4px 12px rgba(138, 3, 3, 0.15) !important;
            border-bottom: 2px solid var(--tet-gold-light);
        }
        .navbar-admin .navbar-brand { color: #fff !important; font-weight: 900; letter-spacing: 0.05rem;}
        .navbar-admin .navbar-brand i { color: var(--tet-gold-light);}

        /* Thẻ Thống Kê (Nền trắng, viền trên màu trầm) */
        .card-stat {
            background-color: #fff;
            border: none;
            border-top: 4px solid !important;
            border-radius: 0.5rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.04);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card-stat:hover { transform: translateY(-3px); box-shadow: 0 6px 16px rgba(138, 3, 3, 0.08); }
        
        .card-stat.border-tet-red { border-top-color: var(--tet-red-light) !important;}
        .card-stat.border-tet-gold { border-top-color: var(--tet-gold-light) !important;}

        .stat-label { font-size: 0.85rem; font-weight: 700; text-transform: uppercase; color: #888; }
        .stat-value { font-size: 1.6rem; font-weight: 800; color: #2d3436; margin-top: 0.2rem;}
        .stat-icon { font-size: 2.5rem; opacity: 0.8; }

        /* Card Chứa Bảng */
        .card-data {
            border: none;
            background-color: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
        .card-data .card-header {
            background-color: #fff;
            border-bottom: 1px solid #f1f2f6;
            padding: 1.25rem;
        }

        /* Bảng dữ liệu */
        .table-custom { font-size: 0.95rem; margin: 0; }
        .table-custom thead th {
            background-color: #faf8f5;
            color: var(--tet-red-dark);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.8rem;
            border-bottom: 2px solid #f1f2f6;
        }
        .table-custom tbody td { padding: 1rem 0.75rem; border-bottom: 1px solid #f1f2f6;}
        .table-custom tbody tr:hover { background-color: #fdfbf7; }

        /* Nút thao tác mang màu Tết */
        .btn-action {
            background-color: #fff;
            border: 1px solid var(--tet-red-light);
            color: var(--tet-red-dark);
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-action:hover {
            background-image: var(--primary-gradient);
            color: #fff;
            border-color: transparent;
        }

        /* Phân trang */
        .pagination .page-item.active .page-link {
            background-color: var(--tet-red-light) !important;
            border-color: var(--tet-red-light) !important;
            color: #fff;
        }
        .pagination .page-link { color: var(--tet-red-dark); border-color: #f1f2f6; }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark navbar-admin">
        <div class="container">
            <span class="navbar-brand"><i class="fa-solid fa-fan me-2"></i>QUẢN LÝ SẮM TẾT 2026</span>
            <a href="/logout" class="btn btn-warning btn-sm fw-bold rounded-pill shadow-sm text-dark"><i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row mb-4 g-3">
            <div class="col-md-3">
                <div class="card card-stat border-tet-red h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Tổng Doanh Thu</div>
                            <div class="stat-value text-danger"><fmt:formatNumber value="${totalRevenue}" pattern="#,###"/> đ</div>
                        </div>
                        <div class="stat-icon text-danger"><i class="fa-solid fa-sack-dollar"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat border-tet-gold h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Doanh Thu Hôm Nay</div>
                            <div class="stat-value text-warning"><fmt:formatNumber value="${systemTongHomNay}" pattern="#,###"/> đ</div>
                        </div>
                        <div class="stat-icon text-warning"><i class="fa-solid fa-calendar-day"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat border-tet-red h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Món Giá Trị Nhất</div>
                            <div class="stat-value text-truncate fs-5" style="max-width: 170px;">${systemMax}</div>
                        </div>
                        <div class="stat-icon text-danger"><i class="fa-solid fa-gem"></i></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat border-tet-gold h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Bán Chạy Nhất</div>
                            <div class="stat-value text-truncate fs-5" style="max-width: 170px;">${systemTopBuy}</div>
                        </div>
                        <div class="stat-icon text-warning"><i class="fa-solid fa-boxes-stacked"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card card-data shadow-sm mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="m-0 fw-bold" style="color: var(--tet-red-dark);"><i class="fa-solid fa-users me-2 text-warning"></i>DANH SÁCH TÀI KHOẢN KHÁCH HÀNG</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom align-middle text-center m-0">
                        <thead>
                            <tr>
                                <th style="width: 10%;">STT</th>
                                <th class="text-start p-3">Tên Khách Hàng</th>
                                <th style="width: 30%;">Quản Lý Giỏ Đồ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${customers}" varStatus="loop">
                                <tr>
                                    <td class="fw-bold text-secondary">${currentPage * 10 + loop.index + 1}</td>
                                    <td class="text-start p-3 fw-bold text-dark text-uppercase">${user.username}</td>
                                    <td>
                                        <a href="/admin/detail/${user.username}" class="btn btn-action btn-sm rounded-pill px-3 shadow-sm">
                                            <i class="fa-solid fa-file-invoice me-1"></i> Xem Giỏ Đồ & Hóa Đơn
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <c:if test="${totalPages > 1}">
                <div class="card-footer bg-white border-0 pt-0 pb-4">
                    <nav>
                        <ul class="pagination pagination-sm justify-content-center m-0">
                            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/admin/customers?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>