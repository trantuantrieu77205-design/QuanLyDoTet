<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Hóa Đơn - ${targetUser}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Times New Roman', serif; }
        .invoice-box {
            max-width: 800px; margin: 40px auto; padding: 40px;
            background: white; border: 1px solid #ddd;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .invoice-header { border-bottom: 2px solid #333; padding-bottom: 15px; margin-bottom: 20px; }
        .table th { background-color: #f2f2f2 !important; color: #333 !important; font-weight: bold; }
        
        /* Chỉnh CSS riêng cho lúc in giấy */
        @media print {
            body { background-color: white; }
            .invoice-box { box-shadow: none; border: none; margin: 0; padding: 0; }
            .no-print { display: none !important; } /* Ẩn các nút bấm khi in */
        }
    </style>
</head>
<body onload="window.print()"> <div class="invoice-box">
        <div class="invoice-header d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-bold mb-0">HÓA ĐƠN BÁN LẺ</h2>
                <p class="mb-0 text-muted" style="font-size: 1.1rem;">Đại lý Sắm Tết 2026</p>
            </div>
            <div class="text-end">
                <p class="mb-1"><strong>Khách hàng:</strong> <span class="text-uppercase">${targetUser}</span></p>
                <p class="mb-0 text-muted"><strong>Ngày in:</strong> <fmt:formatDate value="${printDate}" pattern="dd/MM/yyyy HH:mm"/></p>
            </div>
        </div>

        <table class="table table-bordered text-center align-middle mt-4">
            <thead>
                <tr>
                    <th style="width: 10%;">STT</th>
                    <th class="text-start">Tên Sản Phẩm</th>
                    <th style="width: 20%;">Đơn Giá</th>
                    <th style="width: 15%;">Số Lượng</th>
                    <th style="width: 20%;">Thành Tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${items}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td class="text-start">${item.tenMon}</td>
                        <td><fmt:formatNumber value="${item.gia}" pattern="#,###"/></td>
                        <td>${item.soLuong}</td>
                        <td class="fw-bold"><fmt:formatNumber value="${item.gia * item.soLuong}" pattern="#,###"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty items}">
                    <tr><td colspan="5" class="py-3 text-muted">Không có sản phẩm nào.</td></tr>
                </c:if>
            </tbody>
        </table>

        <div class="d-flex justify-content-end mt-4">
            <div class="text-end" style="width: 300px;">
                <h5 class="d-flex justify-content-between">
                    <span>Tổng cộng:</span> 
                    <span class="fw-bold"><fmt:formatNumber value="${total}" pattern="#,###"/> VNĐ</span>
                </h5>
                <hr>
                <h4 class="d-flex justify-content-between text-danger fw-bold mt-2">
                    <span>Thanh toán:</span> 
                    <span><fmt:formatNumber value="${total}" pattern="#,###"/> VNĐ</span>
                </h4>
            </div>
        </div>
        
        <div class="text-center mt-5">
            <p class="fst-italic text-muted">Cảm ơn quý khách và chúc mừng năm mới!</p>
        </div>

        <div class="text-center mt-5 no-print">
            <button onclick="window.print()" class="btn btn-primary me-2"><i class="fa-solid fa-print"></i> In lại Hóa Đơn</button>
            <button onclick="window.close()" class="btn btn-secondary"><i class="fa-solid fa-xmark"></i> Đóng</button>
        </div>
    </div>
</body>
</html>