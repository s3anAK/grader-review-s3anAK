CPATH='.;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
cd student-submission
echo 'Finished cloning'

if [[ -f ListExamples.java ]]
then
    echo 'Correct file submitted'
else
    echo 'ListExamples was not found'
    exit 1
fi

cp ../TestListExamples.java ./
javac -cp $CPATH *.java

if [[ $? -eq 1 ]]
then
    echo 'The tests did not compile'
    exit 1
else
    echo 'The tests compiled!'
fi

javac ListExamples.java

if [[ $? -eq 1 ]]
then
    echo 'ListExamples did not compile'
    exit 1
else
    echo 'ListExamples compiled!'
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

failures=`grep -Po 'Failures:\s\K\d+' output.txt`
OK=`grep -Po 'OK\s\(\K\d+' output.txt`
testsRun=`grep -Po 'Tests\srun:\s\K\d+' output.txt`

if [[ -z $failures ]]
then
    echo Your grade was 100%!
    echo You passed all $OK test\(s\)!
else

    echo There are $failures failure\(s\)

    grade=$((($testsRun-$failures)/$testsRun))%

    echo Your grade was $grade
fi





    