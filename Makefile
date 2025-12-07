#==============================================
# 設定部分
CC           := gcc
CFLAGS       := -Wall -Wextra -O2 -fPIC -Iinclude
AR           := ar
ARFLAGS      := rcs

SRCS         := $(wildcard src/*.c)
OBJS         := $(SRCS:src/%.c=build/%.o)

LIB_DIR      := lib
BUILD_DIR    := build
LIB_STATIC   := $(LIB_DIR)/libmylib.a
LIB_SHARED   := $(LIB_DIR)/libmylib.so


# デフォルトターゲット
.PHONY: all
all: $(LIB_STATIC) $(LIB_SHARED)


#==============================================
# ビルドルール

# .c -> .o
$(BUILD_DIR)/%.o: src/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# static library
$(LIB_STATIC): $(OBJS) | $(LIB_DIR)
	$(AR) $(ARFLAGS) $@ $^

# shared library
$(LIB_SHARED): $(OBJS) | $(LIB_DIR)
	$(CC) -shared -o $@ $^


#==============================================
# ディレクトリ作成
$(BUILD_DIR):
	mkdir -p $@

$(LIB_DIR):
	mkdir -p $@


#==============================================
# clean
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(LIB_DIR)


#==============================================
# サンプルプログラムのビルド
.PHONY: examples
examples: all
	$(MAKE) -C examples
