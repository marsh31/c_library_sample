# ライブラリとは何か

## この段階でやること

- キーワード：
  - `object file`, `linker`, `static library`, `shared library`, `symbol`

- 簡単に gcc でコンパイル＆リンクを体験する：
  ```sh
  gcc -c main.c      # コンパイル（.o生成）
  gcc main.o -o main # リンク（実行ファイル生成
  ```

## 何を理解するべきか？

- ライブラリの役割
  - よく使う処理を再利用するためのコード集。
  - 呼び出し側はヘッダ (`.h`) をインクルードし、実体はライブラリに置く。

- 静的ライブラリ（static library）
  - 拡張子：`libxxx.a`
  - リンク時に実行ファイルの中に取り込まれる。
  - 実行ファイル単体で動くが、サイズは大きくなる。

- 共有ライブラリ（shared / dynamic library）
  - 拡張子：`libxxx.so`
  - 実行時に動的リンクされる。
  - 複数のプログラムで共有でき、更新しやすい。

- リンカの役割
  - オブジェクトファイル(`.o`)とライブラリを組み合わせて実行ファイルを作る。
  - Linux では`ld`(リンカー)を`gcc`がラップしている。


## 実践

本リポジトリの構成は以下のようになっている。  
`(generated)`はCloneしたときには存在しない。ルートで`make`を実行することで作成される。  
このとき、`src/bar.c`、`src/foo.c`がビルドされて`build`フォルダにオブジェクトファイルが作成される。  
その後、作成されたオブジェクトファイルから`lib/libmylib.a`、`lib/libmylib.so`が作成される。  
作成ルールは`Makefile`のビルドルールを参照。

```txt
.
├── build           (generated)
│   ├── bar.o
│   └── foo.o
├── include
│   └── mylib.h
├── lib             (generated)
│   ├── libmylib.a
│   └── libmylib.so
├── src
│   ├── bar.c
│   └── foo.c
├── examples
│   ├── Makefile
│   └── main.c
└── Makefile
```

ライブラリを使うときにはどうするか？  
`examples`フォルダの`main.c`と`Makefile`に記載している。  
使う側の`main.c`は`#include "mylib.h"`を記述することでライブラリの関数を利用することができる。  

`Makefile`にはもう少し記述する必要がある。  
静的ライブラリを使用するときの記述を全体から抜粋した。  

`CFLAGS`に`-I../include`を記述している。これはコンパイラがライブラリのヘッダーファイルを見つけられるように
指定をしてあげる。指定しない場合、見つからないため、エラーとなる。  
`LDLIBS_STATIC`で`../lib/libmylib.a`を指定しているが、これはリンク時に静的ライブラリを結合するために必要。  

```make
CFLAGS  := -Wall -Wextra -O2 -I../include
LDLIBS_STATIC  := ../lib/libmylib.a

$(TARGET_STATIC): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS_STATIC) $(LDLIBS_STATIC)
```

