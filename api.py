# -*- coding: utf-8 -*- 
from fastapi import FastAPI 
from pydantic import BaseModel 
from typing import List, Optional 
 
app = FastAPI() 
 
class Item(BaseModel): 
    name: str 
    price: float 
 
@app.get("/") 
def home(): 
    return {"message": "Weather Parser API"} 
 
@app.get("/health") 
def health_check(): 
    return {"status": "healthy"} 
 
@app.get("/weather/{city}") 
def get_weather(city: str, days: Optional[int] = 1): 
    return { 
        "city": city, 
        "temperature": 25, 
        "days": days 
    } 
 
@app.post("/api/v1/check_multiple") 
def check_multiple(items: List[Item]): 
    return {"count": len(items)} 
