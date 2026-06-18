-- 1. Create the public bucket for waste photos
INSERT INTO storage.buckets (id, name, public)
VALUES ('waste_photos', 'waste_photos', true)
ON CONFLICT (id) DO NOTHING;

-- 2. Enable RLS on the storage.objects table (if not already enabled)
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- 3. Policy: Anyone can view the photos (needed for the dashboard and public feeds)
CREATE POLICY "Publicly viewable photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'waste_photos');

-- 4. Policy: Only authenticated users can upload new photos
CREATE POLICY "Authenticated users can upload photos"
ON storage.objects FOR INSERT
WITH CHECK (
    bucket_id = 'waste_photos' 
    AND auth.role() = 'authenticated'
);

-- 5. Policy: Users can only delete or update their own photos
CREATE POLICY "Users can update their own photos"
ON storage.objects FOR UPDATE
USING (
    bucket_id = 'waste_photos' 
    AND auth.uid() = owner
);

CREATE POLICY "Users can delete their own photos"
ON storage.objects FOR DELETE
USING (
    bucket_id = 'waste_photos' 
    AND auth.uid() = owner
);