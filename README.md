# DockerTools

- exliblist.sh
バイナリ実行ファイルにダイナミックリンクされている共有ライブラリとリンクをリスト化してファイルに書き出します。

- exlibconf.sh
ライブラリが収容されているディレクトリに関わるコンフィグファイルをリスト化してファイルに書き出します。

- lcopy.sh
リストにフルパスで記載したファイル名の単体ファイルを[指定ディレクトリ下+フルパス名]でコピーする。

- extractlibrary
実行ファイルと必要な共有ライブラリを指定ディレクトリ以下にディレクトリ階層はそのままコピーする。 exliblist.shとlcopy.shを足したもの

## exliblist.shの使い方

実行には'bash'が必要なのでalpine linux等'bash'が当初ない物には
apk add bash で追加して使用する。alpine linuxのashでは動かない部分がある。

実行ファイル名をフルパスで記載したバイナリ実行ファイルリストを用意します。

```shell
$vi binlist

/bin/sh
/bin/ls
/usr/bin/cat
/usr/bin/echo
```

 ./exliblist.sh [バイナリ実行ファイルリスト] [書き出すファイル名]

```shell
$./exliblist.sh binlist copylist

$cat copylist

/lib/x86_64-linux-gnu/libc.so.6
/usr/lib/x86_64-linux-gnu/libc-2.28.so
/lib64/ld-linux-x86-64.so.2
/usr/lib/x86_64-linux-gnu/ld-2.28.so
...
/lib/x86_64-linux-gnu/libacl.so.1
/usr/lib/x86_64-linux-gnu/libacl.so.1.1.2253
/lib/x86_64-linux-gnu/libattr.so.1
/usr/lib/x86_64-linux-gnu/libattr.so.1.1.2448
```

&nbsp;

---

## lcopyの使い方

コピーリストに記載されたパスのファイルを指定ディレクトリ配下に複数コピーする

./lcopy.sh [コピーリスト] [宛先ディレクトリ]

```shell
./lcopy.sh copylist ./copydir
```

&nbsp;

---

## exlibconf.shの使い方

 ./exlibconf.sh [書き出すファイル名]

```shell
$./exlibconf.sh libconfiglist

/etc/ld.so.conf
/etc/ld.so.conf.d/libc.conf
/etc/ld.so.conf.d/x86_64-linux-gnu.conf
```

## extractlibraryの使い方

実行には'bash'が必要なのでalpine linux等'bash'が当初ない物には
apk add bash で追加して使用する。alpine linuxのashでは動かない部分がある。

実行ファイル名をフルパスで記載したバイナリ実行ファイルリストを用意します。

```shell
$vi binlist

/bin/sh
/bin/ls
/usr/bin/cat
```

./extractlibrary [実行バイナリファイルのフルパスをリスト化したファイル名] [指定ディレクトリ]

```shell
$./extractlibrary binlist copydir

==============     /bin/sh     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libc.so.6
add path list  : /lib/x86_64-linux-gnu/libc.so.6
found liink    : /usr/lib/x86_64-linux-gnu/libc-2.28.so
add link source: /usr/lib/x86_64-linux-gnu/libc-2.28.so
==============     /lib/x86_64-linux-gnu/libc.so.6     ==============
found library  : /lib64/ld-linux-x86-64.so.2
add path list  : /lib64/ld-linux-x86-64.so.2
found liink    : /usr/lib/x86_64-linux-gnu/ld-2.28.so
add link source: /usr/lib/x86_64-linux-gnu/ld-2.28.so
==============     /lib64/ld-linux-x86-64.so.2     ==============
dont add path  : statically
dont add path  : linux-vdso.so.1
found library  : /lib64/ld-linux-x86-64.so.2
==============     /bin/ls     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libselinux.so.1
add path list  : /lib/x86_64-linux-gnu/libselinux.so.1
found liink    : /usr/lib/x86_64-linux-gnu/libselinux.so.1
add link source: /usr/lib/x86_64-linux-gnu/libselinux.so.1
==============     /lib/x86_64-linux-gnu/libselinux.so.1     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libpcre.so.3
add path list  : /lib/x86_64-linux-gnu/libpcre.so.3
found liink    : /usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3
add link source: /usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3
==============     /lib/x86_64-linux-gnu/libpcre.so.3     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libpthread.so.0
add path list  : /lib/x86_64-linux-gnu/libpthread.so.0
found liink    : /usr/lib/x86_64-linux-gnu/libpthread-2.28.so
add link source: /usr/lib/x86_64-linux-gnu/libpthread-2.28.so
==============     /lib/x86_64-linux-gnu/libpthread.so.0     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libc.so.6
found library  : /lib64/ld-linux-x86-64.so.2
found library  : /lib/x86_64-linux-gnu/libc.so.6
found library  : /lib64/ld-linux-x86-64.so.2
found library  : /lib/x86_64-linux-gnu/libdl.so.2
add path list  : /lib/x86_64-linux-gnu/libdl.so.2
found liink    : /usr/lib/x86_64-linux-gnu/libdl-2.28.so
add link source: /usr/lib/x86_64-linux-gnu/libdl-2.28.so
==============     /lib/x86_64-linux-gnu/libdl.so.2     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libc.so.6
found library  : /lib64/ld-linux-x86-64.so.2
found library  : /lib/x86_64-linux-gnu/libc.so.6
found library  : /lib64/ld-linux-x86-64.so.2
found library  : /lib/x86_64-linux-gnu/libpthread.so.0
found library  : /lib/x86_64-linux-gnu/libc.so.6
found library  : /lib/x86_64-linux-gnu/libpcre.so.3
found library  : /lib/x86_64-linux-gnu/libdl.so.2
found library  : /lib64/ld-linux-x86-64.so.2
found library  : /lib/x86_64-linux-gnu/libpthread.so.0
==============     /usr/bin/cat     ==============
dont add path  : linux-vdso.so.1
found library  : /lib/x86_64-linux-gnu/libc.so.6
found library  : /lib64/ld-linux-x86-64.so.2

=-=-=-=  Copy File List  =-=-=-=
copy - /bin/sh  >  copydir/bin/sh 
copy - /bin/ls  >  copydir/bin/ls 
copy - /usr/bin/cat  >  copydir/usr/bin/cat 
copy - /lib/x86_64-linux-gnu/libc.so.6  >  copydir/lib/x86_64-linux-gnu/libc.so.6 
copy - /usr/lib/x86_64-linux-gnu/libc-2.28.so  >  copydir/usr/lib/x86_64-linux-gnu/libc-2.28.so 
copy - /lib64/ld-linux-x86-64.so.2  >  copydir/lib64/ld-linux-x86-64.so.2 
copy - /usr/lib/x86_64-linux-gnu/ld-2.28.so  >  copydir/usr/lib/x86_64-linux-gnu/ld-2.28.so 
copy - /lib/x86_64-linux-gnu/libselinux.so.1  >  copydir/lib/x86_64-linux-gnu/libselinux.so.1 
copy - /usr/lib/x86_64-linux-gnu/libselinux.so.1  >  copydir/usr/lib/x86_64-linux-gnu/libselinux.so.1 
copy - /lib/x86_64-linux-gnu/libpcre.so.3  >  copydir/lib/x86_64-linux-gnu/libpcre.so.3 
copy - /usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3  >  copydir/usr/lib/x86_64-linux-gnu/libpcre.so.3.13.3 
copy - /lib/x86_64-linux-gnu/libpthread.so.0  >  copydir/lib/x86_64-linux-gnu/libpthread.so.0 
copy - /usr/lib/x86_64-linux-gnu/libpthread-2.28.so  >  copydir/usr/lib/x86_64-linux-gnu/libpthread-2.28.so 
copy - /lib/x86_64-linux-gnu/libdl.so.2  >  copydir/lib/x86_64-linux-gnu/libdl.so.2 
copy - /usr/lib/x86_64-linux-gnu/libdl-2.28.so  >  copydir/usr/lib/x86_64-linux-gnu/libdl-2.28.so 
```

以上で実行ファイルと実行に必要な共有ライブラリがcopydirディレクトリ以下に配置される
