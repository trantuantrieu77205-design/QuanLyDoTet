<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Giỏ Đồ Khách: ${targetUser} | Admin Tết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
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
        body { background-color: var(--bg-main); font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #4a4a4a;}
        
        /* Navbar */
        .navbar-admin {
            background-image: var(--primary-gradient) !important;
            box-shadow: 0 4px 12px rgba(138, 3, 3, 0.15) !important;
            border-bottom: 2px solid var(--tet-gold-light);
        }
        .navbar-admin .navbar-brand { color: white !important; font-weight: 900;}

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
        .card-panel .card-header h6 { margin: 0; font-weight: bold; color: white;}
        
        /* Màu Header Panels */
        .bg-header-red { background-image: var(--primary-gradient);}
        .bg-header-gold { background-image: var(--gold-gradient); color: #fff !important;}

        /* Header Giỏ Hàng */
        .user-cart-header {
            background-color: #fff;
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
            margin-bottom: 1.5rem;
            border-left: 5px solid var(--tet-red-light);
        }

        .stat-badge-light {
            background-color: var(--bg-main);
            color: #333;
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            border: 1px solid #f1f2f6;
        }

        .btn-print {
            background-image: var(--gold-gradient);
            border: none;
            color: #fff;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .btn-print:hover { transform: translateY(-2px); color: #fff; opacity: 0.9;}

        /* Inputs */
        .form-control-sm, .form-select-sm, .input-group-text-sm { border-radius: 0.25rem;}
        
        /* Table */
        .table-minimal { font-size: 0.9rem;}
        .table-minimal thead th {
            font-size: 0.75rem;
            text-transform: uppercase;
            background-color: #faf8f5;
            color: var(--tet-red-dark);
            border-bottom: 2px solid #f1f2f6;
        }
        .table-minimal tbody tr { border-bottom: 1px solid #f1f2f6;}
        .table-minimal tbody tr:hover { background-color: #fdfbf7;}
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-admin">
        <div class="container">
            <span class="navbar-brand fw-bold text-uppercase"><i class="fa-solid fa-fan me-2 text-warning"></i>Khách: ${targetUser}</span>
            <div class="d-flex align-items-center">
                <a href="/admin/customers" class="btn btn-light btn-sm fw-bold rounded-pill me-2 text-danger"><i class="fa-solid fa-users me-1"></i> Khách Hàng</a>
                <a href="/logout" class="btn btn-outline-light btn-sm fw-bold rounded-pill"><i class="fa-solid fa-right-from-bracket me-1"></i> Thoát</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        
        <div class="user-cart-header d-flex justify-content-between align-items-center flex-wrap g-3">
            <div>
                <span class="text-muted fs-7">Giỏ đồ sắm Tết của khách:</span>
                <h2 class="fw-bold m-0 text-uppercase" style="color: var(--tet-red-dark);">${targetUser}</h2>
            </div>
            <div class="d-flex align-items-center flex-wrap gap-2 justify-content-end">
                <div class="stat-badge-light text-end me-3">
                    <div class="text-muted fs-7">Cấp đồ trong hôm nay:</div>
                    <div class="fw-bold text-danger fs-4"><fmt:formatNumber value="${userTongHomNay}" pattern="#,###"/> đ</div>
                </div>
                <div>
                    <a href="/admin/print-invoice/${targetUser}" target="_blank" class="btn btn-print rounded-pill fw-bold fs-7 px-4 shadow">
                        <i class="fa-solid fa-print me-1"></i> IN HÓA ĐƠN
                    </a>
                </div>
            </div>
        </div>

        <div class="row g-2 mb-4 no-print">
            <div class="col-6">
                <div class="badge bg-white text-dark w-100 p-3 border shadow-sm text-start text-truncate">
                    <i class="fa-solid fa-gem text-danger me-1"></i> <span class="text-muted">Đắt nhất:</span> <b class="text-danger">${userMax}</b>
                </div>
            </div>
            <div class="col-6">
                <div class="badge bg-white text-dark w-100 p-3 border shadow-sm text-start text-truncate">
                    <i class="fa-solid fa-boxes-stacked text-warning me-1"></i> <span class="text-muted">Mua nhiều nhất:</span> <b class="text-warning">${userTopBuy}</b>
                </div>
            </div>
        </div>

        <c:if test="${param.error == 'invalid-price'}">
            <div class="alert alert-danger alert-dismissible fade show shadow py-2" role="alert">
                <strong>Lỗi nhập liệu!</strong> Giá tiền phải <b>> 5.000đ</b>, <b>< 10 tỷ</b> và <b>tròn nghìn</b>.
                <button type="button" class="btn-close pb-2" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-lg-4 col-md-5 no-print">
                <div class="card card-panel border-0">
                    <div class="card-header bg-header-red">
                        <h6 class="fs-7"><i class="fa-solid fa-cart-plus me-2 text-warning"></i>CẤP PHÁT MÓN TẾT</h6>
                    </div>
                    <div class="card-body p-3">
                        <form action="/admin/add-item" method="post" class="m-0">
                            <input type="hidden" name="username" value="${targetUser}">
                            <div class="mb-2">
                                <input type="text" name="tenMon" class="form-control form-control-sm" placeholder="Tên món (Hạt dưa, mứt...)" required>
                            </div>
                            <div class="row g-2 mb-2">
                                <div class="col-8">
                                    <div class="input-group input-group-sm">
                                        <input type="number" name="gia" class="form-control" placeholder="Giá" min="6000" max="9999999000" step="1000" required>
                                        <span class="input-group-text bg-light text-danger fw-bold">đ</span>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <input type="number" name="soLuong" class="form-control form-control-sm" value="1" min="1" title="Số lượng" required>
                                </div>
                            </div>
                            <div class="d-grid mt-3">
                                <button type="submit" class="btn btn-danger btn-sm fw-bold rounded-pill shadow-sm" style="background-color: var(--tet-red-light);"><i class="fa-solid fa-plus me-1"></i> Thêm vào giỏ</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card card-panel border-0">
                    <div class="card-header bg-header-gold text-white">
                        <h6 class="fs-7 text-white"><i class="fa-solid fa-filter me-2"></i>LỌC TÌM KIẾM</h6>
                    </div>
                    <div class="card-body p-3">
                        <form action="/admin/detail/${targetUser}" method="get" class="m-0">
                            <div class="mb-2">
                                <input type="text" name="keyword" class="form-control form-control-sm" placeholder="Tìm tên món..." value="${keyword}">
                            </div>
                            <div class="row g-2 mb-2">
                                <div class="col-6"><input type="number" name="minPrice" class="form-control form-control-sm" placeholder="Từ đ..." value="${minPrice}"></div>
                                <div class="col-6"><input type="number" name="maxPrice" class="form-control form-control-sm" placeholder="Đến đ..." value="${maxPrice}"></div>
                            </div>
                            <div class="row g-2 mb-2">
                                <div class="col-6"><input type="date" name="fromDate" class="form-control form-control-sm" value="${fromDate}"></div>
                                <div class="col-6"><input type="date" name="toDate" class="form-control form-control-sm" value="${toDate}"></div>
                            </div>
                            <div class="mb-2">
                                <select name="sortOption" class="form-select form-select-sm">
                                    <option value="ngayDat-desc" ${sortOption == 'ngayDat-desc' ? 'selected' : ''}>Mới thêm trước</option>
                                    <option value="ngayDat-asc" ${sortOption == 'ngayDat-asc' ? 'selected' : ''}>Cũ nhất trước</option>
                                    <option value="gia-desc" ${sortOption == 'gia-desc' ? 'selected' : ''}>Giá cao => thấp</option>
                                    <option value="gia-asc" ${sortOption == 'gia-asc' ? 'selected' : ''}>Giá thấp => cao</option>
                                </select>
                            </div>
                            <div class="d-flex gap-1 mt-3">
                                <button type="submit" class="btn btn-warning text-dark btn-sm fw-bold flex-grow-1 rounded-pill"><i class="fa-solid fa-check me-1"></i> Áp dụng</button>
                                <a href="/admin/detail/${targetUser}" class="btn btn-secondary btn-sm rounded-pill"><i class="fa-solid fa-rotate-right"></i></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-md-7">
                <div class="card card-panel">
                    <div class="card-header bg-white pt-3 border-0 d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold m-0" style="color: var(--tet-red-dark);"><i class="fa-solid fa-list me-2"></i>CHI TIẾT SẮM TẾT</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-minimal text-center align-middle m-0">
                                <thead>
                                    <tr>
                                        <th style="width: 7%;">STT</th>
                                        <th class="text-start p-2">Món Đồ</th>
                                        <th style="width: 15%;">Đơn Giá</th>
                                        <th style="width: 8%;">SL</th>
                                        <th style="width: 15%;">Thành Tiền</th>
                                        <th style="width: 18%;">Ngày Mua</th>
                                        <th style="width: 15%;" class="no-print">Thao Tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${items}" varStatus="loop">
                                        <tr>
                                            <td class="text-secondary fw-bold fs-7">${currentPage * 10 + loop.index + 1}</td>
                                            <td class="text-start p-2 fw-bold text-dark">${item.tenMon}</td>
                                            <td class="text-dark"><fmt:formatNumber value="${item.gia}" pattern="#,###"/></td>
                                            <td><span class="badge bg-light text-danger border rounded-pill">${item.soLuong}</span></td>
                                            <td class="text-danger fw-bold"><fmt:formatNumber value="${item.gia * item.soLuong}" pattern="#,###"/></td>
                                            <td class="text-muted fs-8">
                                                <fmt:formatDate value="${item.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td class="no-print">
                                                <button class="btn btn-outline-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal${item.id}">
                                                    <i class="fa-solid fa-pen"></i>
                                                </button>
                                                <a href="/admin/delete-item/${item.id}" class="btn btn-outline-danger btn-sm" onclick="return confirm('Xóa món này khỏi giỏ?')">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>

                                        <div class="modal fade" id="editModal${item.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered modal-sm">
                                                <div class="modal-content border-0">
                                                    <form action="/admin/edit-item" method="post">
                                                        <div class="modal-header bg-warning py-2 text-dark border-0">
                                                            <h6 class="modal-title fw-bold m-0"><i class="fa-solid fa-pen"></i> Sửa món</h6>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body text-start p-3">
                                                            <input type="hidden" name="id" value="${item.id}">
                                                            <input type="hidden" name="username" value="${targetUser}">
                                                            <div class="mb-2">
                                                                <label class="form-label fw-bold text-secondary fs-8 mb-1">Món Tết</label>
                                                                <input type="text" name="tenMon" class="form-control form-control-sm" value="${item.tenMon}" required>
                                                            </div>
                                                            <div class="row g-2">
                                                                <div class="col-8">
                                                                    <label class="form-label fw-bold text-secondary fs-8 mb-1">Giá (tròn nghìn)</label>
                                                                    <input type="number" name="gia" class="form-control form-control-sm" value="${item.gia}" min="6000" max="9999999000" step="1000" required>
                                                                </div>
                                                                <div class="col-4">
                                                                    <label class="form-label fw-bold text-secondary fs-8 mb-1">SL</label>
                                                                    <input type="number" name="soLuong" class="form-control form-control-sm" value="${item.soLuong}" min="1" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer p-2 bg-light border-0">
                                                            <button type="button" class="btn btn-light btn-sm rounded-pill" data-bs-dismiss="modal">Thôi</button>
                                                            <button type="submit" class="btn btn-warning btn-sm text-dark fw-bold rounded-pill shadow-sm"><i class="fa-solid fa-save"></i> Lưu</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty items}">
                                        <tr><td colspan="7" class="text-center text-muted py-4">Giỏ đồ trống.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <c:if test="${totalPages > 1}">
                        <div class="card-footer bg-white border-0 pt-0 pb-4 no-print text-center">
                            <ul class="pagination pagination-sm justify-content-center m-0">
                                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="/admin/detail/${targetUser}?page=${i}&keyword=${keyword}&minPrice=${minPrice}&maxPrice=${maxPrice}&fromDate=${fromDate}&toDate=${toDate}&sortOption=${sortOption}">${i + 1}</a>
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