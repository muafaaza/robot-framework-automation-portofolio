from openpyxl import load_workbook

FILE_PATH = 'robot-automation-login/resource/testdata/testdata_api.xlsx'
wb = load_workbook(filename=FILE_PATH, data_only=True)

sheet = wb['api']
username = sheet['A2'].value
password = sheet['B2'].value
username_false = sheet['A3'].value
