import httpx
import os
import enum
import uuid

from typing import List, Optional
from uuid import UUID
from httpx import HTTPStatusError
from pydantic import BaseModel, Field
from pydantic.tools import parse_obj_as

def get_machine_id() -> UUID:
    machine_id = os.popen("cat /etc/machine-id").read().strip()
    return uuid.UUID(machine_id)
