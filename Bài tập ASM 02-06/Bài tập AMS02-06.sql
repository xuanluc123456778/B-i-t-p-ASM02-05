CREATE DATABASE AMS02
USE AMS02;
GO
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Description NVARCHAR(200),
    Manufacturer NVARCHAR(50),
    Unit NVARCHAR(20),
    Price MONEY,
    StockQuantity INT
);
GO
-- Thêm dữ liệu vào bảng Danh sách sản phẩm
INSERT INTO Product (ProductID, ProductName, Description, Manufacturer, Unit, Price, StockQuantity)
VALUES
    (123, N'Asus', N'Máy nhập cũ', N'USA', N'Chiếc', 1000, 10),
    (1, N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', N'T450', 1000, 10),
    (2, N'Điện Thoại Nokia5670', N'Điện thoại đang hot', N'Nokia5670', N'Chiếc', 200, 200),
    (3, N'Máy In Samsung 450', N'Máy in đang lỗi', N'Samsung 450', N'Chiếc', 100, 10);
GO
SELECT DISTINCT Manufacturer
FROM Product;
SELECT *
FROM Product;
SELECT ProductName
FROM Product
ORDER BY ProductName DESC;
SELECT *
FROM Product
ORDER BY Price DESC;
SELECT *
FROM Product
WHERE Manufacturer = N'Asus';
SELECT *
FROM Product
WHERE StockQuantity < 11;
SELECT *
FROM Product
WHERE Manufacturer = N'Asus';
GO
SELECT COUNT(DISTINCT Manufacturer) AS NumberOfManufacturers
FROM Product;
SELECT COUNT(*) AS TotalProducts
FROM Product;
GO
SELECT Manufacturer, SUM(StockQuantity) AS TotalStockQuantity
FROM Product
GROUP BY Manufacturer;
SELECT SUM(StockQuantity) AS TotalStockQuantity
FROM Product;
GO
UPDATE Product
SET Price = Price * 1.1
WHERE Price > 0;
UPDATE CustomerRegistration
SET PhoneNumber = '0973905739' + PhoneNumber
WHERE LEFT(PhoneNumber, 1) <> '0973905739';
GO
-- Khóa chính: ProductID
-- Khóa ngoại: Không có khóa ngoại trong ví dụ

-- Lưu ý: Đây là một ví dụ đơn giản, trong thực tế, các bảng sẽ liên quan nhau qua các khóa ngoại
-- và cần xác định một cách chi tiết hơn.
CREATE INDEX IX_Product_ProductName ON Product (ProductName);
CREATE INDEX IX_Product_Description ON Product (Description);
GO
CREATE VIEW View_SanPham AS
SELECT ProductID, ProductName, Price
FROM Product;
GO
CREATE PROCEDURE SP_SanPham_TenHang
    @TenHang NVARCHAR(100)
AS
BEGIN
    SELECT ProductID, ProductName
    FROM Product
    WHERE ProductName = @TenHang;
END;
GO
CREATE PROCEDURE SP_SanPham_Gia
    @Gia MONEY
AS
BEGIN
    SELECT ProductID, ProductName
    FROM Product
    WHERE Price >= @Gia;
END;
GO
CREATE PROCEDURE SP_SanPham_HetHang
AS
BEGIN
    SELECT ProductID, ProductName
    FROM Product
    WHERE StockQuantity = 0;
END;
GO
CREATE TRIGGER TG_XoaHang
ON Product
INSTEAD OF DELETE
AS
BEGIN
    RAISEERROR('Không cho phép xóa hãng sản xuất.', 16, 1);
END;
GO
CREATE TRIGGER TG_XoaSanPham
ON Product
AFTER DELETE
AS
BEGIN
    DELETE FROM PhoneNumber
    WHERE ProductID IN (SELECT deleted.ProductID FROM deleted);
END;
GO
