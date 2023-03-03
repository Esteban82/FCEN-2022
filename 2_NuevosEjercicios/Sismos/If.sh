# Warming message if N > 20001 (only 20000 can be download, +1 due to the header)
if (( $(wc --lines < query.csv) > 20001 ));   then
    grep "Error" query.csv -A2
	else
		#echo "NO ERROR"
        gmt info query.csv -h1
	fi
        #grep "Error" query.csv -A2

        # Warming message if N > 20001 (only 20000 can be download, +1 due to the header)
if (( $(wc --lines < bad_query.csv) > 20001 ));   then
    grep "Error" bad_query.csv -A2
	else
		#echo "NO ERROR"
        gmt info bad_query.csv -h1
	fi
        grep "Error" query.csv -A2
        grep "Error" bad_query.csv -A2