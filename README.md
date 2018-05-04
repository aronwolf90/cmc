Requirements:
 - docker (e.g. sudo apt-get install docker.io)
 - docker-compose (e.g. sudo apt-get install docker-compose)
 - bash (present in all UNIX operating systems, like ubuntu or mac)

the first time you have to execute the following command:
  - scripts/build.sh

To run project you have to follow this steps:
  - Execute: scripts/docker-compose up
  - In the browser go to: http://localhost:3000/administration

When you make changes on Gemfile, Gemfile.lock, yarn.lock or package.json, execute the following command:
  - scipts/build.sh

When the build command (scripts/build.sh) become to slow, execute this:
  - build_prebuild

When the automatic test become to slow, it can help that an administrator (e.g. Aron Wolf) execute:
  - scripts/build_and_push_cmc_prebuild.sh
