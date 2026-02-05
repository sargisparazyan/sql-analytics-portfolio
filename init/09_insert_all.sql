-- =====================================================
-- LOAD CORE GEOGRAPHY DIMENSIONS
-- =====================================================
\echo 'Loading geography dimensions'

COPY project.countries
FROM '/docker-entrypoint-initdb.d/data/final_schema/countries.csv'
CSV HEADER;

COPY project.states
FROM '/docker-entrypoint-initdb.d/data/final_schema/states.csv'
CSV HEADER;

COPY project.cities
FROM '/docker-entrypoint-initdb.d/data/final_schema/cities.csv'
CSV HEADER;


-- =====================================================
-- LOAD STORES (needed before staffs, orders, stocks)
-- =====================================================
\echo 'Loading stores'

COPY project.stores
FROM '/docker-entrypoint-initdb.d/data/final_schema/stores.csv'
CSV HEADER;


-- =====================================================
-- LOAD CUSTOMERS
-- =====================================================
\echo 'Loading customers'

COPY project.customers
FROM '/docker-entrypoint-initdb.d/data/final_schema/customers.csv'
CSV HEADER;


-- =====================================================
-- LOAD PRODUCT CATALOG
-- =====================================================
\echo 'Loading product catalog'

COPY project.categories
FROM '/docker-entrypoint-initdb.d/data/final_schema/categories.csv'
CSV HEADER;

COPY project.brands
FROM '/docker-entrypoint-initdb.d/data/final_schema/brands.csv'
CSV HEADER;

COPY project.products
FROM '/docker-entrypoint-initdb.d/data/final_schema/products.csv'
CSV HEADER;


-- =====================================================
-- LOAD STAFFS
-- =====================================================
\echo 'Loading staffs'

COPY project.staffs
FROM '/docker-entrypoint-initdb.d/data/final_schema/staffs.csv'
CSV HEADER;


-- =====================================================
-- LOAD ORDERS & ORDER ITEMS
-- =====================================================
\echo 'Loading orders'

COPY project.orders
FROM '/docker-entrypoint-initdb.d/data/final_schema/orders.csv'
CSV HEADER;

COPY project.order_items
FROM '/docker-entrypoint-initdb.d/data/final_schema/order_items.csv'
CSV HEADER;


-- =====================================================
-- LOAD STOCKS
-- =====================================================
\echo 'Loading stocks'

COPY project.stocks
FROM '/docker-entrypoint-initdb.d/data/final_schema/stocks.csv'
CSV HEADER;


-- =====================================================
-- LOAD STAGING SPATIAL DATA
-- =====================================================
\echo 'Loading staging WKT boundary data'

COPY project._stg_country_boundaries(country_id, wkt)
FROM '/docker-entrypoint-initdb.d/data/final_schema/country_boundaries.csv'
CSV HEADER
QUOTE '"';


COPY project._stg_state_boundaries(state_id, wkt)
FROM '/docker-entrypoint-initdb.d/data/final_schema/state_boundaries.csv'
CSV HEADER
QUOTE '"';


-- =====================================================
-- POPULATE FINAL SPATIAL TABLES
-- =====================================================
\echo 'Inserting spatial geometries'

INSERT INTO project.country_boundaries (country_id, geom)
SELECT
  country_id,
  ST_GeomFromText(wkt, 4326)
FROM project._stg_country_boundaries;

INSERT INTO project.state_boundaries (state_id, geom)
SELECT
  state_id,
  ST_GeomFromText(wkt, 4326)
FROM project._stg_state_boundaries;



