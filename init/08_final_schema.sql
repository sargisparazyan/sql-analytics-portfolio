-- =====================================================
-- CORE GEOGRAPHY DIMENSIONS
-- =====================================================
CREATE TABLE final_schema.project.countries (
    country_id INT PRIMARY KEY,
    country_name TEXT NOT NULL
);

CREATE TABLE final_schema.project.states (
    state_id INT PRIMARY KEY,
    state_name TEXT NOT NULL,
    country_id INT NOT NULL REFERENCES final_schema.project.countries(country_id)
);

CREATE TABLE final_schema.project.cities (
    city_id INT PRIMARY KEY,
    city_name TEXT NOT NULL,
    state_id INT NOT NULL REFERENCES final_schema.project.states(state_id)
);

-- =====================================================
-- STORES (needed early for FK)
-- =====================================================
CREATE TABLE final_schema.project.stores (
    store_id INT PRIMARY KEY,
    store_name TEXT NOT NULL,
    phone VARCHAR(30),
    email TEXT UNIQUE,
    street VARCHAR(50),
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code VARCHAR(30)
);

-- =====================================================
-- CUSTOMERS
-- =====================================================
CREATE TABLE final_schema.project.customers (
    customer_id INT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone VARCHAR(30),
    email TEXT UNIQUE,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code VARCHAR(30)
);


-- =====================================================
-- PRODUCT CATALOG
-- =====================================================
CREATE TABLE final_schema.project.categories (
    category_id INT PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE final_schema.project.brands (
    brand_id INT PRIMARY KEY,
    brand_name TEXT NOT NULL
);

CREATE TABLE final_schema.project.products (
    product_id INT PRIMARY KEY,
    product_name TEXT NOT NULL,
    brand_id INT REFERENCES final_schema.project.brands(brand_id),
    category_id INT REFERENCES final_schema.project.categories(category_id),
    model_year INT NOT NULL,
    list_price NUMERIC(10,2) NOT NULL
);

-- =====================================================
-- STAFFS (self-reference)
-- =====================================================
CREATE TABLE final_schema.project.staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email TEXT UNIQUE,
    phone VARCHAR(30),
    active BOOLEAN,
    store_id INT NOT NULL,
    manager_id INT,

    CONSTRAINT fk_staff_store
        FOREIGN KEY (store_id)
        REFERENCES final_schema.project.stores(store_id),

    CONSTRAINT fk_staff_manager
        FOREIGN KEY (manager_id)
        REFERENCES final_schema.project.staffs(staff_id)
);

-- =====================================================
-- ORDERS
-- =====================================================
CREATE TABLE final_schema.project.orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES final_schema.project.customers(customer_id),
    order_status INT NOT NULL,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT REFERENCES final_schema.project.stores(store_id),
    staff_id INT REFERENCES final_schema.project.staffs(staff_id)
);

CREATE TABLE final_schema.project.order_items (
    order_id INT NOT NULL REFERENCES final_schema.project.orders(order_id),
    item_id INT NOT NULL,
    product_id INT NOT NULL REFERENCES final_schema.project.products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    list_price NUMERIC(10,2) NOT NULL,
    discount NUMERIC(10,2),
    PRIMARY KEY (order_id, item_id)
);

-- =====================================================
-- STOCKS
-- =====================================================
CREATE TABLE final_schema.project.stocks (
    store_id INT NOT NULL REFERENCES final_schema.project.stores(store_id),
    product_id INT NOT NULL REFERENCES final_schema.project.products(product_id),
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);

-- =====================================================
-- SPATIAL TABLES (PostGIS)
-- =====================================================
CREATE TABLE final_schema.project.country_boundaries (
    country_id INT PRIMARY KEY REFERENCES final_schema.project.countries(country_id),
    geom GEOMETRY(MultiPolygon, 4326)
);

CREATE TABLE final_schema.project.state_boundaries (
    state_id INT PRIMARY KEY REFERENCES final_schema.project.states(state_id),
    geom GEOMETRY(Polygon, 4326)
);

-- =====================================================
-- STAGING TABLES
-- =====================================================
CREATE TABLE IF NOT EXISTS final_schema.project._stg_country_boundaries (
    country_id INT,
    wkt TEXT
);

CREATE TABLE IF NOT EXISTS final_schema.project._stg_state_boundaries (
    state_id INT,
    wkt TEXT
);

CREATE TABLE IF NOT EXISTS final_schema.project._stg_points (
    point_id INT,
    wkt TEXT
);
