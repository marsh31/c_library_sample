# 自作共有ライブラリ（.so）を作る

## 何を理解するか

- `.so` を作るには「位置独立コード（PIC）」でコンパイルする必要がある。（`-fPIC`）

- `gcc` の典型的なコマンド：  
  ```sh
  gcc -fPIC -c foo.c bar.c
  gcc -shared -Wl,-soname,libmylib.so.1 -o libmylib.so.1.0.0 foo.o bar.o
  ```


- SONAME と実ファイル名
  - 実ファイル：`libmylib.so.1.0.0`
  - SONAME ：`libmylib.so.1`
  - シンボリックリンク：
    - `libmylib.so.1 -> libmylib.so.1.0.0`
    - `libmylib.so -> libmylib.so.1`


- ランタイムでのロード
  - 実行ファイルは`libmylib.so.1`を要求する（SONAME）。
  - 動的リンカ（`ld-linux`）が実行時に`/lib`, `/usr/lib`, `LD_LIBRARY_PATH`などから探す。


## PICとは？

PIC（Position Independent Code）とはコードがどのアドレスに配置されても動くようになっているコード。  
共有ライブラリは実行ファイルが実行されたときに動的にロードされるため、コードの配置が動的に決まる。
つまり、毎実行のたびにアドレスが変わるため、アドレスに依存していた場合動かなくなる。  

これを回避するために、変数や関数の参照は絶対アドレスではなく、相対アドレスで扱うようにする。
`gcc`では、`gcc -fPIC -c foo.c`で作られたオブジェクトファイルはPICになる。  
さらに、共有ライブラリには、`gcc -shared -o libfoo.so foo.o`で作成できる。  

ちなみに、補足としてLinuxでは実行ファイルと共有ライブラリはロードされるアドレスが毎回ランダム化される。  
これはセキュリティのため。なので、PICでないと共有ライブラリは使うことができない。  

ちなみに、PICと混同しやすい概念として、PIE（Position independent Executable）がある。  
これは、位置が独立な実行ファイル。`gcc -fPIE -pie main.c -o main`で作成される。  
PIEにすると、実行ファイル自身がASLRの影響でメモリ位置をランダム化できる。最近はデフォルトで有効になっている。  

PICは共有ライブラリに対する概念に対して、  
PIEは実行ファイルに対して使われる概念。  


## gcc -Wl オプションとは？

`-Wl`オプションはリンカーにオプションを指定するためのオプション。  
通常は、`gcc`でリンカーがラッパーされているため、気にしなくてもいいが、オプション指定をする必要がある場合は、
`-Wl,xxxx`でリンカーに対するオプションを指定する。リンカーへのオプションは`xxxx`になる。


## -soname とは

`SONAME`は共有ライブラリの内部名のこと。実行ファイルがライブラリを参照するときに確認する名前。  
`gcc -Wl,-soname,XXX`で指定される。  

このとき、`libmylib.so.1`が主に埋め込まれる。  
それぞれの名称との関係性。  
```txt
libmylib.so            ← 開発時に使う名前（シンボリックリンク）
libmylib.so.1          ← SONAME（実行ファイルが参照する名前）
libmylib.so.1.2.3      ← 実ファイル名
```


## 利用・テスト

- 一時的にカレントディレクトリから読み込ませる：
  ```sh
  export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH
  gcc main.c -L. -lmylib -o main
  ./main
  ```

- デバッグ用に`ldd ./main`でどの`.so`にリンクしているか確認。


## 練習アイデア

先ほど作った静的ライブラリを、共有ライブラリ版にしてみる。
SONAME を変えたときの動作（古い実行ファイルがどの .so を探すか）を確認する。



