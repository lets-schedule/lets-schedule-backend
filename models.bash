#!/bin/bash

# rails generate model User name:string email:string
# rails generate model Task title:string priority:integer completed_amount:decimal type:boolean
#rails generate model Event start_date_time:datetime end_date_time:datetime
#rails generate model Conflict duration:integer due_time:datetime

# controller generation
rails generate controller UserController
rails generate controller TaskController
rails generate controller EventController
rails generate controller ConflictController
