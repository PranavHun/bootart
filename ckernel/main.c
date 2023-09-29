
void putchar(int x, int y, char Char, char Color) {
  *(char *)(753664 + 2 * (y * 80 + x)) = Char;
  *(char *)(753664 + 2 * (y * 80 + x) + 1) = Color;
}

void strcpy(char *dest, const char *src, int len) {
  for (int i = 0; i < len; i++)
    *(dest + i) = *(src + i);
}

void puts(char *string, int starting_x, int y, char color) {
  for (int x = 0; x < 5; x++)
    putchar(x + starting_x, y, string[x], 0x0A);
}

void kmain(unsigned x, unsigned y) {
  unsigned start_x = x;
  char string[] = "Welco";
  puts(string, start_x, y, 0x0A);
  start_x += 5;

  strcpy(string, "me to", 5);
  puts(string, start_x, y, 0x0A);
  start_x += 5;

  strcpy(string, " the ", 5);
  puts(string, start_x, y, 0x0A);
  start_x += 5;

  strcpy(string, "Matri", 5);
  puts(string, start_x, y, 0x0A);
  start_x += 5;

  strcpy(string, "x!!! ", 5);
  puts(string, start_x, y, 0x0A);
  start_x = x;

  strcpy(string, "-----", 5);
  puts(string, start_x, y + 1, 0x0A);
  start_x += 5;
  strcpy(string, "-- --", 5);
  puts(string, start_x, y + 1, 0x0A);
  start_x += 5;
  strcpy(string, " --- ", 5);
  puts(string, start_x, y + 1, 0x0A);
  start_x += 5;
  strcpy(string, "-----", 5);
  puts(string, start_x, y + 1, 0x0A);
  start_x += 5;
  strcpy(string, "---- ", 5);
  puts(string, start_x, y + 1, 0x0A);
  start_x += 5;
  start_x = x;
  strcpy(string, "    ", 5);
  puts(string, start_x, y + 2, 0x0A);
  start_x += 5;
  strcpy(string, "    ", 5);
  puts(string, start_x, y + 2, 0x0A);
  start_x += 5;
  strcpy(string, "    ", 5);
  puts(string, start_x, y + 2, 0x0A);
  start_x += 5;
  strcpy(string, "    ", 5);
  puts(string, start_x, y + 2, 0x0A);
  start_x += 5;
  strcpy(string, "    ", 5);
  puts(string, start_x, y + 2, 0x0A);
  start_x += 5;

  /*
  char arr[17];
  arr[16] = 0;
  arr[0] = 'W';
  arr[1] = 'e';
  arr[2] = 'l';
  arr[3] = 'c';
  arr[4] = 'o';
  arr[5] = 'm';
  arr[6] = 'e';
  arr[7] = ' ';
  arr[8] = 't';
  arr[9] = 'o';
  arr[10] = ' ';
  arr[11] = 'T';
  arr[12] = 'h';
  arr[13] = 'e';
  arr[14] = ' ';
  arr[15] = 'M';

  for (int i = 0; i < 16; i++)
    putchar(i, 0, arr[i], 0x02);

  arr[0] = 'a';
  arr[1] = 't';
  arr[2] = 'r';
  arr[3] = 'i';
  arr[4] = 'x';
  arr[5] = '!';
  arr[6] = '!';
  arr[7] = '!';
  arr[8] = '!';
  arr[9] = '!';
  arr[10] = '!';
  arr[11] = '!';
  arr[12] = '!';
  arr[13] = '!';
  arr[14] = '!';
  arr[15] = '!';
  arr[16] = 0;
  for (int i = 0; i < 16; i++)
    putchar(i + 16, 0, arr[i], 0x02);

  */
}

// >>> text_to_arr = lambda s,b,e: "\n".join([f"arr[{i}] = '{x}';" for i,x in
// enumerate(s[b:e])])
// >>> print(text_to_arr("Welcome to the Matrix",0,16))
// arr[0] = 'W';
// arr[1] = 'e';
// arr[2] = 'l';
// arr[3] = 'c';
// arr[4] = 'o';
// arr[5] = 'm';
// arr[6] = 'e';
// arr[7] = ' ';
// arr[8] = 't';
// arr[9] = 'o';
// arr[10] = ' ';
// arr[11] = 't';
// arr[12] = 'h';
// arr[13] = 'e';
// arr[14] = ' ';
// arr[15] = 'M';
// >>> print(text_to_arr("Welcome to the Matrix",16,21))
// arr[0] = 'a';
// arr[1] = 't';
// arr[2] = 'r';
// arr[3] = 'i';
// arr[4] = 'x';
// >>>