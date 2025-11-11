-- ============================================
-- BookStore Database Schema & Seed Data
-- ============================================

-- Drop tables in reverse order of dependency
DROP TABLE IF EXISTS tblDirectInvoice;
DROP TABLE IF EXISTS tblOnlineInvoice;
DROP TABLE IF EXISTS tblOrderDetail;
DROP TABLE IF EXISTS tblImportDetail;
DROP TABLE IF EXISTS tblOrder;
DROP TABLE IF EXISTS tblImport;
DROP TABLE IF EXISTS tblProduct;
DROP TABLE IF EXISTS tblSupplier;
DROP TABLE IF EXISTS tblCustomer;
DROP TABLE IF EXISTS tblStaff;
DROP TABLE IF EXISTS tblMember;
DROP TABLE IF EXISTS tblAccount;
DROP TABLE IF EXISTS tblAddress;

-- ============================================
-- CREATE TABLES
-- ============================================

-- Create tblAddress table
CREATE TABLE tblAddress (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    province VARCHAR(255) NOT NULL,
    district VARCHAR(255) NOT NULL,
    ward VARCHAR(255) NOT NULL,
    street VARCHAR(255)
);

-- Create tblAccount table
CREATE TABLE tblAccount (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Create tblMember table
CREATE TABLE tblMember (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    birthDate DATE NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255),
    note VARCHAR(255),
    tblAccountId INT(10) NOT NULL,
    tblAddressId INT(10) NOT NULL,
    FOREIGN KEY (tblAccountId) REFERENCES tblAccount(id),
    FOREIGN KEY (tblAddressId) REFERENCES tblAddress(id)
);

-- Create tblStaff table
CREATE TABLE tblStaff (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    position VARCHAR(255) NOT NULL,
    tblUserId INT(10) NOT NULL,
    FOREIGN KEY (tblUserId) REFERENCES tblMember(id)
);

-- Create tblCustomer table
CREATE TABLE tblCustomer (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    customerCode VARCHAR(255) NOT NULL,
    tblUserId INT(10) NOT NULL,
    FOREIGN KEY (tblUserId) REFERENCES tblMember(id)
);

-- Create tblSupplier table
CREATE TABLE tblSupplier (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    note VARCHAR(255),
    tblAddressId INT(10) NOT NULL,
    FOREIGN KEY (tblAddressId) REFERENCES tblAddress(id)
);

-- Create tblProduct table
CREATE TABLE tblProduct (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    price FLOAT(10) NOT NULL,
    stock INT(10) NOT NULL
);

-- Create tblImport table
CREATE TABLE tblImport (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    note VARCHAR(255),
    tblSupplierId INT(10) NOT NULL,
    tblWarehouseStaffId INT(10) NOT NULL,
    importDate DATE NOT NULL,
    FOREIGN KEY (tblSupplierId) REFERENCES tblSupplier(id),
    FOREIGN KEY (tblWarehouseStaffId) REFERENCES tblStaff(id)
);

-- Create tblImportDetail table
CREATE TABLE tblImportDetail (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    quantity INT(10) NOT NULL,
    importPrice FLOAT(10) NOT NULL,
    tblProductId INT(10) NOT NULL,
    tblImportId INT(10) NOT NULL,
    FOREIGN KEY (tblProductId) REFERENCES tblProduct(id),
    FOREIGN KEY (tblImportId) REFERENCES tblImport(id)
);

-- Create tblOrder table
CREATE TABLE tblOrder (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255),
    orderDate DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    note VARCHAR(255),
    paymentMethod VARCHAR(255) NOT NULL,
    totalAmount FLOAT(10) NOT NULL,
    tblCustomerId INT(10) NOT NULL,
    FOREIGN KEY (tblCustomerId) REFERENCES tblCustomer(id)
);

-- Create tblOrderDetail table
CREATE TABLE tblOrderDetail (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    quantity INT(10) NOT NULL,
    tblOrderId INT(10) NOT NULL,
    tblProductId INT(10) NOT NULL,
    FOREIGN KEY (tblOrderId) REFERENCES tblOrder(id),
    FOREIGN KEY (tblProductId) REFERENCES tblProduct(id)
);

-- Create tblOnlineInvoice table
CREATE TABLE tblOnlineInvoice (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    deliveryFee FLOAT(10) NOT NULL,
    tblOrderId INT(10) NOT NULL,
    tblWareHouseStaffId INT(10) NOT NULL,
    tblDeliveryStaffId INT(10) NOT NULL,
    deliveryDate DATE,
    FOREIGN KEY (tblOrderId) REFERENCES tblOrder(id),
    FOREIGN KEY (tblWareHouseStaffId) REFERENCES tblStaff(id),
    FOREIGN KEY (tblDeliveryStaffId) REFERENCES tblStaff(id)
);

-- Create tblDirectInvoice table
CREATE TABLE tblDirectInvoice (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    tblOrderId INT(10) NOT NULL,
    tblSaleStaffId INT(10) NOT NULL,
    FOREIGN KEY (tblOrderId) REFERENCES tblOrder(id),
    FOREIGN KEY (tblSaleStaffId) REFERENCES tblStaff(id)
);

-- ============================================
-- SEED DATA
-- ============================================

-- Insert Addresses
INSERT INTO tblAddress (province, district, ward, street) VALUES
('Hà Nội', 'Cầu Giấy', 'Dịch Vọng Hậu', '123 Xuân Thủy'),
('Hà Nội', 'Đống Đa', 'Láng Thượng', '456 Chùa Láng'),
('Hồ Chí Minh', 'Quận 1', 'Bến Nghé', '789 Lê Lợi'),
('Hồ Chí Minh', 'Quận 3', 'Võ Thị Sáu', '101 Nam Kỳ Khởi Nghĩa'),
('Đà Nẵng', 'Hải Châu', 'Thuận Phước', '202 Bạch Đằng'),
('Hà Nội', 'Hoàn Kiếm', 'Hàng Trống', '303 Hàng Gai'),
('Hồ Chí Minh', 'Thủ Đức', 'Linh Trung', '404 Võ Văn Ngân'),
('Cần Thơ', 'Ninh Kiều', 'An Khánh', '505 3 Tháng 2');

-- Insert Accounts
INSERT INTO tblAccount (username, password) VALUES
('customer1', 'pass123'),
('customer2', 'pass123'),
('staff_warehouse', 'staffpass'),
('staff_delivery', 'staffpass'),
('staff_sale', 'staffpass'),
('admin', 'adminpass');

-- Insert Members
INSERT INTO tblMember (firstName, lastName, birthDate, email, phone, note, tblAccountId, tblAddressId) VALUES
('Nguyễn', 'Văn A', '1990-01-15', 'vana@example.com', '0901111111', NULL, 1, 1),
('Trần', 'Thị B', '1992-03-20', 'thib@example.com', '0902222222', NULL, 2, 2),
('Lê', 'Văn C', '1985-07-10', 'vanc@example.com', '0903333333', 'Quản lý kho', 3, 3),
('Phạm', 'Thị D', '1988-11-05', 'thid@example.com', '0904444444', 'Nhân viên giao hàng', 4, 4),
('Hoàng', 'Văn E', '1995-02-28', 'vane@example.com', '0905555555', 'Nhân viên bán hàng', 5, 5),
('Bùi', 'Thị F', '1980-04-12', 'thif@example.com', '0906666666', 'Quản trị viên', 6, 6);

-- Insert Staff
INSERT INTO tblStaff (position, tblUserId) VALUES
('Warehouse Manager', 3),
('Delivery Staff', 4),
('Sales Staff', 5);

-- Insert Customers
INSERT INTO tblCustomer (customerCode, tblUserId) VALUES
('CUST001', 1),
('CUST002', 2),
('CUST003', 1),
('CUST004', 2),
('CUST005', 1);

-- Insert Suppliers
INSERT INTO tblSupplier (name, phone, note, tblAddressId) VALUES
('Samsung Electronics Vietnam', '0241234567', 'Nhà phân phối điện máy Samsung', 7),
('LG Electronics Vietnam', '0287654321', 'Nhà cung cấp điện máy LG', 8),
('Panasonic Vietnam', '0249876543', 'Nhà phân phối Panasonic', 1),
('Toshiba Vietnam', '0281122334', 'Nhà cung cấp Toshiba', 2);

-- Insert Products (20 electronics products)
INSERT INTO tblProduct (code, name, description, price, stock) VALUES
('TV001', 'Samsung 55 inch 4K Smart TV', 'Smart TV 55 inch, 4K UHD, HDR, Smart Hub', 15990000, 25),
('TV002', 'LG 65 inch OLED TV', 'OLED TV 65 inch, 4K, AI ThinQ, WebOS', 24990000, 15),
('TV003', 'Sony 43 inch Android TV', 'Android TV 43 inch, 4K HDR, Google Assistant', 12990000, 30),
('FR001', 'Samsung Inverter 2 Cửa', 'Tủ lạnh Inverter 2 cửa, 350L, công nghệ Digital Inverter', 14990000, 20),
('FR002', 'LG Side by Side 4 Cửa', 'Tủ lạnh Side by Side 4 cửa, 600L, Inverter, Door-in-Door', 28990000, 12),
('FR003', 'Panasonic Inverter 3 Cửa', 'Tủ lạnh Inverter 3 cửa, 450L, công nghệ Prime Fresh', 17990000, 18),
('WM001', 'Samsung Inverter 9kg', 'Máy giặt cửa trước 9kg, Inverter, AddWash, Quick Wash', 11990000, 22),
('WM002', 'LG Inverter 10kg', 'Máy giặt cửa trước 10kg, Inverter, TurboWash, Steam', 13990000, 16),
('WM003', 'Electrolux Inverter 8kg', 'Máy giặt cửa trên 8kg, Inverter, UltraMix, Gentle Wash', 8990000, 25),
('AC001', 'Daikin Inverter 1 HP', 'Điều hòa Inverter 1 HP, R410A, Coanda Airflow, Econo Mode', 8990000, 30),
('AC002', 'Mitsubishi Inverter 1.5 HP', 'Điều hòa Inverter 1.5 HP, R410A, Wide Airflow, i-Save', 11990000, 25),
('AC003', 'LG Inverter 2 HP', 'Điều hòa Inverter 2 HP, R410A, Plasmaster Ionizer, Auto Cleaning', 15990000, 20),
('LT001', 'Dell Inspiron 15 5501', 'Laptop Dell Inspiron 15.6 inch, Core i5, 8GB RAM, 256GB SSD', 16990000, 15),
('LT002', 'HP Pavilion 14', 'Laptop HP Pavilion 14 inch, AMD Ryzen 5, 8GB RAM, 512GB SSD', 14990000, 18),
('LT003', 'Asus VivoBook 15', 'Laptop Asus VivoBook 15.6 inch, Core i5, 8GB RAM, 512GB SSD', 15990000, 20),
('PH001', 'iPhone 15 Pro 128GB', 'iPhone 15 Pro 128GB, A17 Pro, 48MP camera, Titanium', 24990000, 30),
('PH002', 'Samsung Galaxy S24 Ultra', 'Galaxy S24 Ultra 256GB, Snapdragon 8 Gen 3, S Pen, 200MP', 22990000, 25),
('PH003', 'Xiaomi Redmi Note 13 Pro', 'Redmi Note 13 Pro 128GB, Snapdragon 7s Gen 2, 200MP camera', 8990000, 40),
('MW001', 'Sharp R-G832VN-S', 'Lò vi sóng 20L, nướng kèm, 10 chế độ nấu, Inverter', 2990000, 35),
('MW002', 'Panasonic NN-ST45KW', 'Lò vi sóng 27L, nướng kèm, Inverter, Auto Menu', 4490000, 28);

-- Insert Imports
INSERT INTO tblImport (note, tblSupplierId, tblWarehouseStaffId, importDate) VALUES
('Nhập kho ban đầu cho điện máy', 1, 1, '2023-01-10'),
('Nhập lại các sản phẩm điện máy phổ biến', 1, 1, '2023-03-01'),
('Nhập điện máy mới từ nhà cung cấp', 2, 1, '2023-02-15');

-- Insert Import Details
INSERT INTO tblImportDetail (quantity, importPrice, tblProductId, tblImportId) VALUES
(10, 12000000, 1, 1),
(8, 20000000, 2, 1),
(12, 10000000, 3, 1),
(10, 11000000, 4, 1),
(6, 22000000, 5, 1),
(9, 14000000, 6, 1),
(11, 9000000, 7, 1),
(8, 11000000, 8, 1),
(13, 7000000, 9, 1),
(15, 7000000, 10, 1),
(12, 9500000, 11, 2),
(10, 12000000, 12, 2),
(8, 13000000, 13, 2),
(9, 12000000, 14, 2),
(10, 13000000, 15, 2),
(15, 19000000, 16, 2),
(12, 18000000, 17, 2),
(20, 7000000, 18, 2),
(18, 2200000, 19, 2),
(14, 3500000, 20, 2);

-- Insert Orders
INSERT INTO tblOrder (code, orderDate, status, note, paymentMethod, totalAmount, tblCustomerId) VALUES
('ORD001', '2023-04-05', 'Completed', NULL, 'Credit Card', 24990000, 1),
('ORD002', '2023-04-10', 'Pending', 'Khách hàng yêu cầu giao hàng tận nơi', 'Cash on Delivery', 11990000, 2),
('ORD003', '2023-04-12', 'Processing', NULL, 'Bank Transfer', 16990000, 1),
('ORD004', '2023-05-15', 'Pending', NULL, 'Credit Card', 16155000, 1),
('ORD005', '2023-05-18', 'Pending', NULL, 'Cash on Delivery', 37980000, 2),
('ORD006', '2023-05-20', 'Processing', 'Giao hàng nhanh', 'Bank Transfer', 30990000, 1),
('ORD007', '2023-05-22', 'Pending', NULL, 'Credit Card', 29980000, 2),
('ORD008', '2023-05-25', 'Pending', NULL, 'Cash on Delivery', 15165000, 1),
('ORD009', '2023-05-28', 'Processing', NULL, 'Credit Card', 27990000, 2),
('ORD010', '2023-06-01', 'Pending', 'Giao hàng buổi sáng', 'Bank Transfer', 3150000, 1),
('ORD011', '2023-06-03', 'Pending', NULL, 'Credit Card', 4602500, 2),
('ORD012', '2023-06-05', 'Processing', NULL, 'Cash on Delivery', 26500000, 1),
('ORD013', '2023-06-08', 'Pending', NULL, 'Bank Transfer', 20000000, 2);

-- Insert Order Details
INSERT INTO tblOrderDetail (quantity, tblOrderId, tblProductId) VALUES
(1, 1, 2),
(1, 2, 7),
(1, 3, 13),
(1, 4, 1),
(1, 4, 11),
(1, 5, 2),
(1, 5, 3),
(1, 6, 10),
(1, 6, 12),
(1, 7, 6),
(2, 7, 9),
(1, 8, 4),
(1, 8, 15),
(1, 9, 17),
(1, 9, 16),
(1, 10, 19),
(1, 10, 18),
(1, 11, 20),
(1, 11, 5),
(1, 12, 14),
(1, 12, 7),
(1, 13, 8);

-- Insert Online Invoices
INSERT INTO tblOnlineInvoice (deliveryFee, tblOrderId, tblWareHouseStaffId, tblDeliveryStaffId, deliveryDate) VALUES
(25000, 1, 1, 2, '2023-04-07'),
(30000, 2, 1, 2, NULL),
(25000, 4, 1, 2, NULL),
(30000, 5, 1, 2, NULL),
(25000, 6, 1, 2, NULL),
(30000, 7, 1, 2, NULL),
(25000, 8, 1, 2, NULL),
(30000, 9, 1, 2, NULL),
(25000, 10, 1, 2, NULL),
(30000, 11, 1, 2, NULL),
(25000, 12, 1, 2, NULL),
(30000, 13, 1, 2, NULL);

-- Insert Direct Invoices
INSERT INTO tblDirectInvoice (tblOrderId, tblSaleStaffId) VALUES
(3, 3);

-- Insert 20 more Pending Orders
INSERT INTO tblOrder (code, orderDate, status, note, paymentMethod, totalAmount, tblCustomerId) VALUES
('ORD014', '2023-06-10', 'Pending', NULL, 'Cash on Delivery', 17990000, 1),
('ORD015', '2023-06-12', 'Pending', 'Giao hàng buổi chiều', 'Credit Card', 13990000, 2),
('ORD016', '2023-06-15', 'Pending', NULL, 'Bank Transfer', 8990000, 1),
('ORD017', '2023-06-18', 'Pending', NULL, 'Cash on Delivery', 11990000, 2),
('ORD018', '2023-06-20', 'Pending', 'Giao hàng nhanh', 'Credit Card', 15990000, 1),
('ORD019', '2023-06-22', 'Pending', NULL, 'Bank Transfer', 22990000, 2),
('ORD020', '2023-06-25', 'Pending', NULL, 'Cash on Delivery', 8990000, 1),
('ORD021', '2023-06-28', 'Pending', 'Giao hàng buổi sáng', 'Credit Card', 14990000, 2),
('ORD022', '2023-07-01', 'Pending', NULL, 'Bank Transfer', 24990000, 1),
('ORD023', '2023-07-03', 'Pending', NULL, 'Cash on Delivery', 12990000, 2),
('ORD024', '2023-07-05', 'Pending', 'Giao hàng tận nơi', 'Credit Card', 28990000, 1),
('ORD025', '2023-07-08', 'Pending', NULL, 'Bank Transfer', 16990000, 2),
('ORD026', '2023-07-10', 'Pending', NULL, 'Cash on Delivery', 11990000, 1),
('ORD027', '2023-07-12', 'Pending', 'Giao hàng nhanh', 'Credit Card', 15990000, 2),
('ORD028', '2023-07-15', 'Pending', NULL, 'Bank Transfer', 8990000, 1),
('ORD029', '2023-07-18', 'Pending', NULL, 'Cash on Delivery', 17990000, 2),
('ORD030', '2023-07-20', 'Pending', 'Giao hàng buổi chiều', 'Credit Card', 13990000, 1),
('ORD031', '2023-07-22', 'Pending', NULL, 'Bank Transfer', 22990000, 2),
('ORD032', '2023-07-25', 'Pending', NULL, 'Cash on Delivery', 14990000, 1),
('ORD033', '2023-07-28', 'Pending', 'Giao hàng tận nơi', 'Credit Card', 24990000, 2);

-- Insert Order Details for new orders
INSERT INTO tblOrderDetail (quantity, tblOrderId, tblProductId) VALUES
(1, 14, 4),
(1, 15, 8),
(1, 16, 10),
(1, 17, 11),
(1, 18, 13),
(1, 19, 17),
(1, 20, 10),
(1, 21, 14),
(1, 22, 2),
(1, 23, 3),
(1, 24, 5),
(1, 25, 15),
(1, 26, 7),
(1, 27, 13),
(1, 28, 10),
(1, 29, 4),
(1, 30, 8),
(1, 31, 17),
(1, 32, 14),
(1, 33, 2);

