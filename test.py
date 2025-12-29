from fastapi import FastAPI 
from pydantic import BaseModel 
from typing import List 
 
app = FastAPI() 
 
class Item(BaseModel): 
    name: str 
    price: float 
 
@app.get("/") 
def home(): return {"test": "working"} 
 
@app.get("/health") 
def health(): return {"status": "ok"} 
 
@app.post("/check") 
def check(items: List[Item]): return {"count": len(items)} 
