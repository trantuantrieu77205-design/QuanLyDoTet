<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập - Sắm Tết 2026</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { 
            background-color: #fff5f5; /* Màu nền đỏ nhạt cho không khí Tết */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            border: none;
        }
        .card-header-custom {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border-radius: 15px 15px 0 0 !important;
            padding: 25px 20px;
        }
        .input-group-text {
            background-color: #f8f9fa;
            border-right: none;
        }
        .form-control {
            border-left: none;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #ced4da;
        }
    </style>
</head>
<body>
    <div class="card shadow-lg login-card">
        <div class="card-header-custom text-center text-white">
            <h3 class="mb-1 fw-bold text-warning"><i class="fa-solid fa-fire"></i> MÙA TẾT 2026</h3>
            <p class="mb-0" style="font-size: 0.9rem; opacity: 0.9;">Đăng nhập để chuẩn bị sắm sửa</p>
        </div>
        
        <div class="card-body p-4">
            <c:if test="${param.error != null}">
                <div class="alert alert-danger d-flex align-items-center py-2" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> Sai tài khoản hoặc mật khẩu!
                </div>
            </c:if>
            
            <c:if test="${param.success != null}">
                <div class="alert alert-success d-flex align-items-center py-2" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i> Đăng ký thành công! Hãy đăng nhập.
                </div>
            </c:if>

            <form action="/login" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary">Tên tài khoản</label>
                    <div class="input-group">
                        <span class="input-group-text text-danger"><i class="fa-solid fa-user"></i></span>
                        <input type="text" name="username" class="form-control" placeholder="Nhập tài khoản..." required autofocus>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary">Mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text text-danger"><i class="fa-solid fa-lock"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-danger w-100 fw-bold py-2 mb-3 shadow-sm" style="border-radius: 8px;">
                    <i class="fa-solid fa-right-to-bracket"></i> VÀO HỆ THỐNG
                </button>
            </form>
            
            <div class="text-center mt-3">
                <span class="text-muted">Chưa có tài khoản? </span>
                <a href="/register" class="text-danger fw-bold text-decoration-none hover-underline">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</body>
</html>