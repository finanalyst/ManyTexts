PR=makehtml
FN=hwt.csv
CSS=first.css

compile:
	perl6 -c $(PR).p6

run:
	perl6 $(PR).p6 --css=$(CSS) $(FN)
