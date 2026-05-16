<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng ký - Sắm Tết 2026</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { 
            background-color: #fff5f5; 
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-card {
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            border: none;
        }
        .card-header-custom {
            background: linear-gradient(135deg, #198754, #20c997); /* Dùng màu xanh lá để phân biệt với Đăng nhập */
            border-radius: 15px 15px 0 0 !important;
            padding: 25px 20px;
        }
        .input-group-text { background-color: #f8f9fa; border-right: none; }
        .form-control { border-left: none; }
        .form-control:focus { box-shadow: none; border-color: #ced4da; }
    </style>
</head>
<body>
    <div class="card shadow-lg register-card">
        <div class="card-header-custom text-center text-white">
            <h3 class="mb-1 fw-bold"><i class="fa-solid fa-user-plus text-warning"></i> TẠO TÀI KHOẢN</h3>
            <p class="mb-0" style="font-size: 0.9rem; opacity: 0.9;">Gia nhập hệ thống sắm Tết</p>
        </div>
        
        <div class="card-body p-4">
            <c:if test="${param.error == 'exists'}">
                <div class="alert alert-warning d-flex align-items-center py-2" role="alert">
                    <i class="fa-solid fa-bell me-2"></i> Tên tài khoản này đã có người sử dụng!
                </div>
            </c:if>

            <form action="/register" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary">Tên đăng nhập mới</label>
                    <div class="input-group">
                        <span class="input-group-text text-success"><i class="fa-solid fa-id-card"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Ví dụ: trieu2026..." required autofocus>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary">Tạo mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text text-success"><i class="fa-solid fa-key"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu an toàn..." required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-success w-100 fw-bold py-2 mb-3 shadow-sm" style="border-radius: 8px;">
                    <i class="fa-solid fa-check"></i> XÁC NHẬN ĐĂNG KÝ
                </button>
            </form>
            
            <div class="text-center mt-3">
                <span class="text-muted">Đã có tài khoản? </span>
                <a href="/login" class="text-success fw-bold text-decoration-none hover-underline">Quay lại đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>