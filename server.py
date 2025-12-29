# -*- coding: utf-8 -*- 
from fastapi import FastAPI 
import uvicorn 
Режим вывода команд на экран (ECHO) включен.
app = FastAPI() 
Режим вывода команд на экран (ECHO) включен.
@app.get("/") 
def root(): 
    return {"status": "OK", "message": "Server is running"} 
Режим вывода команд на экран (ECHO) включен.
if __name__ == "__main__": 
    uvicorn.run(app, host="0.0.0.0", port=8000) 
