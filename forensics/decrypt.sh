#!/bin/bash

while read data; do
	steghide extract -sf b.jpg -p $data
done <burnett_top_1024.txt
