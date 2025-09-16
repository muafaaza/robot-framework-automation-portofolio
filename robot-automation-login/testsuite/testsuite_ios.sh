#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "${PROJECT_ROOT}" || exit 1
export PYTHONPATH="${PROJECT_ROOT}:$PYTHONPATH"

if ! command -v wkhtmltopdf &> /dev/null; then
    brew install wkhtmltopdf
fi

REPORT_DIR="${PROJECT_ROOT}/report/report-pdf"
LOG_DIR="${PROJECT_ROOT}/log"
TESTCASE_PATH="${PROJECT_ROOT}/testcase"
CUSTOM_REPORT_SCRIPT="${PROJECT_ROOT}/function/CustomReportGenerator.py"

mkdir -p "${REPORT_DIR}" "${LOG_DIR}"

robot \
  --outputdir "${REPORT_DIR}" \
  --argumentfile "${PROJECT_ROOT}/testsuite/testcase-list/ios.txt" \
  "${TESTCASE_PATH}"

PDF_NAME="ios_report_$(date +%Y-%m-%d_%H-%M-%S).pdf"
PDF_PATH="${REPORT_DIR}/${PDF_NAME}"

python3 "${CUSTOM_REPORT_SCRIPT}" "${REPORT_DIR}/output.xml" "${PDF_PATH}"

TS="$(date +%Y-%m-%d_%H-%M-%S)"
DEST="${LOG_DIR}/${TS}"
mkdir -p "${DEST}"
for file in "${REPORT_DIR}"/*; do
    [[ -f "$file" && "$file" != *.pdf ]] && mv "$file" "${DEST}/"
done

echo "✅ Done! Report saved as: ${PDF_PATH}"
echo "📂 All raw Robot logs moved to: ${DEST}"
