-- kirana_schema_fixed.sql
-- SQLite-compatible schema for Kirana Store Management System
-- Author: Bhuvan Gupta
PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    category TEXT,
    quantity INTEGER NOT NULL DEFAULT 0,
    cost_price REAL NOT NULL DEFAULT 0.0,     -- per unit cost
    selling_price REAL NOT NULL DEFAULT 0.0   -- per unit selling price
);

CREATE TABLE IF NOT EXISTS sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_datetime TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS sale_items (
    sale_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Seed data (no trailing comma)
INSERT OR IGNORE INTO products (name, category, quantity, cost_price, selling_price) VALUES
('Atta (5kg)', 'Staples', 20, 200.00, 250.00),
('Sugar (1kg)', 'Staples', 50, 30.00, 40.00),
('Tea Powder (250g)', 'Beverages', 30, 80.00, 110.00),
('Cooking Oil (1L)', 'Oil', 25, 120.00, 150.00);

CREATE INDEX IF NOT EXISTS idx_products_name ON products(name);
CREATE INDEX IF NOT EXISTS idx_sale_items_saleid ON sale_items(sale_id);

COMMIT;
