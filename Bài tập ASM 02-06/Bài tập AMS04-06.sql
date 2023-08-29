CREATE DATABASE AMS04
USE AMS04;
GO
CREATE TABLE LoaiSanPham (
    MaLoaiSanPham INT PRIMARY KEY,
    TenLoaiSanPham NVARCHAR(100)
);
GO
CREATE TABLE NguoiChiuTrachNhiem (
    MaNguoiChiuTrachNhiem INT PRIMARY KEY,
    TenNguoiChiuTrachNhiem NVARCHAR(100)
);
GO
CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY,
    NgaySanXuat DATE,
    MaLoaiSanPham INT REFERENCES LoaiSanPham(MaLoaiSanPham),
    MaNguoiChiuTrachNhiem INT REFERENCES NguoiChiuTrachNhiem(MaNguoiChiuTrachNhiem)
);
GO
INSERT INTO LoaiSanPham (MaLoaiSanPham, TenLoaiSanPham)
VALUES
    (237, N'Máy tính sách tay'),
    (237, N'Z37E');
GO
INSERT INTO NguoiChiuTrachNhiem (MaNguoiChiuTrachNhiem, TenNguoiChiuTrachNhiem)
VALUES
    (987688, N'Trần Xuân Lực');
GO
INSERT INTO SanPham (MaSanPham, NgaySanXuat, MaLoaiSanPham, MaNguoiChiuTrachNhiem)
VALUES
    (737, '2023-08-29', 237, 987688);
GO
SELECT *
FROM LoaiSanPham;
SELECT *
FROM SanPham;
SELECT *
FROM NguoiChiuTrachNhiem;
GO
SELECT *
FROM LoaiSanPham
ORDER BY TenLoaiSanPham ASC;
SELECT *
FROM NguoiChiuTrachNhiem
ORDER BY TenNguoiChiuTrachNhiem ASC;
SELECT *
FROM SanPham
WHERE MaLoaiSanPham = 237;
SELECT *
FROM SanPham
WHERE MaNguoiChiuTrachNhiem = 987688
ORDER BY MaSanPham DESC;
GO
SELECT LoaiSanPham.TenLoaiSanPham, COUNT(SanPham.MaSanPham) AS SoSanPham
FROM LoaiSanPham
LEFT JOIN SanPham ON LoaiSanPham.MaLoaiSanPham = SanPham.MaLoaiSanPham
GROUP BY LoaiSanPham.TenLoaiSanPham;
SELECT LoaiSanPham.TenLoaiSanPham, AVG(SanPham.Gia) AS GiaTrungBinh
FROM LoaiSanPham
LEFT JOIN SanPham ON LoaiSanPham.MaLoaiSanPham = SanPham.MaLoaiSanPham
GROUP BY LoaiSanPham.TenLoaiSanPham;
GO
SELECT SanPham.*, LoaiSanPham.TenLoaiSanPham
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham;
SELECT NguoiChiuTrachNhiem.*, LoaiSanPham.TenLoaiSanPham, SanPham.*
FROM NguoiChiuTrachNhiem
INNER JOIN SanPham ON NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem = SanPham.MaNguoiChiuTrachNhiem
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham;
GO
UPDATE SanPham
SET NgaySanXuat = GETDATE()
WHERE NgaySanXuat > GETDATE();
EXEC sp_pkeys 'LoaiSanPham';
EXEC sp_fkeys 'SanPham';
EXEC sp_fkeys 'NguoiChiuTrachNhiem';
GO
ALTER TABLE SanPham
ADD PhienBan NVARCHAR(50);
CREATE INDEX IX_TenNguoiChiuTrachNhiem ON NguoiChiuTrachNhiem(TenNguoiChiuTrachNhiem);
CREATE VIEW View_SanPham AS
SELECT MaSanPham, NgaySanXuat, TenLoaiSanPham
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham;
CREATE VIEW View_SanPham_NCTN AS
SELECT MaSanPham, NgaySanXuat, TenNguoiChiuTrachNhiem
FROM SanPham
INNER JOIN NguoiChiuTrachNhiem ON SanPham.MaNguoiChiuTrachNhiem = NguoiChiuTrachNhiem.MaNguoiChiuTrachNhiem;
CREATE VIEW View_Top_SanPham AS
SELECT TOP 5 MaSanPham, TenLoaiSanPham, NgaySanXuat
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSanPham = LoaiSanPham.MaLoaiSanPham
ORDER BY NgaySanXuat DESC;
CREATE PROCEDURE SP_ThemLoaiSP
    @TenLoai NVARCHAR(100)
AS
BEGIN
    INSERT INTO LoaiSanPham (TenLoaiSanPham)
    VALUES (@TenLoai);
END;
GO
CREATE PROCEDURE SP_ThemNCTN
    @TenNCTN NVARCHAR(100)
AS
BEGIN
    INSERT INTO NguoiChiuTrachNhiem (TenNguoiChiuTrachNhiem)
    VALUES (@TenNCTN);
END;
GO
CREATE PROCEDURE SP_ThemSanPham
    @MaSanPham INT,
    @NgaySanXuat DATE,
    @MaLoaiSanPham INT,
    @MaNguoiChiuTrachNhiem INT
AS
BEGIN
    INSERT INTO SanPham (MaSanPham, NgaySanXuat, MaLoaiSanPham, MaNguoiChiuTrachNhiem)
    VALUES (@MaSanPham, @NgaySanXuat, @MaLoaiSanPham, @MaNguoiChiuTrachNhiem);
END;
GO
CREATE PROCEDURE SP_XoaSanPham
    @MaSanPham INT
AS
BEGIN
    DELETE FROM SanPham
    WHERE MaSanPham = @MaSanPham;
END;
GO
CREATE PROCEDURE SP_XoaSanPham_TheoLoai
    @MaLoaiSanPham INT

GO