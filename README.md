# b2an88b.rb

NEC PC-8801 シリーズの N88 DISK-BASIC では、save "filename" で保存すると中間コードに変換されたバイナリファイルで保存される。コマンドの最後に 「,a」をつけて保存すればアスキーコードで保存される。

実機からエミュレータ環境に保存しているので、できれば BASIC プログラムはテキストファイルで閲覧できる状態で残しておきたい。

アスキーセーブしなおせば、それでも事足りるのだが、せっかくなのでプログラムで一括処理してみることにした。

## 使い方

あらかじめ .D88 フロッピーディスクイメージファイルから個別のファイルを取り出してあることが前提。[L3ディスクエクスプローラ(L3 Disk Explorer)](http://s-sasaji.ddo.jp/bml3mk5/) を使用すると .BAS を末尾に付加してエクスポートしてくれる。

    ruby b2an88b.rb [path|file]

path を指定しないとカレントフォルダで .BAS もしくは .bas ファイルを検索して処理。
path を指定すれば、そのフォルダ内で該当ファイルを検索。
個別のファイル名を指定すれば、そのファイルだけを処理。

出力先は原則処理ファイルのあるフォルダに .asc を末尾に追加して保存。

ファイルが壊れていたりして正常に処理できなかったときには、エラー表示をして .asc ファイルは削除。

    offset: xx00 /file/path

と表示されるときは、行頭のリンクポインタにオフセット値が設定されていた場合に表示。

## 備考

### 中間コードファイルの構造。
先頭２バイトはリンクポインタ。
続く２バイトは行番号。
次からは１バイトずつ読み、それによって続くバイトの取得数が変化する。
80H から FFH までは基本 BASIC コマンドを割り振ったもの。
FFH は続く１バイトが 80H 以降の場合に拡張されたコマンドを示す。
行の終わりは 00H。

### 特殊な 3AH パターン
3AH そのものは「:」。
3A8FE9H は、「'」。
3A9FH は中間コードの ELSE (9FH)。

### 特殊なリンクポインタ
オフセット値がついている場合がある。


### アスキーファイルの構造
行の終わりに 0D0AH をつける必要がある。これがないと行番号のないファイルとみなされる。

### PC-8801 のフロッピーディスクイメージを取得する
PC-8801 と Windows（95 から XP くらいまで） マシンとをリバースのシリアルケーブルで接続。
[project M88](http://retropc.net/cisc/m88/) から転送用ソフト xdisk2 を用意。（GUI で使いたい場合は、XDISKWIN2 を[80mkII愛友会](http://www5f.biglobe.ne.jp/~apaslothy/)から別に入手。 ）
使い方テキストに準じて Windows マシンから 88 に転送用プログラムを送り込み、実行。
Windows 側から必要な処理を実行。