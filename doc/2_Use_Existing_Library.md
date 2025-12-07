# 既存ライブラリをリンクして使う

## 何を理解するべきか？

- Linuxでのライブラリファイルの場所
- gcc でライブラリを指定する方法
- 一般的な例でライブラリをリンク
- pkg-config の存在


## 詳細

### Linuxでのライブラリファイルの場所

- 例：`/usr/lib`, `/usr/local/lib`, `/lib`
- ヘッダは`/usr/include`付近にあることが多い。

一度自分のPCで探してみよう。


### gcc でライブラリを指定する方法

- `-lxxx`（`libxxx.so` / `libxxx.a` を探す）
- `-L/path/to/lib`（ライブラリの検索パス追加）
- `-I/path/to/include`（ヘッダの検索パス追加）

参考例として、[Makefile](../examples/Makefile)に記述があります。
ただし、`-lxxx`について静的ライブラリと共有ライブラリの優先度について知っておく必要があります。  
一般的な利用方法であれば、リンカーはデフォルトで指定されたパスや
`-L/path/to/lib`で指定されたパスからライブラリを捜索します。  
このとき、  
1. `libxxx.so`  
2. `libxxx.a`  
の順番で捜索されます。  
もし、静的ライブラリと共有ライブラリの両方が配布されている場合は、共有ライブラリがリンクされることになります。  
ユーザが静的ライブラリをリンクしたい場合は、`-lxxx`ではなく、直接ライブラリのパスを指定する必要があります。  


### 一般的な例：mathライブラリ (libm) をリンク

```make
# main.c で #include <math.h> を使っているとして
gcc main.c -lm -o main
```


### pkg-config の存在

ライブラリの「必要な -I や -L など」を教えてくれるツール。
```sh
pkg-config --cflags --libs gtk4
```

ライブラリを使うときは通常、  
- インクルードパス(`-I/usr/include/xxx`)
- ライブラリパス(`-L/usr/lib/xxx`)
- リンクするライブラリ名(`-lxxx`)
- 依存する他のライブラリ名(`-lxxx2`)
などの情報が必要。  
これらを毎回、`gcc`などに渡すのは面倒なので、`pkg-config`でオプション提供をしてもらう。  

インストールされている前提で続けます。  
基本的なコマンドは以下の通り。

```sh
# 利用可能なパッケージ一覧
$ pkg-config --list-all

# コンパイルオプションの指定
$ pkg-config --cflags glib-2.0
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/sysprof-6 -pthread

# ライブラリオプションの指定
$ pkg-config --libs glib-2.0
-lglib-2.0

# pkg-configを使ったglib-2.0のリンク
$ gcc main.c $(pkg-config --cflags --libs glib-2.0) -o main
```

これらは環境によって出力されるオプションが変わる。  
しかし、`pkg-config`を通して出力しているのでプロジェクトの設定は変わらない。  

`pkg-config`がライブラリごとのオプションを出力できる理由は`.pc`ファイルが用意されているから。  
`.pc`ファイルとは、パッケージコンフィグファイルのことです。  
例: `/usr/lib/pkgconfig/glib-2.0.pc`  

```txt
prefix=/usr
bindir=${prefix}/bin
datadir=${prefix}/share
includedir=${prefix}/include
libdir=${prefix}/lib

glib_genmarshal=${bindir}/glib-genmarshal
gobject_query=${bindir}/gobject-query
glib_mkenums=${bindir}/glib-mkenums
glib_valgrind_suppressions=${datadir}/glib-2.0/valgrind/glib.supp

Name: GLib
Description: C Utility Library
Version: 2.84.4
Requires.private: sysprof-capture-4 >=  3.38.0, libpcre2-8 >= 10.32
Libs: -L${libdir} -lglib-2.0
Libs.private: -lm -pthread
Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include
```

`pkg-config`はこの`.pc`ファイルを読み込んで`--cflags`や`--libs`の情報を出力しています。  

一般的には、
- `/usr/lib/pkgconfig`
- `/usr/local/lib/pkgconfig`
- `/usr/share/pkgconfig`
に置かれる。特に手動インストールした場合は`/usr/local/...`に置かれます。  
環境変数で検索パスを追加することも可能。  
この場合は、
```sh
export PKG_CONFIG_PATH=/path/to/your/lib/pkgconfig:$PKG_CONFIG_PATH
```
を追加する。




