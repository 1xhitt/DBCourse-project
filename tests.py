import psycopg2
import pytest

DATABASE = "games"
USER = "pguser"
PASSWORD = "pguser123"
PORT = "5432"
HOST = "0.0.0.0"

def test_avg_price():
    conn = psycopg2.connect(database=DATABASE,
                        host=HOST,
                        user=USER,
                        password=PASSWORD,
                        port=PORT)
    cur = conn.cursor()
    cur.execute("""
        SELECT vendor_name, AVG(price)
        FROM vendor_offerings vo JOIN vendor ON vo.vendor_id = vendor.id
        GROUP BY vendor_name;
        """)
    testee =  cur.fetchall()
    print(testee)

def main():
    test_avg_price()

if __name__ == "__main__":
    main()