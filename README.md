# Database_Programming

วิธีเข้าโปรเจค (Viusal Studio Code)
1. Clone โปรเจคจาก GitHub
2. เปิด MySQL Workbench เลือกแท็ป Administration หรือ Server เลือก Data Import/Restore
3. เลือก Import from Dump Project Folder คลิก ... เลือกโฟลเดอร์ shabu3peenong ในโฟลเดอร์ที่ Clone มา
4. ที่ Default Target Schema: เลือก New... และพิมพ์ shabu3peenong
5. คลิก Start Import
6. บน GitHub Desktop เปิดโปรเจคผ่าน Viusal Studio Code
7. คลิกขวาที่โฟลเดอร์ Project เลือก Open in Integrated Terminal
8. บน Terminal พิมพ์ pip install --user pipenv (pip3 install --user pipenv สำหรับ Mac) หากเคยทำแล้วให้ข้าม
9. บน Terminal พิมพ์ pipenv shell เพื่อเข้าสู่ Visual Environment
10. บน Terminal พิมพ์ pipenv install เพื่อติดตั้ง Package เช่น Django ทำทุกครั้งที่มีการ Clone
11. บน Terminal พิมพ์ cd shabu3peenong เพื่อเข้าโฟลเดอร์โปรเจค
12. เปิด settings.py ในโฟลเดอร์ Project/shabu3peenong เลื่อนลงมาที่ส่วน Database เปลี่ยน PASSWORD เป็นรหัสผ่านที่ใช้เข้า MySQL ของตัวเอง

        DATABASES = {
            'default': {
                'ENGINE': 'mysql.connector.django',
                'NAME': 'shabu3peenong',
                'USER': 'root',
                'PASSWORD': 'รหัสผ่านที่ใช้เข้า MySQL ของตัวเอง', <- เปลี่ยนแค่ตรงนี้
                'HOST': '127.0.0.1',
                'PORT': '3306',
            }
        }

13. บน Terminal พิมพ์ python manage.py check หากขึ้น System check identified no issues (0 silenced). ถือว่าเสร็จสมบูรณ์