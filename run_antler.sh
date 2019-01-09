# example to run script:
# ./run_antler.sh Smoola 

if [ $# -eq 0 ]; then
	echo "No Arguments Supplied..."
	exit 1
fi

export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

./clean.sh $1 j

# antler4 test.g4
java -jar /usr/local/lib/antlr-4.7.1-complete.jar $1.g4

javac *.java

if [ "$2" = "Mohammad" ]; then
	java mySmoola in2.sml
else
	java mySmoola in.sml
fi

./clean.sh $1

java -jar jasmin.jar *.j