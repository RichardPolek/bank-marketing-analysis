import csv
import sqlite3

conn = sqlite3.connect("bank.db")
cur = conn.cursor()

cur.execute("DROP TABLE IF EXISTS clients")
cur.execute("""
CREATE TABLE clients (
    age       INTEGER,
    job       TEXT,
    marital   TEXT,
    education TEXT,
    "default" TEXT,
    balance   INTEGER,
    housing   TEXT,
    loan      TEXT,
    contact   TEXT,
    day       INTEGER,
    month     TEXT,
    duration  INTEGER,
    campaign  INTEGER,
    pdays     INTEGER,
    previous  INTEGER,
    poutcome  TEXT,
    deposit   TEXT
)
""")

with open("bank.csv", newline="", encoding="utf-8") as f:
    reader = csv.reader(f)
    header = next(reader)
    cur.executemany(
        "INSERT INTO clients VALUES (" + ",".join("?" * len(header)) + ")",
        reader,
    )

conn.commit()

count = cur.execute("SELECT COUNT(*) FROM clients").fetchone()[0]
print(f"Pocet riadkov: {count}\n")

rows = cur.execute("SELECT * FROM clients LIMIT 5").fetchall()
cols = [d[0] for d in cur.description]
print(" | ".join(cols))
for row in rows:
    print(" | ".join(str(v) for v in row))

conn.close()
