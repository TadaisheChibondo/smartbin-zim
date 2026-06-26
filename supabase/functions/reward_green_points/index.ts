import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  try {
    // Parse the webhook payload
    const payload = await req.json()
    const record = payload.record

    // 1. Verify this is a new insert and confidence is high enough (e.g., > 80%)
    if (payload.type === 'INSERT' && record.confidence_score >= 0.80) {
      
      // 2. Initialize Supabase Admin Client to bypass RLS
      const supabaseAdmin = createClient(
        Deno.env.get('SUPABASE_URL') ?? '',
        Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
      )

      const POINTS_REWARD = 10;

      // 3. Call the secure RPC to increment the points atomically
      const { error } = await supabaseAdmin.rpc('increment_green_points', {
        user_id: record.user_id,
        points_to_add: POINTS_REWARD
      })

      if (error) throw error;

      // TODO for later: Trigger Push Notification to user's device here
      console.log(`Successfully awarded ${POINTS_REWARD} points to user ${record.user_id}`);

      return new Response(JSON.stringify({ success: true, message: "Points awarded" }), {
        headers: { "Content-Type": "application/json" },
        status: 200,
      })
    }

    // If confidence was too low or not an insert, just return 200 to acknowledge receipt
    return new Response(JSON.stringify({ success: true, message: "No points awarded (criteria not met)" }), {
      headers: { "Content-Type": "application/json" },
      status: 200,
    })

  } catch (error) {
    console.error("Error processing webhook:", error.message)
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { "Content-Type": "application/json" },
      status: 400,
    })
  }
})