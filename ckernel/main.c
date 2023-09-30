#include "data.h"

char getchar(int x, int y) { return *(char *)(753664 + 2 * (y * 80 + x)); }
char getcolor(int x, int y) { return *(char *)(753664 + 2 * (y * 80 + x)) + 1; }
void putcolor(int x, int y, char Color) {
  *(char *)(753664 + 2 * (y * 80 + x) + 1) = Color;
}

void putcharacter(int x, int y, char Char) {
  *(char *)(753664 + 2 * (y * 80 + x)) = Char;
}

void putchar(int x, int y, char Char, char Color) {
  putcharacter(x, y, Char);
  putcolor(x, y, Color);
}

void puts(char *string, int starting_x, int len, int y, char color) {
  for (int x = 0; x < len; x++)
    putchar(x + starting_x, y, string[x], color);
}

void print_matrix_line(int x, int head, int t, int tail, char ch, char color) {
  int matrix_head = 1024 - t - head;
  int matrix_tail = 1024 - t - tail;
  if (matrix_head >= 0)
    if (matrix_head <= 25) {
      putchar(x, matrix_head, ch, 15);
      if (matrix_head > 0)
        putcolor(x, matrix_head - 1, color);
    }
  if (matrix_tail >= 0)
    if (matrix_tail <= 25)
      putchar(x, matrix_tail, ' ', 0x0);
}

void kmain(int t) {
  for (int i = 0; i < 80; i++)
    for (int j = 0; j < 10; j++)
      print_matrix_line(i, columns[(i * 10 + j) * 2], t,
                        columns[(i * 10 + j) * 2 + 1], 35 + t % 12, 0x0a);

  char str[] = "  Welcome to the Matrix  ";
  char st1[] = "                         ";
  int x = 40 - sizeof(str) / 2;
  puts(st1, x, sizeof(str), 10, 0x20);
  puts(st1, x, sizeof(str), 11, 0x20);
  puts(str, x, sizeof(str), 12, 0x20);
  puts(st1, x, sizeof(str), 13, 0x20);
  puts(st1, x, sizeof(str), 14, 0x20);
}
