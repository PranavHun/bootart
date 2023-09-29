
void putchar(int x, int y, char Char, char Color) {
  *(char *)(753664 + 2 * (y * 80 + x)) = Char;
  *(char *)(753664 + 2 * (y * 80 + x) + 1) = Color;
}

void puts(char *string, int starting_x, int len, int y, char color) {
  for (int x = 0; x < len; x++)
    putchar(x + starting_x, y, string[x], 0x0A);
}

void print_matrix_line(int x, int head_start, int t, int len, char ch,
                       char color) {
  int matrix_head = 1024 - t - head_start;
  int matrix_tail = matrix_head - len;
  if (matrix_head > 0)
    if (matrix_head < 25) {
      putchar(x, matrix_head, ch, color);
      putchar(x, matrix_head + 1, ch, 15);
    }
  if (matrix_tail >= 0)
    if (matrix_tail < 25)
      putchar(x, matrix_tail, ' ', 0x0);
}

void kmain(int t) {
  // head = [np.random.randint(x*10, (x+1)*10) for x in range(0, 100)]
  // len = [np.random.randint(5, 30) for x in range(0, 100)]
  int thread_heads[] = {
      180, 793, 422, 8,   458, 271, 155, 93,  372, 62,  804, 659, 384, 777, 394,
      892, 177, 19,  119, 842, 77,  26,  139, 245, 750, 166, 553, 55,  720, 294,
      83,  430, 360, 546, 93,  811, 414, 488, 316, 575, 50,  307, 527, 11,  471,
      448, 198, 333, 80,  714, 127, 626, 216, 100, 144, 619, 507, 513, 497, 49,
      351, 870, 347, 682, 707, 644, 568, 269, 21,  409, 677, 823, 585, 690, 68,
      461, 838, 858, 609, 765, 862, 73,  667, 747, 204, 282, 34,  737, 535, 633,
      880, 233, 597, 226, 42,  789, 36,  255, 325, 1};
  int thread_lens[] = {
      24, 20, 29, 14, 10, 23, 16, 15, 20, 23, 29, 17, 11, 25, 28, 28, 19,
      13, 24, 22, 29, 9,  7,  13, 14, 20, 12, 15, 24, 5,  22, 18, 22, 8,
      22, 23, 24, 5,  7,  7,  8,  12, 20, 15, 22, 5,  27, 27, 18, 27, 9,
      16, 12, 12, 20, 11, 10, 13, 6,  21, 16, 5,  22, 18, 18, 21, 20, 11,
      29, 8,  10, 29, 20, 17, 8,  9,  13, 11, 9,  29, 21, 21, 29, 26, 8,
      17, 18, 22, 17, 27, 14, 14, 27, 20, 24, 17, 29, 26, 13, 19};

  for (int x = 0; x < 80; x++)
    print_matrix_line(x, thread_heads[x], t, thread_lens[x], 35 + t % 12, 0x0a);

  char str[] = "!! Welcome to the Matrix !!";
  char st1[] = "   ------- -- --- ------   ";
  int x = 40 - sizeof(str) / 2;
  puts(str, x, sizeof(str), 12, 0x02);
  puts(st1, x, sizeof(str), 13, 0x02);

  /*  for (int i = 0; i < sizeof(str) - 1; i++) {
      putchar(i + x, 12, str[i], 0x02);
      if (str[i] != ' ')
        putchar(i + x, 13, '-', 0x02);
    }
    */
  /*
  for (int i = 0; i < sizeof(str); i++)
    putchar(i + x, y + 2, ' ', 0x02);
  */
}
