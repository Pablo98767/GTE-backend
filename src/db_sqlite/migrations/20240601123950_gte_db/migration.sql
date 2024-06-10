/*
  Warnings:

  - You are about to drop the `course_orders` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `courses` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_favorite_courses` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `course_id` on the `categories` table. All the data in the column will be lost.
  - Added the required column `vehicle_id` to the `categories` table without a default value. This is not possible if the table is not empty.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "course_orders";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "courses";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "user_favorite_courses";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "vehicle" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "price" REAL NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "deleted_by" TEXT,
    "created_by" TEXT,
    "category_id" TEXT NOT NULL,
    CONSTRAINT "vehicle_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "user_favorite_vehicles" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "deleted_by" TEXT,
    "created_by" TEXT,
    "user_id" TEXT NOT NULL,
    "vehicle_id" TEXT NOT NULL,
    CONSTRAINT "user_favorite_vehicles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "vehicle_orders" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "order_id" TEXT NOT NULL,
    "vehicle_id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "totalAmount" REAL NOT NULL,
    CONSTRAINT "vehicle_orders_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "vehicle_orders_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_categories" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "vehicle_id" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "deleted_by" TEXT,
    "created_by" TEXT
);
INSERT INTO "new_categories" ("created_at", "created_by", "deleted_by", "description", "id", "is_active", "name", "updated_at") SELECT "created_at", "created_by", "deleted_by", "description", "id", "is_active", "name", "updated_at" FROM "categories";
DROP TABLE "categories";
ALTER TABLE "new_categories" RENAME TO "categories";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
