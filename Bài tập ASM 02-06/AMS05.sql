CREATE DATABASE ASM05
USE ASM05;
GO
CREATE TABLE DanhBa (
    HoVaTen NVARCHAR(100),
    DiaChi NVARCHAR(200),
    DienThoai NVARCHAR(50) PRIMARY KEY,
    NgaySinh DATE
);
GO
INSERT INTO DanhBa (HoVaTen, DiaChi, DienThoai, NgaySinh)
VALUES
    (N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', N'987654321', '2009-02-14'),
    (N'Nguyễn Văn Bình', N'123 Lê Lợi, Hoàn Kiếm, Hà Nội', N'09873452', '1990-05-10');
GO
SELECT *
FROM DanhBa;
SELECT DienThoai
FROM DanhBa;
SELECT *
FROM DanhBa
ORDER BY HoVaTen ASC;
SELECT DienThoai
FROM DanhBa
WHERE HoVaTen = N'Nguyễn Văn An';
SELECT *
FROM DanhBa
WHERE NgaySinh = '2009-02-14';
GO
SELECT HoVaTen, COUNT(DienThoai) AS SoLuongSoDienThoai
FROM DanhBa
GROUP BY HoVaTen;
GO
SELECT COUNT(*) AS TongSoNguoiSinhThang12
FROM DanhBa
WHERE MONTH(NgaySinh) = 12;
GO
SELECT *
FROM DanhBa;
SELECT *
FROM DanhBa
WHERE DienThoai = '123456789';
GO
UPDATE DanhBa
SET NgaySinh = GETDATE();
EXEC sp_pkeys 'DanhBa';
GO
ALTER TABLE DanhBa
ADD NgayBatDauLienLac DATE;
CREATE INDEX IX_HoTen ON DanhBa(HoVaTen);
CREATE INDEX IX_SoDienThoai ON DanhBa(DienThoai);
GO
CREATE VIEW View_SoDienThoai AS
SELECT HoVaTen, DienThoai
FROM DanhBa;
GO
CREATE VIEW View_SinhNhat AS
SELECT HoVaTen, NgaySinh, DienThoai
FROM DanhBa
WHERE MONTH(NgaySinh) = MONTH(GETDATE());
GO
CREATE PROCEDURE SP_ThemDanhBa
    @HoVaTen NVARCHAR(100),
    @DiaChi NVARCHAR(200),
    @DienThoai NVARCHAR(50),
    @NgaySinh DATE
AS
BEGIN
    INSERT INTO DanhBa (HoVaTen, DiaChi, DienThoai, NgaySinh)
    VALUES (@HoVaTen, @DiaChi, @DienThoai, @NgaySinh);
END;
GO
CREATE PROCEDURE SP_TimDanhBa
    @Ten NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM DanhBa
    WHERE HoVaTen = @Ten;
END;
GO
