-- 1. Enable PostGIS for geospatial features
CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA extensions;

-- 2. Profiles Table (Linked to Supabase Auth)
CREATE TABLE profiles (
    id UUID REFERENCES auth.users NOT NULL PRIMARY KEY,
    full_name TEXT,
    green_points INT DEFAULT 0,
    role TEXT DEFAULT 'citizen'
);

-- Enable RLS on profiles
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public profiles are viewable by everyone." ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profile." ON profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile." ON profiles FOR UPDATE USING (auth.uid() = id);

-- 3. Waste Reports Table
CREATE TABLE waste_reports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES profiles(id) NOT NULL,
    photo_url TEXT NOT NULL,
    waste_type TEXT, 
    confidence_score FLOAT,
    location extensions.geography(POINT) NOT NULL,
    status TEXT DEFAULT 'reported',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Spatial Index for lightning-fast map queries
CREATE INDEX waste_reports_geo_index ON waste_reports USING GIST (location);

-- Enable RLS on waste reports
ALTER TABLE waste_reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can view reports." ON waste_reports FOR SELECT USING (true);
CREATE POLICY "Authenticated users can create reports." ON waste_reports FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Users can only update their own reports." ON waste_reports FOR UPDATE USING (auth.uid() = user_id);

-- 4. The Hotspot Predictor View (Clustering algorithm)
CREATE OR REPLACE VIEW waste_hotspots AS
SELECT
    cid AS hotspot_id,
    COUNT(*) AS report_count,
    ST_AsGeoJSON(ST_Centroid(ST_Collect(location::geometry))) AS center_point
FROM (
    SELECT
        id,
        location,
        -- eps: ~500m radius, minpoints: 3 reports needed to form a hotspot
        ST_ClusterDBSCAN(location::geometry, eps := 0.005, minpoints := 3) OVER () AS cid
    FROM waste_reports
    WHERE status = 'reported'
) sq
WHERE cid IS NOT NULL
GROUP BY cid;