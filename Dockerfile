# Sử dụng môi trường có sẵn Java 17 và Maven
FROM maven:3.8.5-openjdk-17
WORKDIR /app

# Copy toàn bộ code từ máy bạn vào môi trường của Render
COPY . .

# Đóng gói project thành file .war (bỏ qua test)
RUN mvn clean package -DskipTests

# Lệnh khởi động server khi code đã đóng gói xong
CMD ["java", "-jar", "target/QuanLyDanhSachDoTet-0.0.1-SNAPSHOT.war"]
