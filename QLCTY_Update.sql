DROP DATABASE IF EXISTS QLCTY
GO

CREATE DATABASE QLCTY
ON PRIMARY 
(NAME=QLCTY_Data, FILENAME ='D:\QLCT_Data.mdf', SIZE=10MB, MAXSIZE=25MB, FILEGROWTH=2MB)
LOG ON
(NAME=QLCTY_Log, FILENAME = 'D:\QLCT_Log.ldf', SIZE=3MB, MAXSIZE=5MB, FILEGROWTH=1MB);
GO

USE QLCTY
GO
-- Bảng Phòng Ban
CREATE TABLE PHONGBAN (
    MaPB INT PRIMARY KEY,
    TenPB VARCHAR(100) not null,
    SoDienThoai VARCHAR(20)
)
GO
-- Bảng Nhân Viên
CREATE TABLE NHANVIEN (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(100) not null,
    NgaySinh DATETIME,
    CongViec VARCHAR(25),
    MaPB INT FOREIGN KEY REFERENCES PHONGBAN(MaPB)
)
GO
-- Bảng Vợ/Chồng, thêm ràng buộc để tránh ghi trùng (NV1,NV2) và (NV2,NV1)
CREATE TABLE VOCHONG (
    MaNV INT FOREIGN KEY REFERENCES NHANVIEN(MaNV),
    MaVC INT FOREIGN KEY REFERENCES NHANVIEN(MaNV),
    HoTenVC VARCHAR(40) not null,
    NgayKetHon DATETIME,
    CONSTRAINT PK_VOCHONG PRIMARY KEY (MaNV, MaVC),
	CONSTRAINT CK_VOCHONG_CHECK CHECK (MaNV < MaVC)
)
GO
-- Bảng Nhà Cung Cấp
CREATE TABLE NHACUNGCAP (
    MaNCC INT PRIMARY KEY,
    TenNCC VARCHAR(40) not null,
    DiaChi VARCHAR(100)
)
GO
-- Bảng ChiTiet_CungCapThietBi
CREATE TABLE CHITIET_CUNGCAPTHIETBI ( 
    MaPB INT FOREIGN KEY REFERENCES PHONGBAN(MaPB),
    MaNCC INT FOREIGN KEY REFERENCES NHACUNGCAP(MaNCC),
    NgayLamViecGanNhat DATETIME,
	constraint PK_CHITIET_CUNGCAPTHIETBI primary key (MaPB, MaNCC)
)
GO
-- Bảng Dự Án
CREATE TABLE DUAN (
    MaDA INT PRIMARY KEY,
    TenDA VARCHAR(20) not null,
    TieuBang VARCHAR(20),
    ThanhPho VARCHAR(25),
    DanSo INT,
    TongKinhPhiUocDoan DECIMAL(20)
)
GO
-- Bảng Tham Gia Dự Án
Create table THAMGIA_DUAN
(
MaNV INT foreign key references NHANVIEN(MaNV),
MaDA INT foreign key references DUAN(MaDA),
constraint PK_THAMGIA_DUAN primary key (MaNV, MaDA)
)
GO
-- Bảng Kỹ Năng
CREATE TABLE KYNANG (
    MaKN INT PRIMARY KEY,
    TenKN VARCHAR(50) not null,
	ChuThich VARCHAR(200)
)
GO
-- Bảng Nhân Viên Kỹ Năng
Create table NHANVIEN_KYNANG
(
MaNV INT foreign key references NHANVIEN(MaNV),
MaKN INT foreign key references KYNANG(MaKN),
MucDo INT,
constraint PK_NHANVIEN_KYNANG primary key (MaNV,MaKN)
)
GO
-- Bảng Dự Án Kỹ Năng
CREATE TABLE DUAN_KYNANG (
    MaDA INT foreign key references DUAN(MaDA),
	MaKN INT foreign key references KYNANG(MaKN),
	constraint PK_DUAN_KYNANG primary key (MaDA, MaKN)
)
GO
INSERT INTO PHONGBAN (MaPB, TenPB, SoDienThoai) VALUES
(1, 'Phong Ky thuat', '0281111111'),
(2, 'Phong Hanh chinh', '0282222222'),
(3, 'Phong CNTT', '0283333333'),
(4, 'Phong Ke toan', '0284444444'),
(5, 'Phong Du an', '0285555555')
GO
INSERT INTO NHANVIEN (MaNV, HoTen, NgaySinh, CongViec, MaPB) VALUES
(1, 'Nguyen Van A', '1990-01-01', 'Ky su', 1),
(2, 'Tran Thi B', '1992-03-15', 'Thu ky', 2),
(3, 'Le Van C', '1988-07-10', 'Lap trinh vien', 3),
(4, 'Pham Thi D', '1995-11-20', 'Ke toan', 4),
(5, 'Hoang Van E', '1991-05-05', 'Quan ly', 5),
(6, 'Nguyen Thi F', '1993-02-25', 'Chuyen vien', 1),
(7, 'Pham Van G', '1987-08-14', 'Ky su truong', 2),
(8, 'Tran Thi H', '1994-12-01', 'Tro ly du an', 3),
(9, 'Le Van I', '1990-06-18', 'Ke hoach tai chinh', 4),
(10, 'Do Thi K', '1996-09-09', 'Nhan vien hanh chinh', 5)
GO
INSERT INTO VOCHONG (MaNV, MaVC, HoTenVC, NgayKetHon) VALUES
(1, 2, 'Nguyen Van A', '2018-06-01'),
(3, 4, 'Le Van C', '2019-09-10'),
(5, 6, 'Hoang Van E', '2020-12-15'),
(7, 8, 'Pham Van G', '2021-08-08'),
(9, 10, 'Le Van I', '2017-03-22')
GO
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiaChi) VALUES
(1, 'Cong ty A', 'Ha Noi'),
(2, 'Cong ty B', 'TP.HCM'),
(3, 'Cong ty C', 'Da Nang'),
(4, 'Cong ty D', 'Hue'),
(5, 'Cong ty E', 'Can Tho')
GO
INSERT INTO CHITIET_CUNGCAPTHIETBI (MaPB, MaNCC, NgayLamViecGanNhat) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-02-20'),
(3, 3, '2024-03-25'),
(4, 4, '2024-04-10'),
(5, 5, '2024-05-05')
GO
INSERT INTO DUAN (MaDA, TenDA, TieuBang, ThanhPho, DanSo, TongKinhPhiUocDoan ) VALUES
(101, 'Du an 1', 'California', 'Los Angeles', 4000000, 500000000),
(102, 'Du an 2', 'California', 'Los Angeles', 4000000, 4500000000),
(103, 'Du an 3', 'Texas', 'Houston', 2300000, 2000000000),
(104, 'Du an 4', 'Texas', 'Houston', 2300000, 1500000000),
(105, 'Du an 5', 'New York', 'New York City', 8500000, 60000000000)
GO
INSERT INTO THAMGIA_DUAN(MaNV, MaDA) VALUES
(1, 101),
(5, 101),
(2, 102),
(6, 102),
(1, 103),
(7, 103),
(8, 103),
(3, 104),
(9, 104),
(4, 105),
(10, 105)
GO
INSERT INTO KYNANG (MaKN, TenKN, ChuThich) VALUES
(1, 'Lap ke hoach vat tu', 'Len ke hoach va quan ly nguon vat tu can thiet cho du an, dam bao tien do cung ung.'),
(2, 'Kiem tra ban ve', 'Kiem tra va ra soat ban ve ky thuat de phat hien sai sot va dam bao tinh chinh xac.'),
(3, 'Quan li du an', 'Lap ke hoach, giam sat va dieu phoi cac cong viec trong du an nham dat muc tieu de ra.'),
(4, 'Phan tich du lieu', 'Thu thap va phan tich du lieu nham ho tro ra quyet dinh va toi uu quy trinh.'),
(5, 'Thiet ke he thong', 'Thiet ke cau truc he thong phan mem hoac ky thuat, dam bao tinh kha thi va hieu qua.')
GO
INSERT INTO NHANVIEN_KYNANG(MaNV, MaKN, MucDo) VALUES
(1, 1, 3),
(1, 2, 2),
(2, 3, 4),
(2, 5, 2),
(3, 2, 2),
(3, 1, 2),
(4, 4, 1),
(4, 2, 1),
(5, 5, 5),
(5, 3, 5),
(6, 1, 4),
(6, 4, 3),
(7, 2, 5),
(7, 3, 4),
(8, 5, 2),
(8, 1, 3),
(9, 4, 5),
(9, 2, 4),
(10, 3, 3),
(10, 5, 2)
GO
INSERT INTO DUAN_KYNANG (MaDA, MaKN) VALUES
(101, 1),
(101, 2),
(101, 3),
(101, 5),
(102, 1),
(102, 3),
(102, 4),
(102, 5),
(103, 1),
(103, 2),
(103, 3),
(103, 5),
(104, 1),
(104, 2),
(104, 4),
(105, 2),
(105, 3),
(105, 4),
(105, 5)

--ĐẶT CÂU HỎI
--1. Danh sách nhân viên thuộc phòng CNTT
SELECT NV.MaNV, NV.HoTen, PB.TenPB
FROM NhanVien NV JOIN PhongBan PB ON NV.MaPB = PB.MaPB
WHERE PB.TenPB = 'Phong CNTT'
--kq: 2 rows
--2. Danh sách các nhân viên có tất cả các kỹ năng mà dự án 1 yêu cầu
SELECT NV.MaNV, NV.HoTen
FROM NHANVIEN NV
WHERE NOT EXISTS (
    SELECT *
    FROM DUAN_KYNANG DK
    JOIN DUAN DA ON DA.MaDA = DK.MaDA
    WHERE DA.TenDA = 'Du an 1'
    AND NOT EXISTS (
        SELECT *
        FROM NHANVIEN_KYNANG NK
        WHERE NK.MaNV = NV.MaNV
        AND NK.MaKN = DK.MaKN))
--kq: 0 row
--3. Hãy liệt kê tên các nhân viên, tên phòng ban họ đang làm việc, và tên nhà cung cấp đã cung cấp thiết bị cho phòng ban đó, 
--với điều kiện tên nhà cung cấp bắt đầu bằng "Cong ty A".
SELECT nv.HoTen AS TenNhanVien, pb.TenPB AS TenPhongBan, ncc.TenNCC AS TenNhaCungCap
FROM NHANVIEN nv
JOIN PHONGBAN pb ON nv.MaPB = pb.MaPB
JOIN CHITIET_CUNGCAPTHIETBI cc ON pb.MaPB = cc.MaPB
JOIN NHACUNGCAP ncc ON cc.MaNCC = ncc.MaNCC
WHERE ncc.TenNCC LIKE N'Cong ty A%'
GO
--kq: 2 rows
--4. Liệt kê mã số, họ tên của các nhân viên đã tham gia dự án ở nhiều hơn 2 thành phố khác nhau,chỉ những nhân viên thuộc phòng ban "Phòng Dự án".
SELECT nv.MaNV, nv.HoTen, COUNT(DISTINCT da.ThanhPho) AS SoThanhPho
FROM NHANVIEN nv
JOIN PHONGBAN pb ON nv.MaPB = pb.MaPB
JOIN THAMGIA_DUAN tg ON nv.MaNV = tg.MaNV
JOIN DUAN da ON tg.MaDA = da.MaDA
WHERE pb.TenPB = N'Phong Du an'
GROUP BY nv.MaNV, nv.HoTen
HAVING COUNT(DISTINCT da.ThanhPho) > 2
GO
--kq: 0 row
--5. Liệt kê các phòng ban (TenPB) và số lượng nhân viên tham gia các dự án ở thành phố "Los Angeles", đồng thời phòng ban đó phải có nhà cung cấp thiết bị 
--làm việc gần nhất trong năm 2024.
SELECT PB.TenPB, COUNT(DISTINCT NV.MaNV) AS SoLuongNhanVien
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.MaPB = NV.MaPB
JOIN THAMGIA_DUAN TGDA ON NV.MaNV = TGDA.MaNV
JOIN DUAN DA ON TGDA.MaDA = DA.MaDA
JOIN CHITIET_CUNGCAPTHIETBI CCTB ON PB.MaPB = CCTB.MaPB
WHERE DA.ThanhPho = 'Los Angeles'
  AND YEAR(CCTB.NgayLamViecGanNhat) = 2024
GROUP BY PB.TenPB
HAVING COUNT(DISTINCT NV.MaNV) > 0
--kq: 3 rows
--6. Liệt kê từng nhà cung cấp và tổng số nhân viên thuộc các phòng ban mà nhà cung cấp đó đã hợp tác, sắp xếp theo tổng số nhân viên giảm dần.
SELECT NCC.TenNCC, COUNT(DISTINCT NV.MaNV) AS TongSoNhanVien
FROM NHACUNGCAP NCC
JOIN CHITIET_CUNGCAPTHIETBI CCTB ON NCC.MaNCC = CCTB.MaNCC
JOIN PHONGBAN PB ON CCTB.MaPB = PB.MaPB
JOIN NHANVIEN NV ON PB.MaPB = NV.MaPB
GROUP BY NCC.TenNCC
ORDER BY TongSoNhanVien DESC
--kq: 5 rows
--7. Xóa những dự án có dân số < 1 triệu và không có bất kỳ kỹ năng nào được yêu cầu.
DELETE FROM DUAN
WHERE DanSo < 1000000 
AND MaDA NOT IN ( 
SELECT DISTINCT MaDA
FROM DUAN_KYNANG )
--Kiểm tra lại
SELECT *FROM DUAN WHERE DanSo < 1000000
--kq: 0 row
--8. Xóa các kĩ năng không được bất kì nhân viên hay dự án nào sử dụng
DELETE FROM KYNANG
WHERE MaKN NOT IN (
SELECT DISTINCT MaKN FROM NHANVIEN_KYNANG
UNION
SELECT DISTINCT MaKN FROM DUAN_KYNANG
)
--Kiểm tra lại
SELECT * FROM KYNANG
--kq: 5 rows (Tất cả kỹ năng hiện có trong bảng KYNANG đều đang được sử dụng bởi ít nhất một nhân viên hoặc một dự án)
--9. Cập nhật số điện thoại của phòng ban '5' thành '0289999999'
UPDATE PHONGBAN
SET SoDienThoai = '0289999999'
WHERE MaPB = '5'
--Kiểm tra lại
SELECT * FROM PHONGBAN WHERE MaPB = 5
--kq: 1 row
--10. Cập nhật công việc thành 'Chuyên viên cao cấp' cho các nhân viên thuộc phòng ban có trung bình tuổi nhân viên từ trên 35
UPDATE NHANVIEN
SET CongViec = 'Chuyen vien cao cap'
WHERE MaPB IN (
SELECT MaPB
FROM NHANVIEN
GROUP BY MaPB
HAVING AVG(DATEDIFF(YEAR, NgaySinh, GETDATE())) >= 35 )
--Kiểm tra lại
SELECT MaNV, HoTen, MaPB FROM NHANVIEN WHERE CongViec = 'Chuyen vien cao cap'
--kq: 2 rows
--2	Tran Thi B		2
--7	Pham Van G	2
--11. Liệt kê các nhân viên có mức độ kỹ năng cao hơn mức độ kỹ năng trung bình của tất cả nhân viên. Thông tin gồm MaNV, HoTen, MucDoKyNang. Được sắp xếp theo MaNV.
SELECT NV.MaNV, NV.HoTen, NVKN.MaKN, NVKN.MucDo AS MucDoKyNang
FROM NHANVIEN NV
JOIN NHANVIEN_KYNANG NVKN ON NV.MaNV = NVKN.MaNV
WHERE NVKN.MucDo > (
SELECT AVG(MucDo)
FROM NHANVIEN_KYNANG )
ORDER BY NV.MaNV
go
--kq: 8 rows
--12. Liệt kê các nhân viên chưa từng tham gia vào bất kỳ dự án nào ở  ‘New York City’.
SELECT NV.MaNV, NV.HoTen
FROM NHANVIEN NV
WHERE NV.MaNV NOT IN (
SELECT DISTINCT TG.MaNV
FROM THAMGIA_DUAN TG
JOIN DUAN DA ON TG.MaDA = DA.MaDA
WHERE DA.ThanhPho = 'New York City')
go  
--kq: 8 rows
