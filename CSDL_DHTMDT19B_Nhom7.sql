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
(1, 102),
(2, 103),
(3, 104),
(4, 105)
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
(5, 3, 5)
GO
INSERT INTO DUAN_KYNANG (MaDA, MaKN) VALUES
(101, 1),
(101, 2),
(102, 1),
(102, 2),
(103, 3),
(103, 5),
(104, 2),
(104, 1),
(105, 4),
(105, 2)


