# インストール・ディレクトリ構成・バージョン管理

## Linuxでの標準的な配置

- 一般的なパス（手動 or `make install`で入れる場所）：
  - ライブラリ：`/usr/local/lib` or `/usr/lib`
  - ヘッダ：`/usr/local/include` or `/usr/include`
  - pkg-config：`/usr/local/lib/pkgconfig` など

- `ldconfig` の役割：
  - `/etc/ld.so.conf`や`/etc/ld.so.conf.d/*`に記載されたパスからライブラリをスキャンし、
    `/etc/ld.so.cache` を更新。


## 自作ライブラリのインストール

- 練習：
  1. libmylib.so.1.0.0 を /usr/local/lib に配置し、適切な symlink を張る。
  2. mylib.h を /usr/local/include に置く。
  3. sudo ldconfig を実行。
  4. 別プロジェクトから #include <mylib.h> + -lmylib で使ってみる。


## パッケージ化（必要であれば）

- さらに踏み込む場合：
  - Debian 系なら .deb
  - RedHat 系なら .rpm

