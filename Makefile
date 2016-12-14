PR=makehtml
FN=hw.csv
CSS=manytexts.css

compile:
	perl6 -c $(PR).p6

run:
	perl6 $(PR).p6 --css=$(CSS) $(FN)
	
send:
	git commit . -m updating
	git push