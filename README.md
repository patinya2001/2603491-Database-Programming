# Database_Programming

วิธีเข้าโปรเจค (Viusal Studio Code)
1. Clone โปรเจคจาก GitHub
2. บน GitHub Desktop เปิดโปรเจคผ่าน Viusal Studio Code
3. คลิกขวาที่โฟลเดอร์ Project เลือก Open in Integrated Terminal
4. บน Terminal พิมพ์ pip install --user pipenv (pip3 install --user pipenv สำหรับ Mac) หากเคยทำแล้วให้ข้าม
5. บน Terminal พิมพ์ pipenv shell เพื่อเข้าสู่ Visual Environment
6. บน Terminal พิมพ์ pipenv install เพื่อติดตั้ง Package เช่น Django ทำทุกครั้งที่มีการ Clone
7. บน Terminal พิมพ์ cd shabu3peenong เพื่อเข้าโฟลเดอร์โปรเจค
8. บน Terminal พิมพ์ python manage.py check หากขึ้น System check identified no issues (0 silenced). ถือว่าเสร็จสมบูรณ์