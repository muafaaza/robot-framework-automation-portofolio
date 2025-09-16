#!/bin/bash
# report pdf

# Ambil absolute path dari folder project (lokasi script ini ada di /testsuite, jadi kita naik 1 level)
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Pindah ke project root
cd "${PROJECT_ROOT}" || exit 1

# Set PYTHONPATH
export PYTHONPATH="${PROJECT_ROOT}:$PYTHONPATH"

# Cek wkhtmltopdf
if ! command -v wkhtmltopdf &> /dev/null; then
    echo "⚠️ wkhtmltopdf not found, installing..."
    brew install wkhtmltopdf
fi

# Path penting
REPORT_DIR="${PROJECT_ROOT}/report/report-pdf"
LOG_DIR="${PROJECT_ROOT}/log"
TESTCASE_PATH="${PROJECT_ROOT}/testcase"
CUSTOM_REPORT_SCRIPT="${PROJECT_ROOT}/function/CustomReportGenerator.py"

# Buat folder report & log kalau belum ada
mkdir -p "${REPORT_DIR}" "${LOG_DIR}"

# Jalankan test Robot Framework
robot \
  --outputdir "${REPORT_DIR}" \
  --argumentfile "${PROJECT_ROOT}/testsuite/testcase-list/web.txt" \
  "${TESTCASE_PATH}"

# Tentuin nama PDF langsung di bash
PDF_NAME="web_report_$(date +%Y-%m-%d_%H-%M-%S).pdf"
PDF_PATH="${REPORT_DIR}/${PDF_NAME}"

# Jalankan Custom Report Generator dengan nama PDF custom
echo "📝 Generating custom PDF report..."
python3 "${CUSTOM_REPORT_SCRIPT}" "${REPORT_DIR}/output.xml" "${PDF_PATH}"

# Pindahin semua file non-PDF ke folder log
TS="$(date +%Y-%m-%d_%H-%M-%S)"
DEST="${LOG_DIR}/${TS}"
mkdir -p "${DEST}"
for file in "${REPORT_DIR}"/*; do
    [[ -f "$file" && "$file" != *.pdf ]] && mv "$file" "${DEST}/"
done

echo "✅ Done! Report saved as: ${PDF_PATH}"
echo "📂 All raw Robot logs moved to: ${DEST}"
