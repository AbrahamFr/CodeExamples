import httpx
import os
import enum
import uuid

from typing import List, Optional
from uuid import UUID
from httpx import HTTPStatusError
from pydantic import BaseModel, Field
from pydantic.tools import parse_obj_as


    def __auth_header(self) -> dict:
        headers = {
            "Content-Type": "application/json",
            "Accept": "application/vnd.something.peer-v15+json",
        }
        if self.access_token:
            headers["Authorization"] = f"Bearer {self.access_token}"
        return headers

    def __login(self):
        headers = self.__auth_header()
        client_path = f"{self.url}/{self.api_path}/login"
        creds = SdpCredentials(username=self.user, password=self.password)
        with httpx.Client(verify=False) as client:
            response = client.post(
                url=client_path,
                headers=headers,
                data=creds.json(by_alias=True),
                timeout=self.timeout,
            )
            response.raise_for_status()
            self.access_token = response.json()["token"]
        return self

    def __handle_admin_exception(func):
        def handle_function(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except HTTPStatusError as e:
                none_codes = set({204, 404})
                if e.response.status_code in none_codes:
                    return None
                raise AdminHTTPException(
                    f"Error: {e.response.text}", e.response.status_code
                )
            except Exception as e:
                raise AdminException(e)

        return handle_function

    @__handle_admin_exception
    def create_new_thing(
        self, idp: NewThing
    ) -> Optional[NewThing]:
        headers = self.__auth_header()
        client_path = f"{self.url}/{self.api_path}/new_thing"
        with httpx.Client(verify=False) as client:
            response = client.post(
                url=client_path,
                headers=headers,
                content=idp.json(exclude_none=True, by_alias=True),
                timeout=self.timeout,
            )
            response.raise_for_status()
            return NewThing(**response.json())
