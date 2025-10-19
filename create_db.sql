-- 1. Довідник клієнтів
CREATE TABLE clients (
    client_id BIGSERIAL PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_address VARCHAR(200) NOT NULL
);

-- 2. Довідник товарів
CREATE TABLE products (
    product_id BIGSERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Замовлення
CREATE TABLE orders (
    order_id BIGSERIAL PRIMARY KEY,
    client_id BIGINT NOT NULL REFERENCES clients (client_id) ON UPDATE CASCADE,
    order_date DATE NOT NULL
);

-- 4. Позиції замовлення (зв'язок N–M)
CREATE TABLE order_items (
    order_id BIGINT NOT NULL REFERENCES orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_id BIGINT NOT NULL REFERENCES products (product_id) ON UPDATE CASCADE,
    qty INTEGER NOT NULL CHECK (qty > 0),
    PRIMARY KEY (order_id, product_id)
);

-- Індекси для типових запитів
CREATE INDEX idx_orders_client_id ON orders (client_id);

CREATE INDEX idx_order_items_prod ON order_items (product_id);