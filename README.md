# TravisCppCmakeExample
Example to make CI with travis with C++98 example code and gtest to test it, sonarcloud to track smells and codecov to check the code covered by tests. I'm not responsible of the code granted by the example.

[![codecov](https://codecov.io/gh/jmramosr/TravisCppCmakeExample/branch/master/graph/badge.svg)](https://codecov.io/gh/jmramosr/TravisCppCmakeExample) [![Coverage](https://sonarcloud.io/api/project_badges/measure?project=jmramosr_TravisCppCmakeExample&metric=coverage)](https://sonarcloud.io/dashboard?id=jmramosr_TravisCppCmakeExample) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=jmramosr_TravisCppCmakeExample&metric=alert_status)](https://sonarcloud.io/dashboard?id=jmramosr_TravisCppCmakeExample) [![Quality Gate Status](https://travis-ci.com/jmramosr/TravisCppCmakeExample.svg?branch=master&status=created)](https://travis-ci.com/github/jmramosr/TravisCppCmakeExample)

## How to use this example in your project.

🔘 You will need a **computer** with **a web browser** installed and **a Github account**. You can use another code hosting, but I'm not responsible of the bad results or local baldness originated by a misuse of your code hosting site.

🔘 When you have a Github account, go to https://travis-ci.com/ and login using your Github account. Skip this step if you have logged in previously or have an account on their site.

🔘 When you have a Github account, go to https://sonarcloud.io/ and login using your Github account. If you pay them, you can use it for private repositories, too. Skip this step if you have logged in previously or have an account on their site.

🔘 When you have a Github account, go to https://codecov.io/ and login using your Github account. Skip this step if you have logged in previously or have an account on their site.

🔘 Fork this repo. Now you will have a fully functional repo for your C++ projects using google tests and cmake, with code coverage made by codecov and sonarcloud, but you have to activate that functionality first.

🔘 Link your fork in Travis. Google the process if you don't know how to do it.

🔘 Adjust the secret tokens provided by sonarcloud and codecov. Codecov uses the CODECOV_TOKEN on Travis-CI, and sonarcloud, SONAR_TOKEN on Travis-CI, too. Very straightfordward.

🔘 Edit the cpp files in src, include and test and commit the changes. Check if Travis starts a build. If Travis is working, the setup of your web-CI environment is complete!

### Now, the hard part.

🔘 Modify CMakeLists.txt to adjust to your project needs. I only needed google test, but if you need google mock try it yourself!

🔘 _project1_ in the line 4 of CMakeLists.txt can be changed by the name you want. Remember to change it completely in the entire CMakeLists.txt. The same process will go with _project1_lib_, _runUnitTests_, _generate_coverage_, _generate_gcovr_. Change them with the names you want.

🔘 SRC_FILES and TEST_SRC_FILES in lines 21 and 22 of CMakeLists.txt are related with the real files will be tested and check the coverage. If you know how to modify it, you can tune it to your needs. COMMON_INCLUDES in line 19 is related with the local inclusion of your module.

🔘 If you want to use it offline, you can download the repo (or checkout the repo and the submodules-remember: _git submodule update --init --recursive_-) and you will need Cmake, make, gcov, lcov, gcovr, and a C++11 compiler (clang or gcc preferred) in order to make it work.

## Warnings

⬜️ As long as google test will need C++11, all the entire project will be compiled with C++11. If you need something related with C++98 or C, you can create the library (as described in line 40 of the CMakeLists.txt file) with the standard you need, or don't touch anything and use as is.

⬜️ Tested on cygwin under windows 10.
