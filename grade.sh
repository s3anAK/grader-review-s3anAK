CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
cd student-submission
#echo 'Finished cloning'

if [[ -f ListExamples.java ]]
then
    echo 'Correct file submitted'
else
    echo 'ListExamples was not found'
    exit 1
fi

cp ../TestListExamples.java ./