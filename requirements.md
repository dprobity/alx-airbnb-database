# νΏ  Airbnb Clone β ERD Documentation

This document outlines the database schema for an Airbnb-like platform. The schema includes users, properties, bookings, payments, messages, and reviews.

---

## ν³ Table: `users`

| Column        | Type       | Description                         |
|---------------|------------|-------------------------------------|
| user_id       | UUID (PK)  | Unique user identifier              |
| first_name    | VARCHAR    | First name                          |
| last_name     | VARCHAR    | Last name                           |
| email         | VARCHAR    | Unique email                        |
| password_hash | VARCHAR    | Hashed password                     |
| phone_number  | VARCHAR    | Phone number (optional)            |
| role          | ENUM       | User role: `guest`, `host`, `admin` |
| created_at    | TIMESTAMP  | Time of account creation            |

---

## νΏ  Table: `properties`

| Column          | Type       | Description                        |
|-----------------|------------|------------------------------------|
| property_id     | UUID (PK)  | Unique property ID                 |
| host_id         | UUID (FK)  | References `users(user_id)`       |
| name            | VARCHAR    | Property name                      |
| description     | TEXT       | Description of the property        |
| location        | VARCHAR    | Location string                    |
| price_per_night | DECIMAL    | Price per night                    |
| created_at      | TIMESTAMP  | Property creation time             |
| updated_at      | TIMESTAMP  | Last update timestamp              |

---

## ν³ Table: `bookings`

| Column       | Type       | Description                                  |
|--------------|------------|----------------------------------------------|
| booking_id   | UUID (PK)  | Unique booking ID                            |
| property_id  | UUID (FK)  | References `properties(property_id)`         |
| user_id      | UUID (FK)  | References `users(user_id)`                  |
| start_date   | DATE       | Check-in date                                |
| end_date     | DATE       | Check-out date                               |
| total_price  | DECIMAL    | Total booking cost                           |
| status       | ENUM       | `pending`, `confirmed`, `cancelled`, `completed` |
| created_at   | TIMESTAMP  | Booking creation timestamp                   |

---

## ν²³ Table: `payments`

| Column         | Type       | Description                         |
|----------------|------------|-------------------------------------|
| payment_id     | UUID (PK)  | Unique payment ID                   |
| booking_id     | UUID (FK)  | References `bookings(booking_id)`  |
| amount         | DECIMAL    | Payment amount                      |
| payment_date   | TIMESTAMP  | When payment was made               |
| payment_method | ENUM       | `card`, `paypal`, `bank_transfer`  |

---

## ν²¬ Table: `messages`

| Column        | Type       | Description                        |
|---------------|------------|------------------------------------|
| message_id    | UUID (PK)  | Unique message ID                  |
| sender_id     | UUID (FK)  | References `users(user_id)`       |
| recipient_id  | UUID (FK)  | References `users(user_id)`       |
| message_body  | TEXT       | Message content                    |
| sent_at       | TIMESTAMP  | When message was sent              |

---

## β­ Table: `reviews`

| Column      | Type       | Description                          |
|-------------|------------|--------------------------------------|
| review_id   | UUID (PK)  | Unique review ID                     |
| property_id | UUID (FK)  | References `properties(property_id)`|
| user_id     | UUID (FK)  | References `users(user_id)`         |
| rating      | INTEGER    | Integer rating (1β5)                 |
| comment     | TEXT       | Written review                       |
| created_at  | TIMESTAMP  | When review was submitted            |

---

## ν΄ Relationships Overview

- `users` β `properties` (1:N) via `host_id`  
- `users` β `bookings` (1:N) via `user_id`  
- `properties` β `bookings` (1:N) via `property_id`  
- `bookings` β `payments` (1:1) via `booking_id`  
- `users` β `messages` (1:N as sender and recipient)  
- `users` β `reviews` (1:N)  
- `properties` β `reviews` (1:N)  

---

## βοΈ Notes

This schema is normalized and can be further optimized by replacing ENUMs with lookup tables for better scalability.
# νΏ  Airbnb Clone β ERD Documentation

This document outlines the database schema for an Airbnb-like platform. The schema includes users, properties, bookings, payments, messages, and reviews.

---

## ν³ Table: `users`

| Column        | Type       | Description                         |
|---------------|------------|-------------------------------------|
| user_id       | UUID (PK)  | Unique user identifier              |
| first_name    | VARCHAR    | First name                          |
| last_name     | VARCHAR    | Last name                           |
| email         | VARCHAR    | Unique email                        |
| password_hash | VARCHAR    | Hashed password                     |
| phone_number  | VARCHAR    | Phone number (optional)            |
| role          | ENUM       | User role: `guest`, `host`, `admin` |
| created_at    | TIMESTAMP  | Time of account creation            |

---

## νΏ  Table: `properties`

| Column          | Type       | Description                        |
|-----------------|------------|------------------------------------|
| property_id     | UUID (PK)  | Unique property ID                 |
| host_id         | UUID (FK)  | References `users(user_id)`       |
| name            | VARCHAR    | Property name                      |
| description     | TEXT       | Description of the property        |
| location        | VARCHAR    | Location string                    |
| price_per_night | DECIMAL    | Price per night                    |
| created_at      | TIMESTAMP  | Property creation time             |
| updated_at      | TIMESTAMP  | Last update timestamp              |

---

## ν³ Table: `bookings`

| Column       | Type       | Description                                  |
|--------------|------------|----------------------------------------------|
| booking_id   | UUID (PK)  | Unique booking ID                            |
| property_id  | UUID (FK)  | References `properties(property_id)`         |
| user_id      | UUID (FK)  | References `users(user_id)`                  |
| start_date   | DATE       | Check-in date                                |
| end_date     | DATE       | Check-out date                               |
| total_price  | DECIMAL    | Total booking cost                           |
| status       | ENUM       | `pending`, `confirmed`, `cancelled`, `completed` |
| created_at   | TIMESTAMP  | Booking creation timestamp                   |

---

## ν²³ Table: `payments`

| Column         | Type       | Description                         |
|----------------|------------|-------------------------------------|
| payment_id     | UUID (PK)  | Unique payment ID                   |
| booking_id     | UUID (FK)  | References `bookings(booking_id)`  |
| amount         | DECIMAL    | Payment amount                      |
| payment_date   | TIMESTAMP  | When payment was made               |
| payment_method | ENUM       | `card`, `paypal`, `bank_transfer`  |

---

## ν²¬ Table: `messages`

| Column        | Type       | Description                        |
|---------------|------------|------------------------------------|
| message_id    | UUID (PK)  | Unique message ID                  |
| sender_id     | UUID (FK)  | References `users(user_id)`       |
| recipient_id  | UUID (FK)  | References `users(user_id)`       |
| message_body  | TEXT       | Message content                    |
| sent_at       | TIMESTAMP  | When message was sent              |

---

## β­ Table: `reviews`

| Column      | Type       | Description                          |
|-------------|------------|--------------------------------------|
| review_id   | UUID (PK)  | Unique review ID                     |
| property_id | UUID (FK)  | References `properties(property_id)`|
| user_id     | UUID (FK)  | References `users(user_id)`         |
| rating      | INTEGER    | Integer rating (1β5)                 |
| comment     | TEXT       | Written review                       |
| created_at  | TIMESTAMP  | When review was submitted            |

---

## ν΄ Relationships Overview

- `users` β `properties` (1:N) via `host_id`  
- `users` β `bookings` (1:N) via `user_id`  
- `properties` β `bookings` (1:N) via `property_id`  
- `bookings` β `payments` (1:1) via `booking_id`  
- `users` β `messages` (1:N as sender and recipient)  
- `users` β `reviews` (1:N)  
- `properties` β `reviews` (1:N)  

---

## βοΈ Notes

This schema is normalized and can be further optimized by replacing ENUMs with lookup tables for better scalability.

