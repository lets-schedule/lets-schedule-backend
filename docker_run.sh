#!/bin/bash
docker run --rm -itd -v app-storage:/rails/storage -p 3000:3000 --env RAILS_MASTER_KEY=958a9bdd043ceecb0ff14de4f9cb6a48 app
