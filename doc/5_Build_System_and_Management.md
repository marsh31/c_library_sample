# ビルドシステム＆依存関係管理

規模が大きくなると、毎回手で gcc を叩くのは限界が来ます。  
そのため、多くの場合は`Makefile`などのビルド自動化やより現代的な`Cmake`, `Meson`などの導入を行います。  
またパッケージ管理も複雑になっていくことから、`pkg-config`などを利用します。  

## Makefile の導入

- 目的：
  - make でビルド・クリーンを自動化。

- 学ぶ内容：
  - 変数 (CC, CFLAGS, LDFLAGS, LIBS)
  - ルール、依存関係、パターンルール

例：静的/共有ライブラリをビルドするための簡易 Makefile を書いてみる。


## pkg-config ファイル（.pc）の理解

- 自作ライブラリを他人に使ってもらいやすくするため：
  - `mylib.pc` を用意し、`pkg-config` から使えるようにする。

- 中身に書くこと：
  - `prefix`, `includedir`, `libdir`
  - `Cflags`, `Libs`, `Requires` など


## CMake / Meson などのモダンビルドシステム

- ざっくり知るレベルから：
  - CMake の `add_library`, `target_include_directories`, `target_link_libraries`
  - install ルールで`/usr/local`に配置する方法

