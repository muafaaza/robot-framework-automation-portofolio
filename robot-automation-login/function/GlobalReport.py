from openpyxl import load_workbook

FILE_PATH = 'report/report-excel/report-excel.xlsx'

def write_cell(sheet_name, col, row, value):
    wb = load_workbook(filename=FILE_PATH)
    sheet = wb[sheet_name]
    sheet[f'{col}{row}'] = value
    wb.save(FILE_PATH)

def status(row, value):
    write_cell('testing-coverage', 'D', row, value)
