#!/bin/bash
# diamond-accounting
# (c) Ian Dennis Miller

function pandoc_unbudgeted {
  echo
  echo "Unbudgeted Expenses"
  echo "--------------------"
  echo
  echo 'Category                                                                               Delta   Running Balance'
  echo '-------------------------------------------------------------------------- ----------------- -----------------'
  echo "${UNBUDGETED}"
}

function pandoc_budget {
  echo '\pagenumbering{gobble}'
  echo
  echo "Budget Balance Sheet"
  echo "============================"
  echo
  echo "${PERIOD}"
  echo "--------------------"
  echo
  echo "Budgeted Expenses"
  echo "--------------------"
  echo
  echo 'Category                                                                               Delta   Running Balance'
  echo '-------------------------------------------------------------------------- ----------------- -----------------'
  ledger -p "${PERIOD}" --budget --monthly register ^expenses | cut -c60-
  UNBUDGETED=$(ledger -p "${PERIOD}" --unbudgeted --monthly register ^expenses | cut -c60-)
  if [[ ! -z "${UNBUDGETED}" ]]; then
    pandoc_unbudgeted
  fi
}

function render_budget {
  echo "Render: Cover Budgeted Expense Report for the month of ${PERIOD}"
  pandoc_budget > ledgeroutput1.tmp
  pandoc -f markdown -o tmp-budget.pdf ledgeroutput1.tmp
  rm ledgeroutput*.tmp
}

function pandoc_cover {
  echo '\pagenumbering{gobble}'
  echo '\vspace*{50pt}'
  echo "\center \Huge{${NAME}}"
  echo '\vspace*{25pt}'
  echo "\center \huge{Monthly Financial Statement}"
  echo "\center \huge{${PERIOD}}"
}

function render_cover {
  echo "Render: Cover Page for the month of ${PERIOD}"
  pandoc_cover > ledgeroutput1.tmp
  pandoc -f markdown -o tmp-cover.pdf ledgeroutput1.tmp
  rm ledgeroutput*.tmp
}

# Usage: pandoc_income_expense PERIOD NAME
function pandoc_income_expense {
  echo '\pagenumbering{gobble}'
  echo
  echo "Income and Expenses Sheet"
  echo "============================"
  echo
  echo "${PERIOD}"
  echo "--------------------"
  echo
  ledger -p "${PERIOD}" --monthly balance ^expenses ^income
}

# Usage: render_income_expense YYYY MM NAME
function render_income_expense {
  echo "Render: Income/Expense Sheet for the month of ${PERIOD}"
  pandoc_income_expense > ledgeroutput1.tmp
  pandoc -f markdown -o tmp-i-e.pdf ledgeroutput1.tmp
  rm ledgeroutput*.tmp
}

# pandoc_balance PERIOD NAME
function pandoc_balance {
  echo '\pagenumbering{gobble}'
  echo
  echo "Balance Sheet"
  echo "================="
  echo
  echo "${PERIOD}"
  echo "--------------------"
  ledger -e "${NEXTYEAR}-${NEXTMONTH}-01" balance ^assets ^liabilities
}

function render_balance {
  echo "Render: Balance Sheet for the month starting on ${PERIOD}"
  pandoc_balance > ledgeroutput1.tmp
  pandoc -f markdown -o tmp-balance.pdf ledgeroutput1.tmp
  rm ledgeroutput*.tmp
}

# https://www.sundialdreams.com/report-scripts-for-ledger-cli-with-gnuplot/

function render_ytd_cashflow {
  echo "Render: YTD Cashflow Graph ${PERIOD}"

  ledger -p "${PERIOD}" -J reg ^Income -M --collapse --plot-total-format="%(format_date(date, \"%Y-%m-%d\")) %(abs(quantity(scrub(display_total))))\n" > ledgeroutput1.tmp
  ledger -p "${PERIOD}" -J reg ^Expenses -M --collapse > ledgeroutput2.tmp

  (cat <<EOF) | gnuplot
    set term postscript eps enhanced color
    set output '|ps2pdf -dPDFSETTINGS=/prepress -dEPSCrop - tmp-ytd-cashflow.pdf'
    set xdata time
    set timefmt "%Y-%m-%d"
    set xrange ["${LASTYEAR}-12-20":"${THISYEAR}-12-10"]
    set xtics nomirror "$(date +%Y)-01-01",2592000 format "%b"
    unset mxtics
    set mytics 2
    set grid xtics ytics mytics
    set title "Cashflow"
    set ylabel "Accumulative Income and Expenses"
    set style fill transparent solid 0.6 noborder
    plot "ledgeroutput1.tmp" using 1:2 with filledcurves x1 title "Income" linecolor rgb "blue", '' using 1:2:2 with labels font "Courier,8" offset 0,0.5 textcolor linestyle 0 notitle, "ledgeroutput2.tmp" using 1:2 with filledcurves y1=0 title "Expenses" linecolor rgb "gray", '' using 1:2:2 with labels font "Courier,8" offset 0,0.5 textcolor linestyle 0 notitle
EOF

    rm ledgeroutput*.tmp
}

function render_ytd_income_expense {
  echo "Render: YTD Income/Expense Graph ${PERIOD}"

  ledger -p "${PERIOD}" -j reg ^Income -M --collapse --plot-amount-format="%(format_date(date, \"%Y-%m-%d\")) %(abs(quantity(scrub(display_amount))))\n" > ledgeroutput1.tmp
  ledger -p "${PERIOD}" -j reg ^Expenses -M --collapse > ledgeroutput2.tmp

  (cat <<EOF) | gnuplot
    set term postscript eps enhanced color
    set output '|ps2pdf -dPDFSETTINGS=/prepress -dEPSCrop - tmp-ytd-income-expense.pdf'
    set style data histogram
    set style histogram clustered gap 1
    set style fill transparent solid 0.4 noborder
    set xtics nomirror scale 0 center
    set ytics add ('' 0) scale 0
    set border 1
    set grid ytics
    set title "Monthly Income and Expenses"
    set ylabel "Amount"
    plot "ledgeroutput1.tmp" using 2:xticlabels(strftime('%b', strptime('%Y-%m-%d', strcol(1)))) title "Income" linecolor rgb "blue", '' using 0:2:2 with labels left font "Courier,8" rotate by 15 offset -4,0.5 textcolor linestyle 0 notitle, "ledgeroutput2.tmp" using 2 title "Expenses" linecolor rgb "gray", '' using 0:2:2 with labels left font "Courier,8" rotate by 15 offset 0,0.5 textcolor linestyle 0 notitle
EOF

    rm ledgeroutput*.tmp
}

function render_ytd_wealthgrowth {
  echo "Render: YTD Wealth Growth Graph ${PERIOD}"

  ledger -p "${PERIOD}" -J reg ^Assets -M --collapse > ledgeroutput1.tmp
  ledger -p "${PERIOD}" -J reg ^Liabilities -M --collapse --plot-total-format="%(format_date(date, \"%Y-%m-%d\")) %(abs(quantity(scrub(display_total))))\n" > ledgeroutput2.tmp

  (cat <<EOF) | gnuplot
    set term postscript eps enhanced color
    set output '|ps2pdf -dPDFSETTINGS=/prepress -dEPSCrop - tmp-ytd-wealthgrowth.pdf'
    set xdata time
    set timefmt "%Y-%m-%d"
    set xrange ["${LASTYEAR}-12-20":"${THISYEAR}-12-10"]
    set xtics nomirror "$(date +%Y)-01-01",2592000 format "%b"
    unset mxtics
    set mytics 2
    set grid xtics ytics mytics
    set title "Wealth Growth"
    set ylabel "Amount"
    set style fill transparent solid 0.6 noborder
    plot "ledgeroutput1.tmp" using 1:2 with filledcurves x1 title "Assets" linecolor rgb "goldenrod", '' using 1:2:2 with labels font "Courier,8" offset 0,0.5 textcolor linestyle 0 notitle, "ledgeroutput2.tmp" using 1:2 with filledcurves y1=0 title "Liabilities" linecolor rgb "violet", '' using 1:2:2 with labels font "Courier,8" offset 0,0.5 textcolor linestyle 0 notitle
EOF

  rm ledgeroutput*.tmp
}

function render_month {
  # set a bunch of variables
  THISYEAR=$1
  THISMONTH=$2
  NAME=$3

  # for convenience, pre-calculate adjacent months and years
  NEXTMONTH=$(echo "$2+1" | bc | awk '{printf "%02d\n", $0;}')
  NEXTYEAR=$1
  LASTYEAR=$(echo "$1-1" | bc)

  # arg... hardcode: just tick over month and year when month is December
  if [[ "${THISMONTH}" == "12" ]]; then
    NEXTMONTH=01
    NEXTYEAR=$(echo "$1+1" | bc)
  fi

  # render each sheet of the statement as a PDF
  PERIOD="${THISYEAR}-${THISMONTH}"
  render_cover
  render_balance
  render_income_expense
  render_budget

  PERIOD="from ${THISYEAR}-01-01 to ${NEXTYEAR}-${NEXTMONTH}-01"
  render_ytd_cashflow
  render_ytd_income_expense
  render_ytd_wealthgrowth

  # combine PDFs
  echo "Combine PDFs: products/${THISYEAR}/${THISYEAR}-${THISMONTH}.pdf"
  pdfjoin -o "products/${THISYEAR}/${THISYEAR}-${THISMONTH}.pdf" \
    tmp-cover.pdf \
    tmp-balance.pdf \
    tmp-budget.pdf \
    tmp-i-e.pdf \
    tmp-ytd-cashflow.pdf \
    tmp-ytd-income-expense.pdf \
    tmp-ytd-wealthgrowth.pdf \
      > /dev/null 2>&1

  echo "Clean up"
  rm tmp*.pdf

  echo "Done"
}

if [[ -z $2 ]]; then
  echo "Error: year and month are required."
  echo
  echo "Usage: create-statement.sh YYYY MM NAME"
  echo "Example: create-statement.sh 2017 01 BigCompany"
  echo
  exit
fi

render_month $@
