# 学習順序のまとめ（チェックリスト風）

1. ライブラリの種類と役割を説明できる  
  - 静的 / 共有ライブラリの違い  
  - リンカの役割  

2. 既存ライブラリをリンクして使える  
- `gcc main.c -lm`の意味  
- `-L`, `-I`, `-l`が使える  
- `pkg-config`の基本がわかる  

3. 静的ライブラリを自作して使える  
  - `ar rcs libxxx.a`の意味がわかる  
  - `.h`を書いて別プロジェクトから利用できる  

4. 共有ライブラリを自作して動かせる  
  - `-fPIC`, `-shared`, `-Wl`,`-soname` の意味  
  - `LD_LIBRARY_PATH` や `ldd` で確認できる  

5. Makefile やビルドシステムでビルドを自動化できる  
  - 簡単な Makefile  
  - （余力があれば）CMake / Meson の基本  

6. インストール・配布の流れがイメージできる  
  - `/usr/local/lib`, `/usr/local/include`  
  - `ldconfig`  
  - `.pc` ファイル  

7. 上級トピックのキーワードを知っている  
  - ABI, SONAME, シンボル可視性, dlopen, スレッドセーフ  
