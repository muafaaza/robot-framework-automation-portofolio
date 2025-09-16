from openpyxl import load_workbook

FILE_PATH = 'resource/testdata/testdata_mobile.xlsx'
wb = load_workbook(filename=FILE_PATH, data_only=True)

sheet = wb['mobile']
username = sheet['A2'].value
username_false = sheet['A3'].value
password = sheet['B2'].value
password_false = sheet['B3'].value