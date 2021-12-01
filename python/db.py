import asyncio

from app.db.init_db import init_db
from app.db.session import SessionLocal

async def init() -> None:
    async with SessionLocal() as db:
        init_db(db)
        
if __name__ == "__main__":
    asyncio.run(main())
