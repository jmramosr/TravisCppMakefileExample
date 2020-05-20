# Travis Cpp Makefile Example
Example to make CI with travis with C++98 example code and gtest to test it, sonarcloud to track smells and codecov to check the code covered by tests. I'm not responsible of the code granted by the example.

[![codecov](https://codecov.io/gh/jmramosr/TravisCppMakefileExample/branch/master/graph/badge.svg)](https://codecov.io/gh/jmramosr/TravisCppMakefileExample) [![Coverage](https://sonarcloud.io/api/project_badges/measure?project=jmramosr_TravisCppMakefileExample&metric=coverage)](https://sonarcloud.io/dashboard?id=jmramosr_TravisCppMakefileExample) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=jmramosr_TravisCppMakefileExample&metric=alert_status)](https://sonarcloud.io/dashboard?id=jmramosr_TravisCppMakefileExample) [![Build Status](https://travis-ci.com/jmramosr/TravisCppCmakeExample.svg?branch=master)](https://travis-ci.com/github/jmramosr/TravisCppCmakeExample)

## How to use this example in your project.

🔘 You will need a **computer** with **a web browser** installed and **a Github account**. You can use another code hosting, but I'm not responsible of the bad results or local baldness originated by a misuse of your code hosting site.

🔘 When you have a Github account, go to https://travis-ci.com/ and login using your Github account. Skip this step if you have logged in previously or have an account on their site.

🔘 When you have a Github account, go to https://sonarcloud.io/ and login using your Github account. If you pay them, you can use it for private repositories, too. Skip this step if you have logged in previously or have an account on their site.

🔘 When you have a Github account, go to https://codecov.io/ and login using your Github account. Skip this step if you have logged in previously or have an account on their site.

🔘 Fork this repo. Now you will have a fully functional repo for your C++ projects using google tests and a makefile, with code coverage made by codecov and sonarcloud, but you have to activate that functionality first.

🔘 Link your fork in Travis. Google the process if you don't know how to do it.

🔘 Adjust the secret tokens provided by sonarcloud and codecov. Codecov uses the CODECOV_TOKEN on Travis-CI, and sonarcloud, SONAR_TOKEN on Travis-CI, too. Very straightfordward.

🔘 Edit the cpp files in `src`, `include` and `test` and commit the changes. Check if Travis starts a build. If Travis is working, the setup of your web-CI environment is complete!

### Now, the hard part.

🔘 Modify the `Makefile` file to fit to your needs and add the files you may use in your component/module/package. The extensions provided can make your life easier.

🔘 You can add google test or google mock or both, as well as another libraries as git submodules and compile them separately. I prefer the creation of modules separately instead of One-Pile-Of-IDK.

## Warnings

⬜️ Ensure the extension of the intermediate files (usually .o) to fit the flavour you want.

⬜️ Tested on cygwin under windows 10. Hot-checked in Travis-CI.
