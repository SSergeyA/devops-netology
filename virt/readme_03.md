### Sergey Sokolov
## Задача1
https://hub.docker.com/r/ssergeya/websrv

## Задача2
- Высоконагруженное монолитное java веб-приложениe - для этого приложения лучше всего подойдет физический сервер. Т.к. технология виртуализации подразумевает отказ от монолитных приложений в пользу легких и масштабируемых взаимосвязанных сервисов. Докер, как продолжение виртуализации, нацелен на разбитие приложений на микросервисы , которые выполняют специфичные функиции и связаны с остальными микросервисами приложения по API.
- Nodejs веб-приложение - можно расположить на докере, т.к.  используется для создания быстрых и масштабируемых веб приложений 
- Мобильное приложение c версиями для Android и iOS -не совсем понял, причем тут версии приложений, они же и те и другие отправляют запросы на сервер и получают ответы и интерпиритируют их пользователю. мне кажется тут можно разместить и на виртуальной машине и в контейнере.
- Шина данных на базе Apache Kafka - насколько я понял, тут главное наличие горизонтальной масштабируемости и отказоустойчивости. Значит подойдет как докер так и виртуализация.
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - тоже, не вижу особой разницы как реализовать,можно и на виртуальных серверах, но так же  есть готовые образы для докера. 
- Мониторинг-стек на базе Prometheus и Grafana - тоже самое 
- MongoDB, как основное хранилище данных для java-приложения - мне кажется удобнее разворачивать в контейнерах, но можно и на виртуальных машинах. главное позаботиться о сохранении файловых данных.
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - GitLab вполне можно развернуть в Docker, так же как и на виртуальной машине. Про Docker Registry такой информации не нащел, да и не понятно зачем разворачивать модуль предназначенный для хранения и управления образами в контейнере, так что остается для него виртуальная машина.

## Задача3
По задаче есть маленький вопрос: я же мог подключаться вместо EXEC используя ATTACH, что бы не заводить второй процесс баш, а выполнить все в запущенном?  или это не принципиально
```
root@server1:/docker/data# docker ps
CONTAINER ID   IMAGE     COMMAND              CREATED        STATUS        PORTS                               NAMES
ef4c65294b48   websrv    "/bin/sh -c nginx"   31 hours ago   Up 31 hours   0.0.0.0:80->80/tcp, :::80->80/tcp   awesome_kirch
root@server1:/docker/data# ls
root@server1:/docker/data# docker run -it -d -v "/docker/data:/data" centos /bin/bash
e092e2244d96c512c087f629bb8b88cc5510bf3d4f970be88b23b5e2ea67abd1
root@server1:/docker/data# docker run -it -d -v "/docker/data:/data" debian /bin/bash
6dda7bdf284a6140264894152e7b2e2895a6d412a2116c75f367d9bda0cdb6c0
root@server1:/docker/data# docker ps
CONTAINER ID   IMAGE     COMMAND              CREATED              STATUS              PORTS                               NAMES
6dda7bdf284a   debian    "/bin/bash"          About a minute ago   Up About a minute                                       frosty_margulis
e092e2244d96   centos    "/bin/bash"          About a minute ago   Up About a minute                                       tender_yonath
ef4c65294b48   websrv    "/bin/sh -c nginx"   31 hours ago         Up 31 hours         0.0.0.0:80->80/tcp, :::80->80/tcp   awesome_kirch
root@server1:/docker/data# docker exec -it e092e2244d96 /bin/bash
[root@e092e2244d96 /]# echo "test 1" > /data/1.txt
[root@e092e2244d96 /]# exit
exit
root@server1:/docker/data# echo "test 2" > 2.txt
root@server1:/docker/data# ll
total 16
drwxrwxrwx 2 root root 4096 Apr 21 18:01 ./
drwxr-xr-x 4 root root 4096 Apr 21 16:53 ../
-rw-r--r-- 1 root root    7 Apr 21 18:01 1.txt
-rw-r--r-- 1 root root    7 Apr 21 18:01 2.txt
root@server1:/docker/data# docker exec -it 6dda7bdf284a /bin/bash
root@6dda7bdf284a:/# ls /data
1.txt  2.txt
root@6dda7bdf284a:/# 
```
## Задача4
https://hub.docker.com/r/ssergeya/ansible

У меня была проблема на стадии сборки образа, могли ли бы вы мне объяснить вчем точно было дело? Как я понял конфлик версий энсиб при обновлении, но из зачего я не понял. Пока я не добавил переменную в окружение сборки `ARG ANSIBLE_SKIP_CONFLICT_CHECK=1 pip install ansible-core`
, у меня выходила такая ошибка:
```
root@server1:/docker/ansible# DOCKER_BUILDKIT=0 docker build - t ssergea/ansible:2.10.0 .
"docker build" requires exactly 1 argument.
See 'docker build --help'.

Usage:  docker build [OPTIONS] PATH | URL | -

Build an image from a Dockerfile
root@server1:/docker/ansible# DOCKER_BUILDKIT=0 docker build -t ssergea/ansible:2.10.0 .
Sending build context to Docker daemon   2.56kB
Step 1/5 : FROM alpine:3.14
3.14: Pulling from library/alpine
8663204ce13b: Pull complete 
Digest: sha256:06b5d462c92fc39303e6363c65e074559f8d6b1363250027ed5053557e3398c5
Status: Downloaded newer image for alpine:3.14
 ---> e04c818066af
Step 2/5 : RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 &&     apk --no-cache add         sudo         python3        py3-pip         openssl         ca-certificates         sshpass         openssh-client         rsync         git &&     apk --no-cache add --virtual build-dependencies         python3-dev         libffi-dev         musl-dev         gcc         cargo         openssl-dev         libressl-dev         build-base &&     pip install --upgrade pip wheel &&     pip install --upgrade cryptography cffi &&     pip install ansible==2.9.24 &&     pip install mitogen ansible-lint jmespath &&     pip install --upgrade pywinrm &&     apk del build-dependencies &&     rm -rf /var/cache/apk/* &&     rm -rf /root/.cache/pip &&     rm -rf /root/.cargo
 ---> Running in 417e38194c2c
fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/APKINDEX.tar.gz
(1/55) Installing ca-certificates (20211220-r0)
(2/55) Installing brotli-libs (1.0.9-r5)
(3/55) Installing nghttp2-libs (1.43.0-r0)
(4/55) Installing libcurl (7.79.1-r0)
(5/55) Installing expat (2.4.7-r0)
(6/55) Installing pcre2 (10.36-r0)
(7/55) Installing git (2.32.1-r0)
(8/55) Installing openssh-keygen (8.6_p1-r3)
(9/55) Installing ncurses-terminfo-base (6.2_p20210612-r0)
(10/55) Installing ncurses-libs (6.2_p20210612-r0)
(11/55) Installing libedit (20210216.3.1-r0)
(12/55) Installing openssh-client-common (8.6_p1-r3)
(13/55) Installing openssh-client-default (8.6_p1-r3)
(14/55) Installing openssl (1.1.1n-r0)
(15/55) Installing libbz2 (1.0.8-r1)
(16/55) Installing libffi (3.3-r2)
(17/55) Installing gdbm (1.19-r0)
(18/55) Installing xz-libs (5.2.5-r1)
(19/55) Installing libgcc (10.3.1_git20210424-r2)
(20/55) Installing libstdc++ (10.3.1_git20210424-r2)
(21/55) Installing mpdecimal (2.5.1-r1)
(22/55) Installing readline (8.1.0-r0)
(23/55) Installing sqlite-libs (3.35.5-r0)
(24/55) Installing python3 (3.9.5-r2)
(25/55) Installing py3-appdirs (1.4.4-r2)
(26/55) Installing py3-chardet (4.0.0-r2)
(27/55) Installing py3-idna (3.2-r0)
(28/55) Installing py3-urllib3 (1.26.5-r0)
(29/55) Installing py3-certifi (2020.12.5-r1)
(30/55) Installing py3-requests (2.25.1-r4)
(31/55) Installing py3-msgpack (1.0.2-r1)
(32/55) Installing py3-lockfile (0.12.2-r4)
(33/55) Installing py3-cachecontrol (0.12.6-r1)
(34/55) Installing py3-colorama (0.4.4-r1)
(35/55) Installing py3-contextlib2 (0.6.0-r1)
(36/55) Installing py3-distlib (0.3.1-r3)
(37/55) Installing py3-distro (1.5.0-r3)
(38/55) Installing py3-six (1.15.0-r1)
(39/55) Installing py3-webencodings (0.5.1-r4)
(40/55) Installing py3-html5lib (1.1-r1)
(41/55) Installing py3-parsing (2.4.7-r2)
(42/55) Installing py3-packaging (20.9-r1)
(43/55) Installing py3-toml (0.10.2-r2)
(44/55) Installing py3-pep517 (0.10.0-r2)
(45/55) Installing py3-progress (1.5-r2)
(46/55) Installing py3-retrying (1.3.3-r1)
(47/55) Installing py3-ordered-set (4.0.2-r1)
(48/55) Installing py3-setuptools (52.0.0-r3)
(49/55) Installing py3-pip (20.3.4-r1)
(50/55) Installing libacl (2.2.53-r0)
(51/55) Installing popt (1.18-r0)
(52/55) Installing zstd-libs (1.4.9-r1)
(53/55) Installing rsync (3.2.3-r4)
(54/55) Installing sshpass (1.09-r0)
(55/55) Installing sudo (1.9.7_p1-r1)
Executing busybox-1.33.1-r7.trigger
Executing ca-certificates-20211220-r0.trigger
OK: 98 MiB in 69 packages
fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/APKINDEX.tar.gz
(1/37) Installing pkgconf (1.7.4-r0)
(2/37) Installing python3-dev (3.9.5-r2)
(3/37) Installing linux-headers (5.10.41-r0)
(4/37) Installing libffi-dev (3.3-r2)
(5/37) Installing musl-dev (1.2.2-r3)
(6/37) Installing binutils (2.35.2-r2)
(7/37) Installing libgomp (10.3.1_git20210424-r2)
(8/37) Installing libatomic (10.3.1_git20210424-r2)
(9/37) Installing libgphobos (10.3.1_git20210424-r2)
(10/37) Installing gmp (6.2.1-r1)
(11/37) Installing isl22 (0.22-r0)
(12/37) Installing mpfr4 (4.1.0-r0)
(13/37) Installing mpc1 (1.2.1-r0)
(14/37) Installing gcc (10.3.1_git20210424-r2)
(15/37) Installing rust-stdlib (1.52.1-r1)
(16/37) Installing libxml2 (2.9.13-r0)
(17/37) Installing llvm11-libs (11.1.0-r2)
(18/37) Installing http-parser (2.9.4-r0)
(19/37) Installing pcre (8.44-r0)
(20/37) Installing libssh2 (1.9.0-r1)
(21/37) Installing libgit2 (1.1.0-r2)
(22/37) Installing rust (1.52.1-r1)
(23/37) Installing cargo (1.52.1-r1)
(24/37) Installing openssl-dev (1.1.1n-r0)
(25/37) Installing libressl3.3-libcrypto (3.3.6-r0)
(26/37) Installing libressl3.3-libssl (3.3.6-r0)
(27/37) Installing libressl3.3-libtls (3.3.6-r0)
(28/37) Installing libressl-dev (3.3.6-r0)
(29/37) Installing libmagic (5.40-r1)
(30/37) Installing file (5.40-r1)
(31/37) Installing libc-dev (0.7.2-r3)
(32/37) Installing g++ (10.3.1_git20210424-r2)
(33/37) Installing make (4.3-r0)
(34/37) Installing fortify-headers (1.1-r1)
(35/37) Installing patch (2.7.6-r7)
(36/37) Installing build-base (0.5-r2)
(37/37) Installing build-dependencies (20220422.062242)
Executing busybox-1.33.1-r7.trigger
OK: 1110 MiB in 106 packages
Requirement already satisfied: pip in /usr/lib/python3.9/site-packages (20.3.4)
Collecting pip
  Downloading pip-22.0.4-py3-none-any.whl (2.1 MB)
Collecting wheel
  Downloading wheel-0.37.1-py2.py3-none-any.whl (35 kB)
Installing collected packages: wheel, pip
  Attempting uninstall: pip
    Found existing installation: pip 20.3.4
    Uninstalling pip-20.3.4:
      Successfully uninstalled pip-20.3.4
Successfully installed pip-22.0.4 wheel-0.37.1
Collecting cryptography
  Downloading cryptography-36.0.2-cp36-abi3-musllinux_1_1_x86_64.whl (3.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.8/3.8 MB 1.5 MB/s eta 0:00:00
Collecting cffi
  Downloading cffi-1.15.0.tar.gz (484 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 484.1/484.1 KB 1.5 MB/s eta 0:00:00
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting pycparser
  Downloading pycparser-2.21-py2.py3-none-any.whl (118 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 118.7/118.7 KB 1.5 MB/s eta 0:00:00
Building wheels for collected packages: cffi
  Building wheel for cffi (setup.py): started
  Building wheel for cffi (setup.py): finished with status 'done'
  Created wheel for cffi: filename=cffi-1.15.0-cp39-cp39-linux_x86_64.whl size=429212 sha256=56382cea2204998a0e6f0422c62797eeecaffa51d23627b94a2ad67df7ba0b4b
  Stored in directory: /root/.cache/pip/wheels/8e/0d/16/77c97b85a9f559c5412c85c129a2bae07c771d31e1beb03c40
Successfully built cffi
Installing collected packages: pycparser, cffi, cryptography
Successfully installed cffi-1.15.0 cryptography-36.0.2 pycparser-2.21
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
Collecting ansible==2.9.24
  Downloading ansible-2.9.24.tar.gz (14.3 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 14.3/14.3 MB 1.6 MB/s eta 0:00:00
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting jinja2
  Downloading Jinja2-3.1.1-py3-none-any.whl (132 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 132.6/132.6 KB 1.8 MB/s eta 0:00:00
Collecting PyYAML
  Downloading PyYAML-6.0.tar.gz (124 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 125.0/125.0 KB 1.6 MB/s eta 0:00:00
  Installing build dependencies: started
  Installing build dependencies: finished with status 'done'
  Getting requirements to build wheel: started
  Getting requirements to build wheel: finished with status 'done'
  Preparing metadata (pyproject.toml): started
  Preparing metadata (pyproject.toml): finished with status 'done'
Requirement already satisfied: cryptography in /usr/lib/python3.9/site-packages (from ansible==2.9.24) (36.0.2)
Requirement already satisfied: cffi>=1.12 in /usr/lib/python3.9/site-packages (from cryptography->ansible==2.9.24) (1.15.0)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.1.1-cp39-cp39-musllinux_1_1_x86_64.whl (29 kB)
Requirement already satisfied: pycparser in /usr/lib/python3.9/site-packages (from cffi>=1.12->cryptography->ansible==2.9.24) (2.21)
Building wheels for collected packages: ansible, PyYAML
  Building wheel for ansible (setup.py): started
  Building wheel for ansible (setup.py): finished with status 'done'
  Created wheel for ansible: filename=ansible-2.9.24-py3-none-any.whl size=16205052 sha256=de5801ea80f5035a527fc447e02f612166feb176baf7f185173c2a05d32784c4
  Stored in directory: /root/.cache/pip/wheels/ba/89/f3/df35238037ec8303702ddd8569ce11a807935f96ecb3ff6d52
  Building wheel for PyYAML (pyproject.toml): started
  Building wheel for PyYAML (pyproject.toml): finished with status 'done'
  Created wheel for PyYAML: filename=PyYAML-6.0-cp39-cp39-linux_x86_64.whl size=45332 sha256=bcaa5b63e88424f7457b30b058bb376973b945fd0255b54975481b4fe50311a9
  Stored in directory: /root/.cache/pip/wheels/b4/0f/9a/d6af48581dda678920fccfb734f5d9f827c6ed5b4074c7eda8
Successfully built ansible PyYAML
Installing collected packages: PyYAML, MarkupSafe, jinja2, ansible
Successfully installed MarkupSafe-2.1.1 PyYAML-6.0 ansible-2.9.24 jinja2-3.1.1
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
Collecting mitogen
  Downloading mitogen-0.3.2-py2.py3-none-any.whl (288 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 289.0/289.0 KB 1.3 MB/s eta 0:00:00
Collecting ansible-lint
  Downloading ansible_lint-6.0.2-py3-none-any.whl (140 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 140.4/140.4 KB 1.7 MB/s eta 0:00:00
Collecting jmespath
  Downloading jmespath-1.0.0-py3-none-any.whl (23 kB)
Collecting ansible-compat>=2.0.2
  Downloading ansible_compat-2.0.2-py3-none-any.whl (16 kB)
Requirement already satisfied: pyyaml in /usr/lib/python3.9/site-packages (from ansible-lint) (6.0)
Requirement already satisfied: packaging in /usr/lib/python3.9/site-packages (from ansible-lint) (20.9)
Collecting yamllint>=1.25.0
  Downloading yamllint-1.26.3.tar.gz (126 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 126.7/126.7 KB 1.5 MB/s eta 0:00:00
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting rich>=9.5.1
  Downloading rich-12.2.0-py3-none-any.whl (229 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.8/229.8 KB 1.6 MB/s eta 0:00:00
Collecting ruamel.yaml<0.18,>=0.15.34
  Downloading ruamel.yaml-0.17.21-py3-none-any.whl (109 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 109.5/109.5 KB 1.6 MB/s eta 0:00:00
Collecting wcmatch>=7.0
  Downloading wcmatch-8.3-py3-none-any.whl (42 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 42.9/42.9 KB 1.5 MB/s eta 0:00:00
Collecting enrich>=1.2.6
  Downloading enrich-1.2.7-py3-none-any.whl (8.7 kB)
Collecting ansible-core>=2.12.0
  Downloading ansible-core-2.12.4.tar.gz (7.8 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.8/7.8 MB 1.6 MB/s eta 0:00:00
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting subprocess-tee>=0.3.5
  Downloading subprocess_tee-0.3.5-py3-none-any.whl (8.0 kB)
Requirement already satisfied: jinja2 in /usr/lib/python3.9/site-packages (from ansible-core>=2.12.0->ansible-lint) (3.1.1)
Requirement already satisfied: cryptography in /usr/lib/python3.9/site-packages (from ansible-core>=2.12.0->ansible-lint) (36.0.2)
Collecting resolvelib<0.6.0,>=0.5.3
  Downloading resolvelib-0.5.4-py2.py3-none-any.whl (12 kB)
Collecting pygments<3.0.0,>=2.6.0
  Downloading Pygments-2.11.2-py3-none-any.whl (1.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.1/1.1 MB 1.5 MB/s eta 0:00:00
Collecting commonmark<0.10.0,>=0.9.0
  Downloading commonmark-0.9.1-py2.py3-none-any.whl (51 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 51.1/51.1 KB 1.6 MB/s eta 0:00:00
Collecting ruamel.yaml.clib>=0.2.6
  Downloading ruamel.yaml.clib-0.2.6.tar.gz (180 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 180.7/180.7 KB 1.1 MB/s eta 0:00:00
  Preparing metadata (setup.py): started
  Preparing metadata (setup.py): finished with status 'done'
Collecting bracex>=2.1.1
  Downloading bracex-2.2.1-py3-none-any.whl (12 kB)
Collecting pathspec>=0.5.3
  Downloading pathspec-0.9.0-py2.py3-none-any.whl (31 kB)
Requirement already satisfied: setuptools in /usr/lib/python3.9/site-packages (from yamllint>=1.25.0->ansible-lint) (52.0.0)
Requirement already satisfied: cffi>=1.12 in /usr/lib/python3.9/site-packages (from cryptography->ansible-core>=2.12.0->ansible-lint) (1.15.0)
Requirement already satisfied: MarkupSafe>=2.0 in /usr/lib/python3.9/site-packages (from jinja2->ansible-core>=2.12.0->ansible-lint) (2.1.1)
Requirement already satisfied: pycparser in /usr/lib/python3.9/site-packages (from cffi>=1.12->cryptography->ansible-core>=2.12.0->ansible-lint) (2.21)
Building wheels for collected packages: ansible-core, yamllint, ruamel.yaml.clib
  Building wheel for ansible-core (setup.py): started
  Building wheel for ansible-core (setup.py): finished with status 'error'
  error: subprocess-exited-with-error
  
  × python setup.py bdist_wheel did not run successfully.
  │ exit code: 1
  ╰─> [28 lines of output]
      Traceback (most recent call last):
        File "<string>", line 2, in <module>
        File "<pip-setuptools-caller>", line 34, in <module>
        File "/tmp/pip-install-rf8vqpbw/ansible-core_ca3aa84f795c4016a350a803d85d83d6/setup.py", line 120, in <module>
          _validate_install_ansible_core()
        File "/tmp/pip-install-rf8vqpbw/ansible-core_ca3aa84f795c4016a350a803d85d83d6/setup.py", line 91, in _validate_install_ansible_core
          raise RuntimeError(
      RuntimeError:
      
          ****************************************************************************
      
          Cannot install ansible-core with a pre-existing ansible==2.9.24
          installation.
      
          Installing ansible-core with ansible-2.9 or older, or ansible-base-2.10
          currently installed with pip is known to cause problems. Please uninstall
          ansible and install the new version:
      
              pip uninstall ansible
              pip install ansible-core
      
          If you want to skip the conflict checks and manually resolve any issues
          afterwards, set the ANSIBLE_SKIP_CONFLICT_CHECK environment variable:
      
              ANSIBLE_SKIP_CONFLICT_CHECK=1 pip install ansible-core
      
          ****************************************************************************
      
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed building wheel for ansible-core
  Running setup.py clean for ansible-core
  error: subprocess-exited-with-error
  
  × python setup.py clean did not run successfully.
  │ exit code: 1
  ╰─> [28 lines of output]
      Traceback (most recent call last):
        File "<string>", line 2, in <module>
        File "<pip-setuptools-caller>", line 34, in <module>
        File "/tmp/pip-install-rf8vqpbw/ansible-core_ca3aa84f795c4016a350a803d85d83d6/setup.py", line 120, in <module>
          _validate_install_ansible_core()
        File "/tmp/pip-install-rf8vqpbw/ansible-core_ca3aa84f795c4016a350a803d85d83d6/setup.py", line 91, in _validate_install_ansible_core
          raise RuntimeError(
      RuntimeError:
      
          ****************************************************************************
      
          Cannot install ansible-core with a pre-existing ansible==2.9.24
          installation.
      
          Installing ansible-core with ansible-2.9 or older, or ansible-base-2.10
          currently installed with pip is known to cause problems. Please uninstall
          ansible and install the new version:
      
              pip uninstall ansible
              pip install ansible-core
      
          If you want to skip the conflict checks and manually resolve any issues
          afterwards, set the ANSIBLE_SKIP_CONFLICT_CHECK environment variable:
      
              ANSIBLE_SKIP_CONFLICT_CHECK=1 pip install ansible-core
      
          ****************************************************************************
      
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed cleaning build dir for ansible-core
  Building wheel for yamllint (setup.py): started
  Building wheel for yamllint (setup.py): finished with status 'done'
  Created wheel for yamllint: filename=yamllint-1.26.3-py2.py3-none-any.whl size=60804 sha256=92c4efd1ee425c4ca32cba5992a26d84aa4a1439ae94d5814e33e03326f74587
  Stored in directory: /root/.cache/pip/wheels/ad/e7/53/f6ab69bd61ed0a887ee815302635448de42a0bc04035d5c1e9
  Building wheel for ruamel.yaml.clib (setup.py): started
  Building wheel for ruamel.yaml.clib (setup.py): finished with status 'done'
  Created wheel for ruamel.yaml.clib: filename=ruamel.yaml.clib-0.2.6-cp39-cp39-linux_x86_64.whl size=746361 sha256=4f1a84a0a3138ad7b2c2f4279fe91d7d8d4e2cd3766d0bcbcd9f54158c0e0cb7
  Stored in directory: /root/.cache/pip/wheels/b1/c4/5d/d96e5c09189f4d6d2a9ffb0d7af04ee06d11a20f613f5f3496
Successfully built yamllint ruamel.yaml.clib
Failed to build ansible-core
Installing collected packages: resolvelib, commonmark, subprocess-tee, ruamel.yaml.clib, pygments, pathspec, mitogen, jmespath, bracex, yamllint, wcmatch, ruamel.yaml, rich, ansible-compat, enrich, ansible-core, ansible-lint
  Running setup.py install for ansible-core: started
  Running setup.py install for ansible-core: finished with status 'error'
  error: subprocess-exited-with-error
  
  × Running setup.py install for ansible-core did not run successfully.
  │ exit code: 1
  ╰─> [28 lines of output]
      Traceback (most recent call last):
        File "<string>", line 2, in <module>
        File "<pip-setuptools-caller>", line 34, in <module>
        File "/tmp/pip-install-rf8vqpbw/ansible-core_ca3aa84f795c4016a350a803d85d83d6/setup.py", line 120, in <module>
          _validate_install_ansible_core()
        File "/tmp/pip-install-rf8vqpbw/ansible-core_ca3aa84f795c4016a350a803d85d83d6/setup.py", line 91, in _validate_install_ansible_core
          raise RuntimeError(
      RuntimeError:
      
          ****************************************************************************
      
          Cannot install ansible-core with a pre-existing ansible==2.9.24
          installation.
      
          Installing ansible-core with ansible-2.9 or older, or ansible-base-2.10
          currently installed with pip is known to cause problems. Please uninstall
          ansible and install the new version:
      
              pip uninstall ansible
              pip install ansible-core
      
          If you want to skip the conflict checks and manually resolve any issues
          afterwards, set the ANSIBLE_SKIP_CONFLICT_CHECK environment variable:
      
              ANSIBLE_SKIP_CONFLICT_CHECK=1 pip install ansible-core
      
          ****************************************************************************
      
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
error: legacy-install-failure

× Encountered error while trying to install package.
╰─> ansible-core

note: This is an issue with the package mentioned above, not pip.
hint: See above for output from the failure.
The command '/bin/sh -c CARGO_NET_GIT_FETCH_WITH_CLI=1 &&     apk --no-cache add         sudo         python3        py3-pip         openssl         ca-certificates         sshpass         openssh-client         rsync         git &&     apk --no-cache add --virtual build-dependencies         python3-dev         libffi-dev         musl-dev         gcc         cargo         openssl-dev         libressl-dev         build-base &&     pip install --upgrade pip wheel &&     pip install --upgrade cryptography cffi &&     pip install ansible==2.9.24 &&     pip install mitogen ansible-lint jmespath &&     pip install --upgrade pywinrm &&     apk del build-dependencies &&     rm -rf /var/cache/apk/* &&     rm -rf /root/.cache/pip &&     rm -rf /root/.cargo' returned a non-zero code: 1
root@server1:/docker/ansible#
```
