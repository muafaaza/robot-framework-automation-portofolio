from openpyxl import load_workbook

FILE_PATH = 'robot-automation-login-playwright/resource/testdata/testdata_web.xlsx'
wb = load_workbook(filename=FILE_PATH, data_only=True)

sheet = wb['web']
username = sheet['A2'].value
username_false = sheet['A3'].value
password = sheet['B2'].value
password_false = sheet['B3'].value