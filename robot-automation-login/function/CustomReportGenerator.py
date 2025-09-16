import xml.etree.ElementTree as ET      # Buat parsing file XML (output.xml)
from datetime import datetime           # Buat bikin timestamp di nama file
import pdfkit                           # Buat convert HTML jadi PDF
import os                               # Buat manipulasi path file & cek file
import time                             # Buat delay (kalau mau dipakai nantinya)

class CustomReportGenerator:

    def generate_pdf_report(self, xml_file='output.xml', pdf_file=None):
        # Kalau gak dikasih nama PDF, generate otomatis pakai timestamp
        if not pdf_file:
            now = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
            output_dir = os.path.dirname(xml_file)
            pdf_file = os.path.join(output_dir, f"report_pdf_{now}.pdf")

        # Parse isi output.xml hasil eksekusi Robot Framework
        tree = ET.parse(xml_file)
        root = tree.getroot()

        # Buat counter untuk hitung total test, yang pass, dan fail
        total_tests = 0
        passed_tests = 0
        failed_tests = 0

        # Template HTML awal: styling + judul
        html_content = """
        <html><head><style>
        body { font-family: Arial; }
        h1 { color: #1F618D; }
        h2 { color: #2874A6; margin-bottom: 5px; }
        p { margin: 2px 0; }
        table { border-collapse: collapse; width: 100%; margin-top: 5px; }
        th, td { border: 1px solid #ddd; padding: 8px; font-size: 14px; text-align: left; }
        th { background-color: #f2f2f2; }
        .pass { color: green; font-weight: bold; }
        .fail { color: red; font-weight: bold; }
        .section { margin-bottom: 30px; }
        .success-banner { 
            background-color: #d4edda; 
            color: #155724; 
            padding: 15px; 
            border-radius: 5px; 
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
        </style></head><body>
        <h1>Robot Framework - Passed Tests Report</h1>
        """

        # Collect semua test yang PASS aja
        passed_test_details = []

        # Loop ke semua suite yang punya test case
        for suite in root.findall(".//suite"):
            if suite.findall("test"):
                for test in suite.findall("test"):
                    total_tests += 1  # Tambah total test

                    # Ambil status test: PASS atau FAIL
                    status_elem = test.find("status")
                    test_status = status_elem.get("status")

                    # Hitung pass dan fail
                    if test_status == "PASS":
                        passed_tests += 1
                        # Simpan detail test yang PASS
                        test_name = test.get("name")
                        duration = status_elem.get("elapsed")
                        
                        # Collect keyword steps
                        steps = []
                        for kw in test.findall("kw"):
                            kw_name = kw.get("name")
                            kw_status_elem = kw.find("status")
                            kw_status = kw_status_elem.get("status") if kw_status_elem is not None else "NOT RUN"
                            steps.append({
                                'name': kw_name,
                                'status': kw_status
                            })
                        
                        passed_test_details.append({
                            'name': test_name,
                            'duration': duration,
                            'steps': steps
                        })
                    elif test_status == "FAIL":
                        failed_tests += 1

        # Cek apakah ada test yang PASS
        if passed_tests == 0:
            html_content += """
            <div class="section" style="text-align: center; color: #856404; background-color: #fff3cd; padding: 20px; border-radius: 5px;">
                <h2>⚠️ No Passed Tests Found</h2>
                <p>All test cases failed or no test cases were executed.</p>
            </div>
            </body></html>
            """
        else:
            # Tambahkan success banner
            html_content += f"""
            <div class="success-banner">
                <h3>Success Summary</h3>
                <p><strong>{passed_tests}</strong> out of <strong>{total_tests}</strong> test cases passed successfully!</p>
            </div>
            """

            # Hitung persentase PASS
            percent_pass = (passed_tests / total_tests) * 100 if total_tests else 0

            # Tambahkan summary ke HTML (cuma yang PASS)
            html_content += f"""
            <div class="section">
                <h2>Passed Tests Summary</h2>
                <p><strong>Total Passed:</strong> {passed_tests}</p>
                <p><strong>Success Rate:</strong> {percent_pass:.2f}%</p>
                <p><strong>Failed Tests:</strong> {failed_tests} (excluded from this report)</p>
            </div>
            """

            # Loop detail setiap test case yang PASS aja
            for test_detail in passed_test_details:
                html_content += f"""
                <div class="section">
                <h2>Test Case: {test_detail['name']}</h2>
                <p><strong>Status:</strong> <span class="pass">PASS</span></p>
                <p><strong>Duration:</strong> {test_detail['duration']} seconds</p>
                <table>
                    <tr><th>Step</th><th>Status</th></tr>
                """

                # Tampilkan steps
                for step in test_detail['steps']:
                    html_content += f"<tr><td>{step['name']}</td><td class='{step['status'].lower()}'>{step['status']}</td></tr>"

                html_content += "</table></div>"

        # Tutup HTML
        html_content += "</body></html>"

        # Convert HTML ke PDF pakai wkhtmltopdf
        try:
            config = pdfkit.configuration(wkhtmltopdf='/usr/local/bin/wkhtmltopdf')
            pdfkit.from_string(html_content, pdf_file, configuration=config)
            print(f"✅ Passed Tests PDF Report generated: {pdf_file}")
            print(f"📊 Report contains {passed_tests} passed test cases (out of {total_tests} total)")
        except Exception as e:
            print(f"❌ Error generating PDF: {e}")
            # Fallback: save as HTML
            html_file = pdf_file.replace('.pdf', '.html')
            with open(html_file, 'w', encoding='utf-8') as f:
                f.write(html_content)
            print(f"💾 Saved as HTML instead: {html_file}")

# Bisa dijalankan langsung via terminal:
# python generate_pdf.py output.xml custom_name.pdf
if __name__ == "__main__":
    import sys
    xml_path = sys.argv[1] if len(sys.argv) > 1 else "output.xml"
    pdf_path = sys.argv[2] if len(sys.argv) > 2 else None

    report = CustomReportGenerator()
    report.generate_pdf_report(xml_file=xml_path, pdf_file=pdf_path)
