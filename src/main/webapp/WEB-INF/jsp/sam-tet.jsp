<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Không Gian Sắm Tết | Tết 2026</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
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
        .navbar-tet {
            background-image: var(--primary-gradient) !important;
            box-shadow: 0 4px 12px rgba(138, 3, 3, 0.15) !important;
            border-bottom: 2px solid var(--tet-gold-light);
        }
        .navbar-tet .navbar-brand { color: #fff !important; font-weight: 900; letter-spacing: 0.05rem;}

        /* Card Panels trắng kem sáng */
        .card-panel {
            background-color: #fff;
            border: none;
            border-radius: 0.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
            margin-bottom: 1.5rem;
        }
        
        .card-panel .card-header {
            border: none;
            border-radius: 0.5rem 0.5rem 0 0 !important;
            padding: 0.85rem 1.25rem;
        }
        
        .bg-header-gold { background-image: var(--gold-gradient); color: #fff !important;}

        /* Thẻ Thống Kê Dọc (Trái) */
        .stat-box {
            background-color: #faf8f5;
            border: 1px solid #f1f2f6;
            border-radius: 0.5rem;
            padding: 1.25rem;
            margin-bottom: 1rem;
            border-left: 4px solid var(--tet-red-light);
        }
        .stat-box.gold { border-left-color: var(--tet-gold-light); }
        
        /* Inputs */
        .form-control-sm, .form-select-sm, .input-group-text-sm { border-radius: 0.25rem;}
        
        /* Table Minimal */
        .table-minimal { font-size: 0.95rem; margin: 0;}
        .table-minimal thead th {
            font-size: 0.8rem;
            text-transform: uppercase;
            background-color: #faf8f5;
            color: var(--tet-red-dark);
            border-bottom: 2px solid #f1f2f6;
            font-weight: 700;
        }
        .table-minimal tbody tr { border-bottom: 1px solid #f1f2f6;}
        .table-minimal tbody tr:hover { background-color: #fdfbf7;}

        /* Nút thao tác */
        .btn-tet-gold {
            background-image: var(--gold-gradient);
            color: #fff;
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .btn-tet-gold:hover { color: #fff; opacity: 0.9; transform: translateY(-1px);}

        /* Phân trang */
        .pagination .page-item.active .page-link {
            background-color: var(--tet-red-light) !important;
            border-color: var(--tet-red-light) !important;
            color: #fff;
        }
        .pagination .page-link { color: var(--tet-red-dark); border-color: #f1f2f6; }
        /* ---------------- FORM LỌC PREMIUM ---------------- */
        .filter-premium {
            background-color: #fff;
            border: 1px solid #fce8e8;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 8px 20px rgba(218, 37, 29, 0.04);
            margin-bottom: 24px;
        }
        .filter-label-premium {
            font-size: 0.75rem;
            font-weight: 700;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.05rem;
            margin-bottom: 8px;
        }
        .input-premium {
            background-color: #f4f6f9; /* Xám siêu nhạt, không viền */
            border: 1px solid transparent;
            border-radius: 8px;
            padding: 0.6rem 1rem;
            font-size: 0.9rem;
            color: #333;
            transition: all 0.2s ease;
        }
        .input-premium:focus {
            background-color: #fff;
            border-color: #f5c6cb;
            box-shadow: 0 0 0 0.25rem rgba(218, 37, 29, 0.1);
        }
        .btn-premium {
            border-radius: 8px;
            padding: 0.6rem 1rem;
            font-weight: 600;
            transition: all 0.2s;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-tet">
        <div class="container">
            <span class="navbar-brand text-uppercase"><i class="fa-solid fa-fan me-2 text-warning"></i>MÙA TẾT 2026</span>
            <div class="d-flex text-white align-items-center">
                <span class="me-3 fw-bold"><i class="fa-regular fa-circle-user me-1 text-warning"></i> Chào, ${userSession.username}</span>
                <a href="/logout" class="btn btn-warning btn-sm fw-bold rounded-pill text-dark px-3 shadow-sm"><i class="fa-solid fa-right-from-bracket me-1"></i> Thoát</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-4 col-md-5 mb-4">
                <div class="card card-panel border-top border-4" style="border-top-color: var(--tet-red-dark) !important;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-4" style="color: var(--tet-red-dark);"><i class="fa-solid fa-chart-line me-2 text-warning"></i> TỔNG QUAN CỦA BẠN</h5>
                        
                        <div class="stat-box">
                            <p class="mb-1 text-muted fs-7 fw-bold text-uppercase">Tổng ngân sách mua sắm</p>
                            <h3 class="fw-bold text-danger m-0"><fmt:formatNumber value="${tong}" pattern="#,###"/> đ</h3>
                        </div>

                        <div class="stat-box gold">
                            <p class="mb-1 text-muted fs-7 fw-bold text-uppercase">Đã chi tiêu hôm nay</p>
                            <h4 class="fw-bold text-warning m-0"><fmt:formatNumber value="${tongHomNay}" pattern="#,###"/> đ</h4>
                        </div>

                        <hr class="my-4" style="border-color: #eee;">

                        <div class="d-flex align-items-start mb-3">
                            <i class="fa-solid fa-gem text-danger fs-4 me-3 mt-1" style="opacity: 0.8;"></i>
                            <div>
                                <p class="mb-0 text-muted fs-7">Món đắt đỏ nhất</p>
                                <h6 class="fw-bold text-dark m-0">${max}</h6>
                            </div>
                        </div>

                        <div class="d-flex align-items-start">
                            <i class="fa-solid fa-boxes-stacked text-warning fs-4 me-3 mt-1" style="opacity: 0.8;"></i>
                            <div>
                                <p class="mb-0 text-muted fs-7">Mua số lượng nhiều nhất</p>
                                <h6 class="fw-bold text-dark m-0">${topBuy}</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-md-7">
                
                <div class="card card-panel">
                    <div class="card-header bg-header-gold">
                        <h6 class="fs-7 m-0"><i class="fa-solid fa-filter me-2"></i>LỌC & TÌM KIẾM GIỎ HÀNG</h6>
                    </div>
                  <div class="filter-premium">
                            <form action="/sam-tet" method="get" class="m-0">
                                
                                <div class="row g-3 mb-3 align-items-end">
                                    <div class="col-md-4">
                                        <div class="filter-label-premium"><i class="fa-solid fa-magnifying-glass me-1 text-danger"></i> TỪ KHÓA TÌM KIẾM</div>
                                        <input type="text" name="keyword" class="form-control input-premium" placeholder="Nhập tên món đồ..." value="${keyword}">
                                    </div>
                                    <div class="col-md-4">
                                        <div class="filter-label-premium"><i class="fa-solid fa-arrow-down-short-wide me-1 text-danger"></i> SẮP XẾP HIỂN THỊ</div>
                                        <select name="sortOption" class="form-select input-premium text-secondary">
                                            <option value="ngayDat-desc" ${sortOption == 'ngayDat-desc' ? 'selected' : ''}>⏳ Mới nhất lên đầu</option>
                                            <option value="ngayDat-asc" ${sortOption == 'ngayDat-asc' ? 'selected' : ''}>⏳ Cũ nhất lên đầu</option>
                                            <option value="gia-desc" ${sortOption == 'gia-desc' ? 'selected' : ''}>💰 Giá: Cao xuống thấp</option>
                                            <option value="gia-asc" ${sortOption == 'gia-asc' ? 'selected' : ''}>💰 Giá: Thấp lên cao</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex gap-2 w-100">
                                            <button type="submit" class="btn btn-filter-primary btn-premium flex-grow-1 shadow-sm"><i class="fa-solid fa-filter me-1"></i> Áp dụng Lọc</button>
                                            <a href="/sam-tet" class="btn btn-light btn-premium border text-secondary shadow-sm" title="Xóa bộ lọc"><i class="fa-solid fa-rotate-right"></i></a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <div class="filter-label-premium"><i class="fa-solid fa-money-bill-wave me-1 text-success"></i> GIÁ TỪ (Đ)</div>
                                        <input type="number" name="minPrice" class="form-control input-premium" placeholder="0" value="${minPrice}">
                                    </div>
                                    <div class="col-md-3">
                                        <div class="filter-label-premium"><i class="fa-solid fa-money-bill-wave me-1 text-success"></i> ĐẾN GIÁ (Đ)</div>
                                        <input type="number" name="maxPrice" class="form-control input-premium" placeholder="Vô hạn..." value="${maxPrice}">
                                    </div>
                                    <div class="col-md-3">
                                        <div class="filter-label-premium"><i class="fa-regular fa-calendar-check me-1 text-primary"></i> TỪ NGÀY</div>
                                        <input type="date" name="fromDate" class="form-control input-premium text-secondary" value="${fromDate}">
                                    </div>
                                    <div class="col-md-3">
                                        <div class="filter-label-premium"><i class="fa-regular fa-calendar-xmark me-1 text-primary"></i> ĐẾN NGÀY</div>
                                        <input type="date" name="toDate" class="form-control input-premium text-secondary" value="${toDate}">
                                    </div>
                                </div>
                                
                            </form>
                        </div>
                </div>

                <div class="card card-panel">
                    <div class="card-header bg-white pt-3 border-0 d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold m-0" style="color: var(--tet-red-dark);"><i class="fa-solid fa-list-check me-2 text-warning"></i>CHI TIẾT SẮM TẾT CỦA BẠN</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-minimal text-center align-middle m-0">
                                <thead>
                                    <tr>
                                        <th style="width: 8%;">STT</th>
                                        <th class="text-start p-2">Tên món đồ</th>
                                        <th style="width: 18%;">Đơn giá</th>
                                        <th style="width: 8%;">SL</th>
                                        <th style="width: 20%;">Thành tiền</th>
                                        <th style="width: 20%;">Thời gian mua</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${list}" varStatus="loop">
                                        <tr>
                                            <td class="fw-bold text-secondary fs-7">${currentPage * 10 + loop.index + 1}</td>
                                            <td class="text-start p-2 fw-bold text-dark">${item.tenMon}</td>
                                            <td><fmt:formatNumber value="${item.gia}" pattern="#,###"/> đ</td>
                                            <td><span class="badge bg-light text-danger border rounded-pill">${item.soLuong}</span></td>
                                            <td class="text-danger fw-bold"><fmt:formatNumber value="${item.gia * item.soLuong}" pattern="#,###"/> đ</td>
                                            <td class="text-muted fs-8">
                                                <fmt:formatDate value="${item.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty list}">
                                        <tr><td colspan="6" class="text-center text-muted py-5"><i class="fa-solid fa-box-open fs-1 text-light mb-3 d-block"></i> Không tìm thấy món đồ nào khớp với bộ lọc!</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <c:if test="${totalPages > 1}">
                        <div class="card-footer bg-white border-0 pt-0 pb-4 text-center">
                            <ul class="pagination pagination-sm justify-content-center m-0">
                                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" 
                                           href="/sam-tet?page=${i}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}&fromDate=${fromDate}&toDate=${toDate}&sortOption=${sortOption}">
                                           ${i + 1}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </div>

            </div>
        </div>
    </div>
</body>
</html>