# Санітайзери ЛИШАЮТЬСЯ ввімкненими (вимога курсу).
CXX      ?= g++
CXXFLAGS  = -std=c++17 -Wall -Wextra -Wpedantic -g -O0 -fsanitize=address,undefined -fno-omit-frame-pointer
SRC       = ember/cpu.cpp ember/memory.cpp ember/hexdump.cpp

all: ember_bin asan_demo_bin

ember_bin: $(SRC) ember/main.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^

asan_demo_bin: ember/asan_demo.cpp ember/memory.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^

check: ember_bin
	./ember_bin --echo < checks/lab-03.txt > /tmp/lab03.out
	diff -u checks/lab-03.expected.txt /tmp/lab03.out && echo "checks/lab-03: OK"

clean:
	rm -f ember_bin asan_demo_bin
