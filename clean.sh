rm -rf *.class
rm -rf */*.class
rm -rf */*/*.class
rm -rf */*/*/*.class
rm -rf */*/*/*/*.class
rm -rf *.tokens
rm -rf $1*.java
rm -rf *.interp
if [ "$2" = "j" ]; then
	rm -rf *.j
	rm -rf output/*.j
fi
