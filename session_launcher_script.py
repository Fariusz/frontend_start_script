import pyautogui as p
import time

time.sleep(5)

servers = {
    9000 : "oneHR-app",
    8080 : "keycloak",
    5432 : "postgres",
    5050 : "pg-admin",
    7000 : "gateway",
    7001 : "task-service",
    7005 : "asignment-service",
    7002 : "user-service",
    7006 : "notification-service",
    7003 : "parser-service",
    8500 : "consul",
    4199 : "administration-front",
    4200 : "main-overlay-front",
    4198 : "associate-front"
}
terminals = {
    "container" : "npm run --prefix container start",
    "main-overlay" : "npm run --prefix main-overlay serve:single-spa:main-overlay",
    "administration" : "npm run --prefix administration serve:single-spa:administration",
    "associate" : "npm run --prefix associate start"
}
terminalType = "Read/write"

p.hotkey('ctrl', 'shift', 'p')
p.typewrite('Live Share: Start Collaboration Session')
p.press('enter')

time.sleep(10)

for port, name in servers.items():
    time.sleep(1)
    p.hotkey('ctrl', 'shift', 'p')
    time.sleep(2)
    p.typewrite('Live Share: Share Server')
    time.sleep(2)
    p.press('enter')
    time.sleep(1)
    p.typewrite(f'{port}')
    p.press('enter')
    time.sleep(1)
    p.typewrite(f'{name}')
    p.press('enter')



for name, command in terminals.items():
    time.sleep(1)
    p.hotkey('ctrl', 'shift', 'p')
    time.sleep(1)
    p.typewrite('Live Share: Share terminal')
    time.sleep(2)
    p.press('enter')
    p.typewrite(f'{terminalType}')
    p.press('enter')
    time.sleep(2)
    p.typewrite(command)
    p.press('enter')
