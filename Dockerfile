FROM python:3.11-slim

WORKDIR /app

COPY app/requirements.txt /app/

# install python libraries
RUN pip install --no-cache-dir -r requirements.txt    

COPY app/ /app/

# the port the app listens on
EXPOSE 8000     

 # 0.0.0.0 = accept traffic from outside container
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

