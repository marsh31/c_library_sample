CC      := gcc
CFLAGS  := -Wall -Wextra -O2 -I../include

# shared 用
LDFLAGS_SHARED := -L../lib -Wl,-rpath,'$$ORIGIN/../lib'
LDLIBS_SHARED  := -lmylib

# static 用
LDFLAGS_STATIC :=
LDLIBS_STATIC  := ../lib/libmylib.a

TARGET_SHARED := example_shared
TARGET_STATIC := example_static
SRCS          := main.c
OBJS          := $(SRCS:.c=.o)

.PHONY: all
all: $(TARGET_SHARED) $(TARGET_STATIC)

$(TARGET_SHARED): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS_SHARED) $(LDLIBS_SHARED)

$(TARGET_STATIC): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS_STATIC) $(LDLIBS_STATIC)

.PHONY: clean
clean:
	rm -f $(TARGET_SHARED) $(TARGET_STATIC) $(OBJS)
