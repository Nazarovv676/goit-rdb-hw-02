-- 1. Довідник клієнтів
CREATE TABLE clients (
    client_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_address VARCHAR(200) NOT NULL
);

-- 2. Довідник товарів
CREATE TABLE products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Замовлення
CREATE TABLE orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients (client_id) ON UPDATE CASCADE
);

-- 4. Позиції замовлення (зв'язок N–M)
CREATE TABLE order_items (
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    qty INTEGER NOT NULL CHECK (qty > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON UPDATE CASCADE
);

-- Індекси для типових запитів
CREATE INDEX idx_orders_client_id ON orders (client_id);

CREATE INDEX idx_order_items_prod ON order_items (product_id);