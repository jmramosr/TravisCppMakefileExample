#! /bin/sh
# Create the folders to ensure folder existence.
if [ ! -d ./coverage/  ]; then mkdir -p ./coverage/ ;fi
if [ ! -d ./gcov/  ]; then mkdir -p ./gcov/ ;fi
if [ ! -d ./gcov/trash  ]; then mkdir -p ./gcov/trash ;fi

# Going through ./gcov/trash
cd ./gcov/trash
# Search in the project all gcno files and make a gcov on them
find ../../ -type f -name "*.gcno" -print0 | xargs -0 -I {} sh -c 'gcov -a -f -c -m -b "{}"'
# Search every .gcda file and replace the extension to gcov. This is for use only the files with data in the coverage
gcda_files=$(find ../../ -type f -name "*.gcda")

for filename in $gcda_files
do
     orig_name=$(echo "$filename" | sed 's!.*/!!')
     gcov_name=$(echo "$orig_name" | cut -d '.' -f 1-2)
     orig_file="./"$gcov_name".gcov"
     dest_file="../"$gcov_name".gcov"
     cp "$orig_file" "$dest_file"
done

# Erase all .gcov files in ./gcov/trash
rm -f ./*.gcov
# Going out to ./gcov
cd ..
# gcovr it!
gcovr -r ./ --xml -o ../coverage/coverage.xml
gcovr -r ./ --html --html-details -o ../coverage/coverage.html
# Exit pacefully
cd ..

echo "done gcovving"
