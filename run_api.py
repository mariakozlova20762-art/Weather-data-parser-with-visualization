#!/usr/bin/env python 
# -*- coding: utf-8 -*- 
 
\"\"\"Запуск FastAPI сервера\"\"\" 
 
import uvicorn 
from src.api import app 
 
if __name__ == \"__main__\": 
    uvicorn.run( 
        app, 
        host=\"0.0.0.0\", 
        port=8000, 
        reload=True  # Автоматическая перезагрузка при изменениях 
    ) 
