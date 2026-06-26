import io
from fastapi import FastAPI, UploadFile, File, HTTPException
from pydantic import BaseModel
from PIL import Image
from transformers import pipeline

app = FastAPI(title="SmartBin Zim AI Service")

# Load the model globally at startup. 
# This pulls the ViT model from Hugging Face and caches it locally.
print("Loading Hugging Face model... This might take a minute on first run.")
classifier = pipeline("image-classification", model="yangy50/garbage-classification")
print("Model loaded successfully!")

class WastePrediction(BaseModel):
    waste_type: str
    confidence: float

@app.post("/classify", response_model=WastePrediction)
async def classify_waste(file: UploadFile = File(...)):
    # Validate that the incoming payload is an image
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File must be an image.")
    
    try:
        # Read the file bytes into memory
        image_bytes = await file.read()
        
        # Convert bytes to a Pillow Image (RGB format is required for ViT)
        image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
        
        # Run inference
        # The pipeline returns a list of dictionaries sorted by confidence:
        # [{'label': 'plastic', 'score': 0.9812}, {'label': 'trash', 'score': 0.0104}, ...]
        results = classifier(image)
        top_prediction = results[0]
        
        return {
            "waste_type": top_prediction["label"],
            "confidence": round(top_prediction["score"], 4)
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error processing image: {str(e)}")

@app.get("/health")
async def health_check():
    return {"status": "AI Service is online and the ViT model is loaded."}