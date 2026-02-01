from fastapi import FastAPI, UploadFile, File, Form
from typing import Optional

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/ecg")
def upload_ecg(
    ecg_file: UploadFile = File(...),
    mrn: str = Form(...),
    patient_name: Optional[str] = Form(None),
    dob: Optional[str] = Form(None),
    timestamp: str = Form(...)
):
    return {
        "status": "stored",
        "record_id": "dummy-id-123"
    }
