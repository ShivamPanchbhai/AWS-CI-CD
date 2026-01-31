from fastapi import FastAPI, UploadFile, File, Form # fastapi is the python module in lowercase & FastAPI is the class inside that module in uppercase

app = FastAPI() # creating one instance of FastAPI so after this, app variable will behave like FastAPI

@app.get("/health")  # calling FastAPI’s get() method with "/health"

def health():        # health function
    return {"status": "ok"} # Function returns {"status": "ok"}

@app.post("/ecg")    # calling FastAPI’s post() method with "/ecg"
 
def upload_ecg(
    ecg_file    :  UploadFile  = File(...),
    mrn         :      str     = Form(...),
    patient_name:      str     | None = Form(None),
    dob         :      str     | None = Form(None),
    timestamp   :      str     | Form(..)
):
    return {
        "status": "stored",
        "record_id": "dummy-id-123"
    }

